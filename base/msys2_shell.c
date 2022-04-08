#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int
strpos(char *str, char *target)
{
   char *res = strstr(str, target);

   return res == NULL ? -1 : res - str;
}

int
main(int argc, char *argv[])
{
    char *cmdline = malloc(sizeof(char) * 32768);
    char *cmdline_ro = cmdline;
    char *msys_home = getenv("MSYS_HOME");
    int i;

    cmdline += sprintf(cmdline, "%s\\msys2_shell.cmd -mingw64 -no-start -defterm -here -full-path -c ", msys_home);
    switch (argc)
    {
        case 0:
        case 1:
            break;

        case 2:
            if (strpos(argv[1], "\"") != 0 && strpos(argv[1], " ") > 0)
            {
                cmdline += sprintf(cmdline, "\"%s\"", argv[1]);
            }
            else
            {
                cmdline += sprintf(cmdline, "%s", argv[1]);
            }
            break;

        default:
            cmdline += sprintf(cmdline, "%s", "\"");

            for (i = 1; i < argc - 1; i++)
            {
                cmdline += sprintf(cmdline, "%s ", argv[i]);
            }

            cmdline += sprintf(cmdline, "%s\"", argv[i]);
            break;
    }

#if DEBUG
    printf("<%s>\n", cmdline_ro);
#endif
    system(cmdline_ro);

    free(cmdline_ro);

    return EXIT_SUCCESS;
}