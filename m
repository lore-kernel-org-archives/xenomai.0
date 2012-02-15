Message-ID: <4F3BDC1E.9090707@domain.hid>
Date: Wed, 15 Feb 2012 17:23:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F3BD76C.1040703@domain.hid>
In-Reply-To: <4F3BD76C.1040703@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] signal handling in Xenomai 2.6.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 02/15/2012 05:03 PM, Jeff Webb wrote:
> I am not able to block signals using pthread_sigmask or sigprocmask
> on my Xenomai 2.6.0 system.  If I compile my test program without
> Xenomai, it works as I intended and blocks the requested signals.  If
> I compile it for Xenomai, the requested signals are not blocked.
> After scratching my head for some time, I tried running the program
> on an older machine running Xenomai 2.5.5.2, and it worked as I
> intended and blocked the requested signals.  I have not tried
> upgrading the Xenomai 2.5.5.2 machine to 2.6.0 to see if the problem
> is somehow related to the hardware on the newer machine.  I haven't
> noticed any other problems with Xenomai 2.6.0 on the newer machine;
> the latency and performance appear to be what I would expect.
> 
> My test program is attached.  I printed the current thread in the
> signal handler, and thought that the output might be of interest.
> This is output from the program running under Xenomai 2.6.0:
> 
> $ ./sigtest main thread: 7f6ff32c8700 mlockall returned 0 sigaction
> returned 0 pthread_sigmask returned 0 ^Csignal handled in:
> 7f6ff32f2700 end of main $
> 
> If I comment out the call topthread_sigmask, I get this output:
> 
> $ ./sigtest main thread: 7f446ba09700 mlockall returned 0 sigaction
> returned 0 pthread_sigmask returned 0 ^Csignal handled in:
> 7f446ba09700 end of main $
> 
> It appears to me that in the first case, the signal is being blocked
> in the main thread, but is being handled in another (shadow?)
> thread.
> 
> Can someone confirm that this code works on Xenomai 2.6.0?

Please try the following patch:

diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
index 5533e29..78dcda8 100644
--- a/src/skins/common/rt_print.c
+++ b/src/skins/common/rt_print.c
@@ -612,6 +612,11 @@ static void unlock(void *cookie)

 static void *printer_loop(void *arg)
 {
+	sigset_t mask;
+
+	sigfillset(&mask);
+	pthread_sigmask(SIG_BLOCK, &mask, NULL);
+
 	while (1) {
 		pthread_cleanup_push(unlock, &buffer_lock);
 		pthread_mutex_lock(&buffer_lock);


-- 
					    Gilles.

