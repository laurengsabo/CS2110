/**
 * @file my_string.c
 * @author Lauren Sabo
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-03-26
 */

#include <stddef.h>
#include "my_string.h"
/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    int count = 0;
    while (*s) {
        count++;
        s++;
    }
    return count;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    while (n > 0) {
        if (!*s1 && !*s2) {
            break;
        }
        if (*s1 > *s2) {
            return 1;
        }
        if (*s1 < *s2) {
            return -1;
        }
        s1++;
        s2++;
        n--;
    }
    return 0;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    char *hold = dest;
    while (n > 0) {
        *dest = *src;
        if (!*src) {
            break;
        }
        src++;
        dest++;
        n--;
    }
    return hold;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
    char *hold = dest;
    while (*dest) {
        dest++;
    }
    while (n > 0) {
        *dest = *src;
        if (!*src) {
            break;
        }
        src++;
        dest++;
        n--;
    }
    return hold;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
    char *hold = str;
    while (n > 0) {
        *hold = (char) c;
        hold++;
        n--;
    }
    return str;
}

/**
 * @brief Finds the first instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_first_instance(char *str, char c)
{
    while (*str != c) {
        if (!*str) {
            return;
        }
        str++;
    }
    while (*str) {
        *str = *(str +1);
        str++;
    }
    return;
}

/**
 * @brief Finds the first instance of c in str
 * and replaces it with the contents of replaceStr
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 * @param replaceStr The pointer to the string we are replacing c with
 */
void replace_character_with_string(char *str, char c, char *replaceStr)
{
    if (my_strlen(replaceStr) == 0) {   // solves base case if the replaceStr is empty, the first instance of c will be removed
        remove_first_instance(str, c);
    }

    // other stuff that my brain hurt too much to try to finish. <3 Lauren
    return;
}

/**
 * @brief Remove the first character of str (ie. str[0]) IN ONE LINE OF CODE.
 * No loops allowed. Assume non-empty string
 * @param str A pointer to a pointer of the string
 */
void remove_first_character(char **str) {
    *str += 1;
    return;
}