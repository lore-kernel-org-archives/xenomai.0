Date: Mon, 7 Mar 2022 21:02:15 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <227990265.121741.1646683335765.JavaMail.zimbra@nod.at>
In-Reply-To: <87y21novsc.fsf@xenomai.org>
References: <1971847999.108624.1646393705887.JavaMail.zimbra@nod.at>
 <7cc78732bf4902691e4194f52738ef1380c52ca6.camel@siemens.com>
 <1918812394.108775.1646396125911.JavaMail.zimbra@nod.at>
 <87fsnxr3nc.fsf@xenomai.org>
 <2141336610.110112.1646424555986.JavaMail.zimbra@nod.at>
 <87y21novsc.fsf@xenomai.org>
Subject: Re: Questiion on commit: demo/cyclictest: fix time delta calculation
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai <xenomai@xenomai.org>

Philippe,

----- Urspr=C3=BCngliche Mail -----
> Von: "Philippe Gerum" <rpm@xenomai.org>
>> I did some more experiments. The system was already autotuned.
>> But raising the base interval from 1000 (default) to 5000 made the issue
>> go away.
>>
>=20
> Does the issue persist at any freq when resetting the clock gravity for
> user-space timers to zero instead of (or after) autotuning? e.g.
>=20
> $ echo "0u" > /proc/xenomai/clock/coreclck

Actually with 0u I get the best results.
Sometimes it takes up to a few minutes until I get negative values
but with values computed autotuned the timings turn negative almost immedia=
tely.

$ echo 6333u > /proc/xenomai/clock/coreclk # computed by autotune
$ ./demo/posix/cyclictest/cyclictest -l10000 -m -Sp99 -i100 -n --nsecs
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.00 0.00 0.08 1/81 5159         =20

T: 0 ( 5158) P:99 I:100 C:  10000 Min:      0 Act:    2999 Avg:2147483647 M=
ax:      -1
T: 1 ( 5159) P:99 I:600 C:   1680 Min:    333 Act:     999 Avg:    1097 Max=
:    8000

$ echo 0u > /proc/xenomai/clock/coreclk=20
$ ./demo/posix/cyclictest/cyclictest -l10000 -m -Sp99 -i100 -n --nsecs
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.00 0.00 0.08 1/81 5176         =20

T: 0 ( 5175) P:99 I:100 C:  10000 Min:   6000 Act:    6667 Avg:    9236 Max=
:   20000
T: 1 ( 5176) P:99 I:600 C:   1667 Min:   6000 Act:   14000 Avg:    7444 Max=
:   15333

Please note that -i100 and -n --nsecs makes the issue appear much faster th=
an without.

Thanks,
//richard

