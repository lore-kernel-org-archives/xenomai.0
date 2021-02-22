Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [I-PIPE][ARM64] Experimenting on Jetson Xavier
From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
In-Reply-To: <87y2fg339n.fsf@xenomai.org>
Date: Mon, 22 Feb 2021 12:01:25 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFDB18B7-941A-4366-AE4B-EC1E3D080444@gmail.com>
References: <CD72004A-77C0-4041-8FD6-FF64932138D4@gmail.com>
 <87a6rx4c6k.fsf@xenomai.org> <34573B47-B373-46DB-A49D-FB6298AA65DC@gmail.com>
 <871rd947az.fsf@xenomai.org> <652D6B1D-CE11-4C5B-93E5-0D02B07ABC35@gmail.com>
 <87y2fg339n.fsf@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi,

> I don't know
> the Jetson enough to figure this out at the moment though.

That=E2=80=99s more than okay, the EVL on Jetson works exceptionally =
good at the moment.
Anything more would be the cherry on top of it :)

I will take a look at CPU idling and =E2=80=9Cevl check=E2=80=9D to be =
sure that I=E2=80=99ve done everything=20
that I could do to lower the latency figures.

> What
> is the smallest negative value you get?

I=E2=80=99m getting around -0.5us after isolating the CPU#1 before that =
I was seeing around -7us.

> On 22 Feb 2021, at 11:39, Philippe Gerum <rpm@xenomai.org> wrote:
>=20
>=20
> Deniz U=C4=9Fur <deniz343@gmail.com> writes:
>=20
>> Hi again,
>>=20
>> So I=E2=80=99ve installed the evl/v5.10 on Jetson Xavier and after =
setting the scaling_governor to performance I got somewhat good results.
>>=20
>> I=E2=80=99ve set the isolcpus=3D0 command line argument but latmus =
reports that CPU0 is not isolated. I=E2=80=99m not sure if that=E2=80=99s =
a bug or I=E2=80=99ve missed something.
>>=20
>=20
> You cannot isolate CPU0, this is a reserved one Linux-wise.
>=20
>> Other than that I=E2=80=99m getting latencies between +-10us and =
worst latency
>> is 73us.
>=20
> You may want to run "evl check" for a quick verification of the =
running
> kernel configuration wrt real-time. This reads /proc/config.gz on the
> current system by default unless you pass it a .config file, so
> CONFIG_IKCONFIG_PROC should be enabled if you want to check a running
> kernel.
>=20
>> Even though I=E2=80=99ve ran latmus -t I=E2=80=99m still getting =
negative latencies. Isn=E2=80=99t that supposed to fix that?
>>=20
>=20
> Yep, it should. This can happen with high performance platforms as the
> tuner is fairly conservative when determining the typical jitter. What
> is the smallest negative value you get?
>=20
>> evl test reports OK for everything except for =
scheduler-quota-accuracy and sched-tp-accuracy (no kernel support)
>>=20
>=20
> You will need CONFIG_EVL_SCHED_QUOTA and CONFIG_EVL_SCHED_TP enabled =
in
> your Kconfig to run these tests.
>=20
> The exhaustive list of the core options can be found at
> https://evlproject.org/core/build-steps/#core-kconfig.
>=20
>> Are these latencies best I can get or are there anything else I can =
do to lower/stabilize the latencies?
>>=20
>=20
> Isolating the test CPU will certainly help. Next, a closer look to the
> impact of CPU idling may help, such as measuring the latency with and
> without idle=3Dpoll on the kernel boot line. As I hinted at earlier, =
evl
> check would detect the kernel options which are known to increase the
> latency figures. There might be more SoC-specific tweaks, I don't know
> the Jetson enough to figure this out at the moment though.
>=20
> --=20
> Philippe.


