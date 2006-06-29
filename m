From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17571.64751.401752.154881@domain.hid>
Date: Thu, 29 Jun 2006 18:16:47 +0200
Subject: Re: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2
In-Reply-To: <02AA386EB831044F8537A696BA785C78A6676A@ILEX5.IL.NDS.COM>
References: <02AA386EB831044F8537A696BA785C78A6676A@ILEX5.IL.NDS.COM>
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
 > I'm using Xenomai 2.2 rc2 on an MPC8247 board.

You should be using 2.2 rc3, it implements per-process cleanup, so even
if pthread_mutex_destroy fails, if the mutex is not shared between
several processes, it will automatically be destroyed when the
application terminates.

 > When I try to destroy a mutex I get error x10 (EBUSY).
 > The mutex is not locked. 

EBUSY is also returned if the mutex is currently "bound" to a condition
variable, that is, if some thread is currently blocked in a call to
pthread_cond_wait using the mutex as second argument. In this case, the
application is expected to cancel the thread blocked in the call to
pthread_cond_wait, the said thread is expected to have
pthread_cleanup_pushed a cleanup function unlocking the mutex. Only then
the application can destroy the mutex with pthread_mutex_destroy.

When I run the same code with the regular pthreads library the function does not return an error.
 > Is this a Xenomai bug?

Maybe, maybe not. Could you provide a small program showing the bug ?

-- 


					    Gilles Chanteperdrix.

