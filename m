References: <CD72004A-77C0-4041-8FD6-FF64932138D4@gmail.com>
 <87a6rx4c6k.fsf@xenomai.org>
 <34573B47-B373-46DB-A49D-FB6298AA65DC@gmail.com>
 <871rd947az.fsf@xenomai.org>
 <652D6B1D-CE11-4C5B-93E5-0D02B07ABC35@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [I-PIPE][ARM64] Experimenting on Jetson Xavier
In-reply-to: <652D6B1D-CE11-4C5B-93E5-0D02B07ABC35@gmail.com>
Date: Mon, 22 Feb 2021 09:39:16 +0100
Message-ID: <87y2fg339n.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Deniz =?utf-8?Q?U=C4=9Fur?= <deniz343@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>


Deniz U=C4=9Fur <deniz343@gmail.com> writes:

> Hi again,
>
> So I=E2=80=99ve installed the evl/v5.10 on Jetson Xavier and after settin=
g the scaling_governor to performance I got somewhat good results.
>
> I=E2=80=99ve set the isolcpus=3D0 command line argument but latmus report=
s that CPU0 is not isolated. I=E2=80=99m not sure if that=E2=80=99s a bug o=
r I=E2=80=99ve missed something.
>

You cannot isolate CPU0, this is a reserved one Linux-wise.

> Other than that I=E2=80=99m getting latencies between +-10us and worst la=
tency
> is 73us.

You may want to run "evl check" for a quick verification of the running
kernel configuration wrt real-time. This reads /proc/config.gz on the
current system by default unless you pass it a .config file, so
CONFIG_IKCONFIG_PROC should be enabled if you want to check a running
kernel.

> Even though I=E2=80=99ve ran latmus -t I=E2=80=99m still getting negative=
 latencies. Isn=E2=80=99t that supposed to fix that?
>

Yep, it should. This can happen with high performance platforms as the
tuner is fairly conservative when determining the typical jitter. What
is the smallest negative value you get?

> evl test reports OK for everything except for scheduler-quota-accuracy an=
d sched-tp-accuracy (no kernel support)
>

You will need CONFIG_EVL_SCHED_QUOTA and CONFIG_EVL_SCHED_TP enabled in
your Kconfig to run these tests.

The exhaustive list of the core options can be found at
https://evlproject.org/core/build-steps/#core-kconfig.

> Are these latencies best I can get or are there anything else I can do to=
 lower/stabilize the latencies?
>

Isolating the test CPU will certainly help. Next, a closer look to the
impact of CPU idling may help, such as measuring the latency with and
without idle=3Dpoll on the kernel boot line. As I hinted at earlier, evl
check would detect the kernel options which are known to increase the
latency figures. There might be more SoC-specific tweaks, I don't know
the Jetson enough to figure this out at the moment though.

--=20
Philippe.

