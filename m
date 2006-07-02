MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17575.59317.183222.418817@domain.hid>
Date: Sun, 2 Jul 2006 17:35:17 +0200
Subject: RE: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2
In-Reply-To: <02AA386EB831044F8537A696BA785C78A66770@domain.hid>
References: <02AA386EB831044F8537A696BA785C78A66770@domain.hid>
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
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

Landau, Bracha wrote:
 > As you suggested, I've upgraded to xenomai 2.2 rc3.
 > I still see the same phenomenon.
 > I'm attaching code that will reproduce the error.
 > (When you ^c out of the main loop, the pthread_cleanup_pop is called, and the call to pthread_mutex_destroy returns 0x10.)

I did not make myself clear... 

I did not meant that 2.2 rc3 would solve your issue, simply that it has
automatic per-process cleanup, so, it does not matter if your
application fail to destroy some condition variables, the condition
variable is destroyed automatically anyway. It is simpler for you to
work with this version as long as the bug you met is not solved.

As for the pthread_cleanup_push/pthread_cleanup_pop, it was meant to be
the solution if the EBUSY had been due to a thread blocked in a call to
pthread_cond_wait during the application cleanup.

I have a look at your code.


-- 


					    Gilles Chanteperdrix.

