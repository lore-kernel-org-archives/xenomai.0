From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Message-Id: <34573B47-B373-46DB-A49D-FB6298AA65DC@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [I-PIPE][ARM64] Experimenting on Jetson Xavier
Date: Sun, 21 Feb 2021 20:35:53 +0300
In-Reply-To: <87a6rx4c6k.fsf@xenomai.org>
References: <CD72004A-77C0-4041-8FD6-FF64932138D4@gmail.com>
 <87a6rx4c6k.fsf@xenomai.org>
Content-Type: text/plain;
	charset=utf-8
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
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

Thank you for your reply. It=E2=80=99s so good to hear that Xenomai is =
evolving.
Really appreciate the work you guys are doing.

> I would suggest to try booting the Jetson with [3] first,
> reporting any issue to this list so we can fix them

I will try this ASAP and report my results under this thread.
I will be eagerly waiting for the arm64 version of Dovetail :)

> On 21 Feb 2021, at 19:29, Philippe Gerum <rpm@xenomai.org> wrote:
>=20
>=20
> Deniz U=C4=9Fur via Xenomai <xenomai@xenomai.org =
<mailto:xenomai@xenomai.org>> writes:
>=20
>> Hello all,
>>=20
>> I=E2=80=99m currently trying to run Xenomai on Jetson Xavier (arm64) =
(base kernel L4T 32.5). I had some successes and fails so far and I =
wanted to share my progress with you all. Maybe we can find a way to =
accomplish this experiment.
>>=20
>> So far I=E2=80=99ve attempted to build mainline kernel versions =
4.19.144, 5.4.72, and 5.7.0. I was only able to boot up 5.7.0 on the =
Jetson Xavier. I believe this is a good thing because if we can boot up =
mainline linux then there is a possibility that Xenomai can run as well. =
On the other hand, NVIDIA supplies us with 4.9.140 and 4.9.210 versions. =
I have tried to apply 4.9.55 I-pipe patch to 4.9.140 (L4T) and I=E2=80=99v=
e resolved almost all conflicts. I couldn=E2=80=99t fix entry.S file...
>>=20
>> So right now, I=E2=80=99m thinking about two ways to accomplish this =
experiment.=20
>> 	- Bump I-pipe 5.4.72 to 5.7.0 and use it as mainline kernel on =
the target. This could work because Linux 5.7.0 already works without a =
problem.
>> 	- Bump I-pipe 4.9.55 to L4T 4.9.140 and use it as NVIDIA=E2=80=99s=
 forked kernel on the target. If we can solve the conflict on =
=E2=80=9Centry.S=E2=80=9D file then maybe this could work as well.
>>=20
>> What do you guys think about these solutions?
>> Was this matter already tested by any of you?
>>=20
>> I=E2=80=99m definitely open to suggestions as I=E2=80=99m not sure if =
there are any other barriers on this path to run Xenomai on Jetson =
Xavier.
>>=20
>=20
> Since v5.7 boots this SoC, then I guess any later kernel release would
> do, including v5.10.
>=20
> If so, then there may be another option, based not on using Xenomai =
3.x
> on top of the I-pipe, but on top of Dovetail [1] which is the =
successor
> to the I-pipe (the latter is on its way out).
>=20
> There is a work in progress rebasing Xenomai 3.x on top of Dovetail =
for
> v5.10 [2]. The x86 and aarch32 ports are in a reasonably good shape at =
the
> moment, aarch64 will be available later next week. I'm confident that
> the result should be stable enough to experiment with it.
>=20
> This said, Dovetail (like the I-pipe) never met the Jetson yet (as far
> as I know), so there might be a couple of tweaks required. In the
> meantime, you could immediately experiment with the EVL core [5], =
which
> is an evolution of Xenomai's Cobalt core, also running on top of
> Dovetail. The EVL core will be at the heart of Xenomai 4.x.
>=20
> The EVL stable tree is based on v5.10 [3]. Any fix we might have to do
> there for the Jetson would likely be part of Dovetail, so this could =
be
> seamlessly inherited by [2].
>=20
> In short, I would suggest to try booting the Jetson with [3] first,
> reporting any issue to this list so we can fix them, then wait for [2]
> to be available for arm64 in order to experiment with Xenomai, which
> should happen fairly soon.
>=20
> [1] https://evlproject.org/dovetail/ =
<https://evlproject.org/dovetail/>
> [2] =
https://lab.xenomai.org/xenomai-rpm.git/log/?h=3Dfor-upstream/dovetail =
<https://lab.xenomai.org/xenomai-rpm.git/log/?h=3Dfor-upstream/dovetail>
> [3] https://git.evlproject.org/linux-evl.git/log/?h=3Devl/v5.10 =
<https://git.evlproject.org/linux-evl.git/log/?h=3Devl/v5.10>
> [4] https://evlproject.org/core/build-steps/ =
<https://evlproject.org/core/build-steps/>
> [5] https://evlproject.org/core/ <https://evlproject.org/core/>
>=20
> --=20
> Philippe.

