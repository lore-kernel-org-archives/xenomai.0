From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17486.10146.597736.78655@domain.hid>
Date: Tue, 25 Apr 2006 15:44:02 +0200
Subject: Re: [Xenomai-help] Posix skin illegal seek on sem_wait
In-Reply-To: <20060425134316.017836e8@domain.hid>
References: <20060425134316.017836e8@domain.hid>
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
 > What makes the difference between a Xenomai thread and an ordinary nptl
 > thread, other than the compilation and linking flags?

The term "Xenomai thread" comes from the document "Life with Adeos":

http://snail.fsffrance.org/www.xenomai.org/documentation/trunk/pdf/Life-with-Adeos-rev-B.pdf

A Xenomai thread is a thread known by Xenomai scheduler. Ordinary
linuxthread or NPTL threads are known by Xenomai scheduler once they
acquire a "shadow" thread.

With the posix skin, an ordinary thread is created with a shadow thread
if you use the pthread_create service with the policy attribute (whether
explicit or inherited) set to SCHED_FIFO, or an ordinary thread may
acquire a shadow thread if this ordinary thread calls the
pthread_setschedparam service passing the value SCHED_FIFO as the policy
argument.

Please also note that for now, signals sent by the timer_* services will
cause migration of the target thread to secondary mode, which means that
the jitter will not be better for Xenomai threads than for ordinary
threads. For good timings, you should use the nanosleep or
clock_nanosleep services, or alternatively the non portable extensions
pthread_make_periodic_np and pthread_wait_np.

For other details about Xenomai implementation of the POSIX API, see:
http://snail.fsffrance.org/www.xenomai.org/documentation/trunk/html/api/group__posix.html

-- 


					    Gilles Chanteperdrix.

