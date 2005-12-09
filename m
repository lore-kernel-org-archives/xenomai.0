MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17305.63307.340805.330709@domain.hid>
Date: Fri, 9 Dec 2005 22:29:47 +0100
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities
	-	what I'm doing wrong?
In-Reply-To: <4399E716.8060502@domain.hid>
References: <439995C0.6030006@domain.hid>
	<200512091650.11637.schwab@domain.hid>
	<17305.51026.541872.815402@domain.hid>
	<4399E716.8060502@domain.hid>
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
 > Gilles Chanteperdrix wrote:
 > >Working around this issue means using calls to unlocked versions of libc
 > >functions protected with Xenomai POSIX mutexes, such as, for example,
 > >myputs and myputchar (sufficient for Paolo example) defined as :
 > >[...]
 > >  
 > >
 > Ok! I tried it, and I also tried another slightly modified version of 
 > the demo, that simply replaces putchars with an unprotected array of 
 > chars (let's suppose there are no race conditions) that is printed out 
 > to stdout at the end of the game.

There is no race condition in the SCHED_FIFO case or ahem, there should
be none. Please also note that the "volatile" qualifier seem misplaced
in your declaration of buf_current, it may matter since the compiler
will probably inline calls to myputchar in the "medium" function, and
buf_current will end up in a register. But this would have no effect
only in the SCHED_FIFO case.


 > the results are the following, where the first part is RR and the second 
 > is FIFO (it's quite strange for me that FIFO has more contect changes 
 > than RR (?))

Please also note that any thread created with the SCHED_RR attribute
will be a plain Linux thread, and due to a bug in glibc, the thread will
use the default policy. The results are strange indeed for SCHED_FIFO,
it may be a bug, this needs a closer look... Maybe threads are not
Xenomai threads using SCHED_FIFO policy at all ?

-- 


					    Gilles Chanteperdrix.

