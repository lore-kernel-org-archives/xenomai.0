Message-ID: <2ff1a98a0711160718x57ee9129w2424c1e1a9c4e32d@domain.hid>
Date: Fri, 16 Nov 2007 16:18:35 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB026DBC4E@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <DD39B5C3F4963040ADC9768BE7E430CB026DBC4E@is-hdq-exchange.marel.net>
Subject: Re: [Xenomai-help] Houston,
	we have a problem ... In timed POSIX space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Nov 16, 2007 4:00 PM, Daniel Schnell <daniel.schnell@domain.hid> wrote:
>
>
> Hi,
>
> The attached program demonstrates that mq_timedsend() doesn't work. The sent
> value changes on the way to the receiver.

will check your example ASAP.

 Always! mq_send() works fine.
> Additionally if no asolute timeout value is used, there will be no error
> returned which is contrary to the POSIX standard (however glibc2.3 also
> fails here).

There is no way to make difference between an absolute and relative
timeout. Additionaly, the only constraint I see in the POSIX spec is
that what should be checked is that the tv_nsec member of the timeout
should be less than 1000000000, which Xenomai posix skin does.

>
> Additionally there seem to happen some memory corruption in kernel space as
> I experienced several kernel panic when I restarted the program without
> cleaned up message queues.
>
> This is now the second timer based POSIX bug. Maybe one should take a look
> at the other timeout based POSIX functions before releasing 2.4.0 ?
>
> Also I wonder if there are no regression tests for the skins to show up
> these issues ... E.g. at least for POSIX one could compile LTP POSIX tests
> with Xenomai and let it run ?

There is a testsuite for the posix skin, and last time I checked,
there were no regressions. But it works for the simulator, bugs in the
syscall wrappers do not appear. So, what you are seing is likely a bug
in the syscall wrapper.

I have already tried to run the open posix testsuite, but there is
much work needed to make it run with Xenomai, most tests just lockup
the box because they assume that by default, some round-robin takes
place, which is not the case with Xenomai, so adding some
sched_yield() is necessary. I gave up this work because needed to work
on other subjects.

>
>
> Xenomai 2.4-rc6 + Denx Kernel 2.6.23 commit ID
> 56db4bb9f67fda46e204b93f119742b626a683d1
>
> Best regards,
>
> Daniel Schnell
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>



-- 
                                               Gilles Chanteperdrix

