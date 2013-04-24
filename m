From: "George Pontis" <GPontis@z9.com>
References: <mailman.252.1366321778.1444.xenomai@xenomai.org>	<00f801ce3fcb$30850ce0$918f26a0$@com>	<51763D6E.6090407@xenomai.org>
	<016901ce4043$7b54e1f0$71fea5d0$@com>
	<5176D40E.7060607@xenomai.org>
In-Reply-To: <5176D40E.7060607@xenomai.org>
Date: Tue, 23 Apr 2013 21:38:35 -0700
Message-ID: <019a01ce40a5$95325b90$bf9712b0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai] for-core-3.8 on ARM ( i.MX53 )
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, April 23, 2013 11:34 AM
> To: George Pontis
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] for-core-3.8 on ARM ( i.MX53 )
>=20
> On 04/23/2013 06:56 PM, George Pontis wrote:
>=20
> >> -----Original Message-----
> >> From: Gilles Chanteperdrix =
[mailto:gilles.chanteperdrix@xenomai.org]
> >> Sent: Tuesday, April 23, 2013 12:51 AM
> >> To: George Pontis
> >> Cc: xenomai@xenomai.org
> >> Subject: Re: [Xenomai] for-core-3.8 on ARM ( i.MX53 )
> >>
> >> On 04/23/2013 04:35 AM, George Pontis wrote:
> >>
> >>> I took a crack at building a 3.8 kernel with Xenomai 2.6.2.1 for
> ARM,
> >> based
> >>> on the work in progress toward that ipipe patch.
> >>
> >>
> >> Xenomai 2.6.2.1 will not work, please upgrade to Xenomai 2.6 =
current
> >> git
> >> and tell us if you see the same issue.
> >>
> >> --
> >>
> Gilles.
> >
> > I got the current Xenomai and rebuilt with that. The process went
> smoothly and did not
> > require any patching or manual intervention, but it still hangs at
> the same point. Is
> > it expected that the 2.6 current tree is identifying itself as
> 2.6.2.1 ?
>=20
>=20
> Yes it is expected, incrementing the version number is the last thing
> we
> do before a release. Now, about the hang, several questions:
> - does the very same kernel version without CONFIG_IPIPE and
> CONFIG_XENOMAI boot normally?


With these undefined and the kernel rebuilt, it does boot normally.
I noticed that there is a 1-2 second delay after that same line for
eth0, but then it continues to boot to a login prompt. I tried
just CONFIG_IPIPE=3Dy without Xenomai, and that kernel hangs at the
same place.=20

> - are the error messages:
> mmc0: no vqmmc regulator found
> mmc0: no vmmc regulator found
> mmc1: no vqmmc regulator found
> mmc1: no vmmc regulator found
> sgtl5000 1-000a: clock-frequency missing or invalid
> imx-sgtl5000: probe of sound.8 failed with error -22
> Expected?

These messages have been there all along, even when the kernel boots =
normally.
The sgtl5000 sound chip does not work, but we don't care about that now. =


> - does not the message:
> Console: switching to colour frame buffer device 80x30
> Tell us that in fact the kernel logs are continuing on the =
framebuffer?


Even when the kernel boots it says this, but the boot messages continue =
to display
on the serial console. There is no output on the framebuffer except Tux, =
until one
logs in and runs an application.


> - is the timer running correctly?
> - is the clocksource incrementing correctly?

I don't know how to check either of these.

>=20
> Regards.
>=20
> --
>                                                                 =
Gilles.

Here in the Silicon Valley area of California we are having the embedded =
system conference this week.
I visited some vendors that had JTAG hardware + software packages that =
could step through kernel code.
ARM had a nice one but it included trace and was expensive. Arium had a =
more affordable solution.
I could get one on these and use it to get closer to the source of the =
problem, but it would take a
while. Any thoughts on the usefulness of those tools ?

George



