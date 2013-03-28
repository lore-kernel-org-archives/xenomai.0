MIME-Version: 1.0
Date: Thu, 28 Mar 2013 18:00:53 -0400
Message-ID: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] patch to src/utils/can/rtcansend.c to support data from a
	file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When sending a large number of CAN messages from a script (in our case, to
initialize a servo), rtcansend can be somewhat slow because every message
requires a setup and teardown.

I added a --file flag to rtcansend which allows you to instead read bytes
from a file (or stdin, using '-' as the filename). The file has one CAN
message per line, in the same format (space-separated) as it would have
been in the can-msg on the command line. Blank lines are ignored. Lines
which start with a ' ' (space) or '#' (hash) character are ignored. If a
filename is given, any can-msg specified on the command line is ignored.

I hope this of use to someone, and it'd be really great if this could be
merged!

Thanks,
Daniel

https://gist.github.com/dmd/5267158 and inlined here:

--- xenomai-2.6.2.1/src/utils/can/rtcansend.c 2013-01-22 14:37:05.000000000
-0500
+++ robot4/crob/rtcansendmulti.c 2013-03-28 17:47:21.436106822 -0400
@@ -1,4 +1,5 @@
 #include <stdio.h>
+#include <string.h>
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
@@ -18,9 +19,10 @@
 static void print_usage(char *prg)
 {
     fprintf(stderr,
-    "Usage: %s <can-interface> [Options] <can-msg>\n"
+    "Usage: %s <can-interface> [Options] [<can-msg>]\n"
     "<can-msg> can consist of up to 8 bytes given as a space separated
list\n"
     "Options:\n"
+    " -f, --file=FILENAME   file to read bytes from instead of the command
line. one list per line.\n"
     " -i, --identifier=ID   CAN Identifier (default = 1)\n"
     " -r  --rtr             send remote request\n"
     " -e  --extended        send extended frame\n"
@@ -45,7 +47,7 @@
 static nanosecs_rel_t timeout = 0;
 static struct can_frame frame;
 static struct sockaddr_can to_addr;
-
+const char* input_filename = NULL;

 void cleanup(void)
 {
@@ -127,6 +129,7 @@

     struct option long_options[] = {
  { "help", no_argument, 0, 'h' },
+ { "file", required_argument, NULL, 'f'},
  { "identifier", required_argument, 0, 'i'},
  { "rtr", no_argument, 0, 'r'},
  { "extended", no_argument, 0, 'e'},
@@ -148,15 +151,20 @@

     frame.can_id = 1;

-    while ((opt = getopt_long(argc, argv, "hvi:l:red:t:cp:sL:",
+    while ((opt = getopt_long(argc, argv, "hvi:l:red:t:cp:sL:f:",
       long_options, NULL)) != -1) {
  switch (opt) {
  case 'h':
     print_usage(argv[0]);
     exit(0);

+ case 'f':
+    input_filename = optarg;
+    break;
+
  case 'p':
     print = strtoul(optarg, NULL, 0);
+    /* fall through */

  case 'v':
     verbose = 1;
@@ -263,18 +271,6 @@
  }
     }

-    if (count)
- frame.can_dlc = sizeof(int);
-    else {
- for (i = optind + 1; i < argc; i++) {
-    frame.data[dlc] = strtoul(argv[i], NULL, 0);
-    dlc++;
-    if( dlc == 8 )
- break;
- }
- frame.can_dlc = dlc;
-    }
-
     if (rtr)
  frame.can_id |= CAN_RTR_FLAG;

@@ -298,7 +294,49 @@
  goto failure;
     }

-    rt_task();
+    if (input_filename != NULL) {
+ if (!strcmp(input_filename, "-"))
+    input_filename = "/dev/stdin";
+
+ FILE *file = fopen(input_filename, "r");
+
+ if (file != NULL) {
+    char line [1024];
+    while (fgets(line, sizeof line, file) != NULL) {
+ // put the data into frame
+ char * pch;
+ if (line[0] == '#' || line[0] == ' ' || line[0] == '\n') continue;
+ pch = strtok(line, " ");
+ dlc = 0;
+ while ((pch != NULL) && (dlc < 8)) {
+    frame.data[dlc] = strtoul(pch, NULL, 0);
+    pch = strtok(NULL, " ");
+    dlc++;
+ }
+ frame.can_dlc = dlc;
+ rt_task();
+    }
+    fclose(file);
+ }
+ else {
+    perror(input_filename);
+    goto failure;
+ }
+    }
+    else {
+ if (count)
+    frame.can_dlc = sizeof(int);
+ else {
+    for (i = optind + 1; i < argc; i++) {
+ frame.data[dlc] = strtoul(argv[i], NULL, 0);
+ dlc++;
+ if( dlc == 8 )
+    break;
+    }
+    frame.can_dlc = dlc;
+ }
+ rt_task();
+    }

     cleanup();
     return 0;
