#include <8051.h>
#define TEST_PATTERN 0xAA
#define START_ADDR 0x800
#define MEM_SIZE 1024

sbit LED = P1_0;

void main()
{
    unsigned int i;
    bit error_flag = 0;
    char xdata *ptr = (char xdata *)START_ADDR;

    for (i = 0; i < MEM_SIZE; i++)
	{
        *ptr = TEST_PATTERN;
        if (*ptr != TEST_PATTERN)
		{
            error_flag = 1;
            break;
        }
        ptr++;
    }

    LED = error_flag;
    while (1);
}
