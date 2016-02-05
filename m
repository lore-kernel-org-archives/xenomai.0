Date: Fri, 5 Feb 2016 09:11:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160205081126.GE11143@hermes.click-hack.org>
References: <56B4228F.7040704@grom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <56B4228F.7040704@grom.net>
Subject: Re: [Xenomai] Raspberry Pi 2 - again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Elmar Grom <elmar@grom.net>
Cc: xenomai@xenomai.org

On Thu, Feb 04, 2016 at 08:18:23PM -0800, Elmar Grom wrote:
> Gilles,
>=20
> thanks again for pointing out my tyo screwup. I fixed that and tried=20
> again, but
> still no luck. Below is what happens now. This does not look like an actu=
al
> error, just some not so clean coding, hiding a potential error. I also sa=
w a
> questionable type cast warning zip by at some point.
>=20
> For the time being it might be just a matter of treating this as a=20
> warning, not
> as an error. Since I have absolutely no insight into the make=20
> infrastructure of
> this project and what compiler switches are on or off at any given=20
> point, can
> you suggest a course of action?
>=20
> The updated script is below again for reference.
>=20
> Elmar
>=20
> ...
>    LD      drivers/clk/built-in.o
>    CC      drivers/clocksource/clksrc-of.o
>    CC      drivers/clocksource/arm_arch_timer.o
> ../drivers/clocksource/arm_arch_timer.c: In function =91timer_handler=92:
> ../drivers/clocksource/arm_arch_timer.c:190:3: error: implicit=20
> declaration of
> function =91__ipipe_tsc_update=92 [-Werror=3Dimplicit-function-declaratio=
n]
>     __ipipe_tsc_update();
>     ^
> ../drivers/clocksource/arm_arch_timer.c: In function=20
> =91arch_counter_register=92:
> ../drivers/clocksource/arm_arch_timer.c:538:2: error: implicit=20
> declaration of
> function =91__ipipe_tsc_register=92 [-Werror=3Dimplicit-function-declarat=
ion]
>    __ipipe_tsc_register(&tsc_info);
>    ^
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
> make[2]: *** [drivers/clocksource] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `~/raspi/linux/build'
> make: *** [sub-make] Error 2
> failed to compile

These functions are declared in asm/ipipe.h if
CONFIG_IPIPE_ARM_KUSER_TSC is enabled. You are probably missing a=20
"select IPIPE_ARM_KUSER_TSC" in a Kconfig file. Or you have not
enabled CONFIG_IPIPE ?

--=20
					    Gilles.
https://click-hack.org

