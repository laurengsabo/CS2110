// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "oh_queue.h"

struct Queue oh_queue;

/** push
 * @brief Create a new student and push him
 * onto the OH queue
 * @param studentName pointer to the student's name
 * @param topicName topic the student has a question on
 * @param questionNumber hw question number student has a question on
 * @param pub_key public key used for calculating the hash for customID
 * @return FAILURE if the queue is already at max length, SUCCESS otherwise
 */
int push(const char *studentName, const enum subject topicName, const float questionNumber, struct public_key pub_key){
    if (oh_queue.stats.no_of_people_in_queue >= 30 || my_strlen(studentName) == 0) {
        OfficeHoursStatus(&oh_queue.stats);
        return FAILURE;
    }

    struct Student newStud;

    my_strncpy(newStud.studentData.name, studentName, MAX_NAME_LENGTH);
    newStud.studentData.name[MAX_NAME_LENGTH - 1] = 0;

    newStud.studentData.topic.topicName = topicName;
    newStud.studentData.topic.questionNumber = questionNumber;

    hash(newStud.customID, newStud.studentData.name, pub_key);
    newStud.queue_number = oh_queue.stats.no_of_people_in_queue;

    oh_queue.students[oh_queue.stats.no_of_people_in_queue] = newStud;
    oh_queue.stats.no_of_people_in_queue++;

    OfficeHoursStatus(&oh_queue.stats);
    return SUCCESS;
}

/** pop
 * @brief Pop a student out the OH queue
 * @return FAILURE if the queue is already at empty, SUCCESS otherwise
 */
int pop(void) {
    if (oh_queue.stats.no_of_people_in_queue == 0) {
        OfficeHoursStatus(&oh_queue.stats);
        return FAILURE;
    }

    int i = 1;
    while (i < oh_queue.stats.no_of_people_in_queue) {
        oh_queue.students[i - 1] = oh_queue.students[i];
        i++;
    }
    oh_queue.stats.no_of_people_in_queue--;
    oh_queue.stats.no_of_people_visited++;
    OfficeHoursStatus(&oh_queue.stats);
    return SUCCESS;
}

/** group_by_topic
 * @brief Push pointers to students, who match the given topic, to
 * the given array "grouped"
 * @param topic the topic the students need to match
 * @param grouped an array of pointers to students
 * @return the number of students matched
 */
int group_by_topic(struct Topic topic, struct Student *grouped[]) { 
    int i = 0;
    int j = 0;

    while (i < oh_queue.stats.no_of_people_in_queue) {
        if (oh_queue.students[i].studentData.topic.questionNumber == topic.questionNumber
                && oh_queue.students[i].studentData.topic.topicName == topic.topicName) {
            grouped[j] = &oh_queue.students[i];
            j++;
        }
        i++;
    }

    return j;
}

/** hash
 * @brief Creates a hash based on pub_key provided
 * @param ciphertext the pointer where you will store the hashed text
 * @param plaintext the original text you need to hash
 * @param pub_key public key used for calculating the hash
 */
void hash(int *ciphertext, char *plaintext, struct public_key pub_key) {
    while (*plaintext) {
	    *ciphertext = power_and_mod(*plaintext, pub_key.e, pub_key.n);
        ciphertext++;
        plaintext++;
    }
    return;
}

/** update_student
 * @brief Find the student with the given ID and update his topic
 * @param customID a pointer to the id of the student you are trying to find
 * @param newTopic the new topic that should be assigned to him
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int update_student(struct Topic newTopic, int *customID) {
    if (oh_queue.stats.no_of_people_in_queue == 0) {
        return FAILURE;
    }
    for (int j = 0; j < oh_queue.stats.no_of_people_in_queue; j++) {
        if (*oh_queue.students[j].customID == *customID) {
            oh_queue.students[j].studentData.topic = newTopic;
            return SUCCESS;
        }
    }
    return FAILURE;
}

/** remove_student_by_name
 * @brief Removes first instance of a student with the given name
 * @param name the name you are searching for
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_name(char *name){
    if (oh_queue.stats.no_of_people_in_queue == 0) {
        OfficeHoursStatus(&oh_queue.stats);
        return FAILURE;
    }
    for (int j = 0; j < oh_queue.stats.no_of_people_in_queue; j++) {
        if (*oh_queue.students[j].studentData.name == *name) {
            int i = j;
            while (i < oh_queue.stats.no_of_people_in_queue - 1) {
                oh_queue.students[i] = oh_queue.students[i + 1];
                i++;
            }
            oh_queue.stats.no_of_people_in_queue--;
            oh_queue.stats.no_of_people_visited++;
            OfficeHoursStatus(&oh_queue.stats);
            return SUCCESS;
        }
    }
    OfficeHoursStatus(&oh_queue.stats);
    return FAILURE;
}

/** remove_student_by_topic
 * @brief Remove all instances of students with the given topic
 * @param topic the topic you are trying to remove from the queue
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_topic(struct Topic topic) {
    if (oh_queue.stats.no_of_people_in_queue == 0) {
        OfficeHoursStatus(&oh_queue.stats);
        return FAILURE;
    }
    int check = 0;
    int i = 0;
    for (int j = 0; j < oh_queue.stats.no_of_people_in_queue; j++) {

        if (oh_queue.students[j].studentData.topic.topicName == topic.topicName 
                && oh_queue.students[j].studentData.topic.questionNumber == topic.questionNumber) {

            int i = j;
            while (i < oh_queue.stats.no_of_people_in_queue - 1) {
                oh_queue.students[i] = oh_queue.students[i + 1];
                i++;
            }
            oh_queue.stats.no_of_people_in_queue--;
            oh_queue.stats.no_of_people_visited++;
            j--;
            check = 1;
        }
        i++;
    }

    if (oh_queue.stats.no_of_people_in_queue == 0) {
        oh_queue.stats.currentStatus = "Completed";
    } else if (oh_queue.stats.no_of_people_in_queue != 0) {
        oh_queue.stats.currentStatus = "InProgress";
    }

    if (check == 1) {
        return SUCCESS;
    }
    return FAILURE;
}

/** OfficeHoursStatus
 * @brief Updates the "currentStatus" field based on
 * whether or not all students in the queue have been helped
 * @param resultStats A pointer the OfficeHoursStats variable
 * you are to update
 */
void OfficeHoursStatus(struct OfficeHoursStats* resultStats ){
    if (oh_queue.stats.no_of_people_in_queue <= 0) {
        resultStats->currentStatus = "Completed";
        return;
    }
    resultStats->currentStatus = "InProgress";
    return;
}

/*
 * Calculates (b^e)%n without overflow
 */
int power_and_mod(int b, int e, int n) {
    long int currNum = 1;
    for (int i = 0; i < e; i++) {
        currNum *= b;
        if (currNum >= n) {
            currNum %= n;
        }
    }
    return (int) (currNum % n);
}
