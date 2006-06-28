Message-ID: <b647ffbd0606280714q142553dag79cd39c4068992e8@domain.hid>
Date: Wed, 28 Jun 2006 16:14:52 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
In-Reply-To: <17570.34620.38518.404171@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060626172116.019532000@domain.hid> <20060626172120.322015000@domain.hid>
	<17570.29185.754625.871443@domain.hid>
	<44A275DE.5080500@domain.hid>
	<17570.34620.38518.404171@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On 28/06/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Jan Kiszka wrote:
>  >
>  > Ok, then we also need a fix for the latency test (this is where I
>  > grabbed that pattern from). Is there a high risk that this locks up? I
>  > wonder why I never observed or heard of problems with latency.
>
> The latency test used to deadlock, that is why the summary printed on
> signal is printed on stderr. Unfortunately, there seem to be one display
> left on stdout, so it should still deadlock. The reason why we never see
> the deadlock is (perhaps) that the continuous intermediate results are
> printed on the context of the "display" thread, whereas the termination
> signals are preferably delivered by the kernel to the "main" thread,
> that only calls pause. Which makes the use of stderr in signals handlers
> pointless.

It's very likely so.

The main thread would use instead something like :
...
while (!sig_term_received)
    pause();

do_cleanup_chores();
return 0;

cleanup_upon_sig() should only set the sig_term_received flag up.

Then all other threads must block signal delivering with sigprocmask()
so that the main thread is the only one which "accepts" signals.

btw, according to POSIX 1003.1-2003, the write() call is amongst "safe" ones.
http://www.die.net/doc/linux/man/man2/signal.2.html

So write(1, ....); heh... not that nice? :)


-- 
Best regards,
Dmitry Adamushko

