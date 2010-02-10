Message-ID: <4B72DC76.2070303@domain.hid>
Date: Wed, 10 Feb 2010 17:19:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B72DB97.1020203@domain.hid>
In-Reply-To: <4B72DB97.1020203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnselect_destroy fails to wake up waiters
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Gilles,
> 
> I tend to think that xnselect_destroy should signal an event on the
> dying fd instead of just clearing the binding. The task blocking on
> select currently does not get a hint that the fd is dead and will block
> on select until some other event arrives. That's unfortunately not
> standard conforming.

xnsynch_destroy unblocks the thread normally...


-- 
					    Gilles.

