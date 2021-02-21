Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [I-PIPE][ARM64] Experimenting on Jetson Xavier
From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
In-Reply-To: <871rd947az.fsf@xenomai.org>
Date: Mon, 22 Feb 2021 00:44:15 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <652D6B1D-CE11-4C5B-93E5-0D02B07ABC35@gmail.com>
References: <CD72004A-77C0-4041-8FD6-FF64932138D4@gmail.com>
 <87a6rx4c6k.fsf@xenomai.org> <34573B47-B373-46DB-A49D-FB6298AA65DC@gmail.com>
 <871rd947az.fsf@xenomai.org>
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

Hi again,

So I=E2=80=99ve installed the evl/v5.10 on Jetson Xavier and after =
setting the scaling_governor to performance I got somewhat good results.

I=E2=80=99ve set the isolcpus=3D0 command line argument but latmus =
reports that CPU0 is not isolated. I=E2=80=99m not sure if that=E2=80=99s =
a bug or I=E2=80=99ve missed something.

Other than that I=E2=80=99m getting latencies between +-10us and worst =
latency is 73us. Even though I=E2=80=99ve ran latmus -t I=E2=80=99m =
still getting negative latencies. Isn=E2=80=99t that supposed to fix =
that?

evl test reports OK for everything except for scheduler-quota-accuracy =
and sched-tp-accuracy (no kernel support)

Are these latencies best I can get or are there anything else I can do =
to lower/stabilize the latencies?

Thanks.
Deniz.

> On 21 Feb 2021, at 21:14, Philippe Gerum <rpm@xenomai.org> wrote:
>=20
>=20
> Deniz U=C4=9Fur <deniz343@gmail.com> writes:
>=20
>> Hi Philippe,
>>=20
>> Thank you for your reply. It=E2=80=99s so good to hear that Xenomai =
is evolving.
>> Really appreciate the work you guys are doing.
>>=20
>> I would suggest to try booting the Jetson with [3] first,
>> reporting any issue to this list so we can fix them
>>=20
>> I will try this ASAP and report my results under this thread.
>> I will be eagerly waiting for the arm64 version of Dovetail :)
>>=20
>=20
> Actually, Dovetail/arm64 has been alive and kicking for several years
> now, EVL runs it today up to the latest v5.11. What is missing is the
> Xenomai port to Dovetail/arm64, which is brewing. I'll keep you posted
> when it can be tested (within a week, I believe).
>=20
> --=20
> Philippe.


