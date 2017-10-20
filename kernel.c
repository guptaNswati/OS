/**
* main - prints a string on screen with video memory
* Return: Nothing
*/
void main(void)
{
  /* video memory begins at address 0xb8000 */
  char* video_memory = (char*) 0xb8000;
  const char *str = "(see this blank space, its clear screen function) Simple kernel, printing to video memory and overwritting 32 bit protected mode label.\0";
  unsigned int i, j, screensize;

  /* this loops clears the screen
   * there are 25 lines each of 80 columns; each element takes 2 bytes */
  screensize = 80 * 0.1 * 2;
  j = 0;
  while (j < screensize) {
    video_memory[j] = ' '; // blank char
    video_memory[j+1] = 0x07; // color
    j = j + 2;
  }

  // print on screen
  i = 0;
  /* this loop writes the string to video memory */
  while (str[i] != '\0') {
    video_memory[j] = str[i]; // char byte
    video_memory[j+1] = 0x06; // attribute(color) byte
    i = i + 1;
    j = j + 2;
  }
  return;
}
