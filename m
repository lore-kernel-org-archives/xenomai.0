Message-ID: <4F3BD76C.1040703@domain.hid>
Date: Wed, 15 Feb 2012 10:03:56 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050401020500020303080608"
Subject: [Xenomai-help] signal handling in Xenomai 2.6.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050401020500020303080608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am not able to block signals using pthread_sigmask or sigprocmask on my Xenomai 2.6.0 system.  If I compile my test program without Xenomai, it works as I intended and blocks the requested signals.  If I compile it for Xenomai, the requested signals are not blocked.  After scratching my head for some time, I tried running the program on an older machine running Xenomai 2.5.5.2, and it worked as I intended and blocked the requested signals.  I have not tried upgrading the Xenomai 2.5.5.2 machine to 2.6.0 to see if the problem is somehow related to the hardware on the newer machine.  I haven't noticed any other problems with Xenomai 2.6.0 on the newer machine; the latency and performance appear to be what I would expect.

My test program is attached.  I printed the current thread in the signal handler, and thought that the output might be of interest.  This is output from the program running under Xenomai 2.6.0:

   $ ./sigtest
   main thread: 7f6ff32c8700
   mlockall returned 0
   sigaction returned 0
   pthread_sigmask returned 0
   ^Csignal handled in: 7f6ff32f2700
   end of main
   $

If I comment out the call topthread_sigmask, I get this output:

   $ ./sigtest
   main thread: 7f446ba09700
   mlockall returned 0
   sigaction returned 0
   pthread_sigmask returned 0
   ^Csignal handled in: 7f446ba09700
   end of main
   $

It appears to me that in the first case, the signal is being blocked in the main thread, but is being handled in another (shadow?) thread.

Can someone confirm that this code works on Xenomai 2.6.0?

Thanks,

Jeff Webb


--------------050401020500020303080608
Content-Type: text/x-csrc;
 name="sigtest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sigtest.c"

#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <sys/mman.h>

sig_atomic_t abort_program = 0;

void signal_handler(int sig)
{
  abort_program = 1;
  printf("signal handled in: %lx\n", pthread_self());
}

int main(void)
{
    int err;
    struct sigaction action;
    sigset_t mask;

    printf("main thread: %lx\n", pthread_self());

    err = mlockall(MCL_CURRENT | MCL_FUTURE);
    printf("mlockall returned %d\n", err);

    action.sa_handler = signal_handler;
    sigemptyset(&action.sa_mask);
    action.sa_flags = 0;
    err = sigaction(SIGINT, &action, NULL);
    printf("sigaction returned %d\n", err);
    
    sigemptyset(&mask);
    sigaddset(&mask, SIGINT);
    err = pthread_sigmask(SIG_BLOCK, &mask, NULL);
    printf("pthread_sigmask returned %d\n", err);    

    while(!abort_program)
    {}

    printf("end of main\n");
  
    return 0;
}

--------------050401020500020303080608--

