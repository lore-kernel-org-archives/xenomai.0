Message-ID: <4EFEC15B.4040807@domain.hid>
Date: Sat, 31 Dec 2011 09:01:31 +0100
From: Christophe Blaess <mailist@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000000090302000304080809"
Subject: [Xenomai-core] [PATCH] Threads without names confuse rtps
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000000090302000304080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If a Xenomai thread is created with a NULL name parameter, this way:


// no-name.c
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

#include <rtdk.h>
#include <native/task.h>

int main(void)
{
       int err;
       RT_TASK task;

       mlockall(MCL_CURRENT|MCL_FUTURE);
       rt_print_auto_init(1);

       if ((err = rt_task_shadow(& task, NULL, 50, T_JOINABLE)) != 0) {
           fprintf(stderr, "rt_task_shadow: %s\n", strerror(-err));
           exit(EXIT_FAILURE);
       }

       while (1)
           rt_task_sleep(1000000000);
       return 0;
}



Then, the rtps display is wrong, because the "name" field in /proc/acct 
is empty:

[Panda]# /usr/xenomai/sbin/rtps
PID    TIME                THREAD                   CMD

0      002:40:47.105,569   ROOT/0                   -
0      002:41:08.762,505   ROOT/1                   -
31267  000:00:00.007,737   1 0 0 40038203 0 00000000 672522999738 
1901211134 27510920737 IR/proc/31267/cmdline ./no-name
[Panda]#


Here is a small patch to correct the reading of /proc/acct in case the 
name is missing. And now:

[Panda]# /root/rtps
PID    TIME                THREAD                   CMD

0      002:46:17.807,037   ROOT/0                   -
0      002:46:39.469,616   ROOT/1                   -
31267  000:00:00.011,491                            ./no-name
0      000:00:28.439,650   IRQ29: [timer]           -
[Panda]#






--------------000000090302000304080809
Content-Type: text/x-patch;
 name="rtps-no-name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rtps-no-name.patch"

diff -Nru xenomai-2.6.0-orig//src/utils/ps/rtps.c xenomai-2.6.0/src/utils/ps/rtps.c
--- xenomai-2.6.0-orig//src/utils/ps/rtps.c	2011-10-18 20:17:18.000000000 +0200
+++ xenomai-2.6.0/src/utils/ps/rtps.c	2011-12-31 08:23:17.435303214 +0100
@@ -7,12 +7,14 @@
 #define PROC_ACCT  "/proc/xenomai/acct"
 #define PROC_PID  "/proc/%d/cmdline"
 
-#define ACCT_FMT   "%u %d %lu %lu %lu %lx %Lu %Lu %Lu %[^\n]"
-#define ACCT_NFMT  10
+#define ACCT_FMT_1  "%u %d %lu %lu %lu %lx %Lu %Lu %Lu"
+#define ACCT_FMT_2  ACCT_FMT_1 " %[^\n]"
+#define ACCT_NFMT_1 9
+#define ACCT_NFMT_2 10
 
 int main(int argc, char *argv[])
 {
-	char cmdpath[sizeof(PROC_PID) + 32], cmdbuf[BUFSIZ], name[64];
+	char cmdpath[sizeof(PROC_PID) + 32], cmdbuf[BUFSIZ], acctbuf[BUFSIZ], name[64];
 	unsigned long ssw, csw, pf, state, sec;
 	unsigned long long account_period,
 		exectime_period, exectime_total, v;
@@ -27,10 +29,19 @@
 	printf("%-6s %-17s   %-24s %s\n\n",
 	       "PID", "TIME", "THREAD", "CMD");
 
-	while (fscanf(acctfp, ACCT_FMT,
+	while (fgets(acctbuf, sizeof(acctbuf), acctfp) != NULL) {
+		if (sscanf(acctbuf, ACCT_FMT_2,
 		      &cpu, &pid, &ssw, &csw, &pf, &state,
 		      &account_period, &exectime_period,
-		      &exectime_total, name) == ACCT_NFMT) {
+		      &exectime_total, name) != ACCT_NFMT_2) {
+			strcpy(name, "");
+			if (sscanf(acctbuf, ACCT_FMT_1,
+			      &cpu, &pid, &ssw, &csw, &pf, &state,
+			     &account_period, &exectime_period,
+			     &exectime_total) != ACCT_NFMT_1) {
+				break;
+			}
+		}
 
 		snprintf(cmdpath, sizeof(cmdpath), PROC_PID, pid);
 		cmdfp = fopen(cmdpath, "r");



--------------000000090302000304080809--

