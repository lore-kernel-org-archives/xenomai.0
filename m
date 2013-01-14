Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50F3F4BF.4050501@siemens.com>
Date: Mon, 14 Jan 2013 13:16:48 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5FA34AA-B3BE-4A90-B7F3-41E044786B8A@mah.priv.at>
References: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
	<50F3F4BF.4050501@siemens.com>
Subject: Re: [Xenomai] universal application binary: how to auto-detect
	Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 14.01.2013 um 13:06 schrieb Jan Kiszka:

Jan,

> On 2013-01-14 09:29, Michael Haberler wrote:
>> Hi,
>>=20
>> thanks to patience on this list we were able to build linuxcnc such =
that it runs on Xenomai, besides RT-PREEMPT, vanilla kernels (in a =
simulator/non-RT mode) and RTAI
>>=20
>>=20
>> I'm planning to adapt linuxcnc such that a universal binary can be =
built which runs under Xenomai, RT-PREEMPT and vanilla kernels as this =
will simplify logistics quite a bit; what I'd like have is reliable =
auto-detection of the kernel type and 'do the right thing' (RTAI will =
remain a separate build).
>>=20
>> Autodetection could be one of several things - digging around with a =
shell script, using system calls, digging in /proc - unsure how to best =
do this, in particular I'm unsure how to tell an RT-PREEMPT kernel from =
a vanilla kernel=20
>>=20
>> I know it's a bit OT - still I'd be thankful for suggestions
>>=20
>> any other low-lying cliffs I might hit?
>=20
> I do not see why you application should have to tell -RT from vanilla
> apart (syscalls are identical).

you're right from the ABI point of view

when driving a machine some of the motion-related tasks are time =
critical and will fail with an error message if latency becomes too =
high; in the very minimum this has to be suppressed on a vanilla kernel =
after giving an initial warning, and proceed as a 'simulator =
configuration' (which really translates into 'no time guarantees =
whatsoever'); in that case one would also avoid loading actual hardware =
drivers to prevent damage


> To handle the existence of Xenomai dynamically, you could push all
> Xenomai API calls into a separate library, some abstraction layer (I
> suppose you already have one in LinuxCNC), link that one against the
> Xenomai libs, have a "vanilla" version as well that builds against
> standard Linux, and then pull in the right version via dlopen (enable
> support for this via --enable-dlopen-skins during Xenomai configure).
> You could test in /proc for the existence of Xenomai before that, e.g.

the current plan is to have the generic RTAPI abstraction layer in a .so =
plus shared objects as needed per flavor

- Michael


>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
> Corporate Competence Center Embedded Linux


