Message-ID: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
Date: Thu, 07 Sep 2017 09:36:29 +0300
From: Andris <andrlv@inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Application command line arguments(parameters) reordering
	problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

   Hi!
   I found that if I build user space application as Xenomai application
   and command line arguments(parameters) have format --parameter-first
   <value> --parameter-second <value> --parameter-X <value> (for example,
   --enable-some-feature 1 --test-period 500), then main function get
   these parameters not in the same order as in command line, but somehow
   reordered.
   As example I will use in Xenomai v3.0.5 included application "latency"
   (xenomai/testsuite/latency/).
   I add in main function some lines to print arguments:
   int main(int argc, char *const *argv)
   {
   struct sigaction sa __attribute__((unused));
   int c, ret, sig, cpu = 0;
   pthread_attr_t tattr;
   cpu_set_t cpus;
   sigset_t mask;
   printf("main: input arguments: argc=%d \n", argc);
   for(int p=0; p<argc; p++)
   printf("main: argv[%d]=%s \n",p,argv[p]);
   .......
   }
   Now, what I get on output:
   1) Pass parameters without "--parameter-name <value>"
   ./latency -p 250 -c 3 -P 90
   main: input arguments: argc=7
   main: argv[0]=/home/install/xenomai/testsuite/latency/.libs/latency
   main: argv[1]=-p
   main: argv[2]=250
   main: argv[3]=-c
   main: argv[4]=3
   main: argv[5]=-P
   main: argv[6]=90
   2) Pass parameters with "--parameter-name <value>" (just pass some
   latency application unsupported parameters)
   ./latency --test-period 500 --enable-some-feature 1
   main: input arguments: argc=5
   main: argv[0]=/home/install/xenomai/testsuite/latency/.libs/latency
   main: argv[1]=--test-period
   main: argv[2]=--enable-some-feature
   main: argv[3]=500
   main: argv[4]=1
   Why main function get these parameters reordered? Is this Xenomai bug?
   System configuration:
   OS: Opensuse 42.2
   kernel: 4.9.24.2
   i-pipe patch: ipipe-core-4.9.24-x86-2.patch
   xenomai: 3.0.5
   gcc: 7.1.1 20170629
   Thanks!
