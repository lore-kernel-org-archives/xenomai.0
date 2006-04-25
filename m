From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17486.18597.13702.446671@domain.hid>
Date: Tue, 25 Apr 2006 18:04:53 +0200
Subject: Re: [Xenomai-help] Posix skin illegal seek on sem_wait
In-Reply-To: <20060425165423.7b7d231b@domain.hid>
References: <20060425134316.017836e8@domain.hid>
	<17486.10146.597736.78655@domain.hid>
	<20060425165423.7b7d231b@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
 > Anyway, my threads are created with the SCHED_FIFO flag; may be there
 > is a conflict with main() which, as I understand, can be only a regular
 > thread?

A thread may only shadow itself, so, pthread_setschedparam has to be
called from the threads that need to be shadowed. Alternatively you may
pass scheduling parameters when pthread_create is called. Your threads
are not really created real-time, this is the reason why the Xenomai
posix skin services you call return an error of EPERM. Note however that
calling pthread_setschedparam is more portable than passing thread
creation attributes to pthread_create.

 > 
 > I notice that timer_settime(...) also returns an error (perror
 > says "Operation not permitted" while errno is set to 29 "illegal
 > seek", as for the sem_wait)
 > 

The reason why you see errno set to ESPIPE, is because you call perror
before printing errno, and perror seems to overwrite errno. In order to
access errno safely, you should store its value immediately after a
service returning an error.

Another issue is that signals sent by Xenomai posix skin are directed to
the thread that issued the call to timer_settime, regardless of threads
signal mask, so timer_settime should be moved to the clock_it()
thread.

A last issue is that pthread_sigmask errors are returned directly, and
not through errno.

-- 


					    Gilles Chanteperdrix.

