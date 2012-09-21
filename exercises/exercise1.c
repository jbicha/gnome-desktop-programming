#include <stdio.h>

gint
main (gint   argc,
      gchar *argv[])
{
    gint age;

    printf ("How old are you?  ");
    scanf ("%d", &age);
    printf ("In three years you will be %d\n", age + 3);

    return 0;
}
