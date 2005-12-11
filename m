MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17308.39770.854381.606918@domain.hid>
Date: Sun, 11 Dec 2005 22:34:18 +0100
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities
	-	what I'm doing wrong?
In-Reply-To: <439AB3B6.2080503@domain.hid>
References: <439995C0.6030006@domain.hid>
	<200512091650.11637.schwab@domain.hid>
	<17305.51026.541872.815402@domain.hid>
	<4399E716.8060502@domain.hid>
	<17305.63307.340805.330709@domain.hid>
	<439AB3B6.2080503@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Paolo Gai wrote:
 > (...)
 > 1) why do i get "pthread_setschedparam failed: Success" ?? Why the 
 > policy is not changed (am I still calling the Linux functions?)

That one is a bug, fixed in the repository: it was due to the fact that
PTHREAD_EXPLICIT_SCHED had different values in /usr/include/pthread.h
and in Xenomai skins/posix/posix.h.

Thanks for pointing this out.


 > 2) The SCHED_FIFO seems to work as expected, whereas SCHED_RR seems to 
 > have a strange behavior when it starts (the low priority thread is 
 > started before the others...

Because threads are started with the SCHED_OTHER policy and only change
their policy once they call pthread_setschedparam. So, if by any chance
the lowest priority thread is elected first, it becomes the only
real-time thread by calling pthread_setschedparam, and since the
mid-priority threads are not real-time yet, it runs before them.


 > 3) the XServer freezes but for a SHORTER time - I guess they are the 
 > Xenomai threads, one thing I do not understand is why with Linux the 
 > XServer stops for around 10 seconds, and in Xenomai less than one second!!!

Because the threads were running with the SCHED_OTHER policy, due to the
bug in pthread_setschedparam.


 > (...)
 > Again, the same behavior as before in Case 1/Xenomai
 > 
 > which make me think that
 > - the behavior on Xenomai does not depend a lot on the fact i called 
 > stdio functions

Yes, my mistake, as required by the standard, glibc pthread mutexes work
as expected for SCHED_FIFO and SCHED_RR policies.


 > - the SCHED_RR maybe still has some problems (???)

SCHED_RR is not supported for Xenomai posix skin user-space
threads. My understanding is that having round-robin scheduling work
with xenomai threads in secondary mode requires changes in
xnpod_announce_tick.

-- 


					    Gilles Chanteperdrix.

