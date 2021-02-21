References: <CD72004A-77C0-4041-8FD6-FF64932138D4@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [I-PIPE][ARM64] Experimenting on Jetson Xavier
In-reply-to: <CD72004A-77C0-4041-8FD6-FF64932138D4@gmail.com>
Date: Sun, 21 Feb 2021 17:29:07 +0100
Message-ID: <87a6rx4c6k.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org


Deniz U=C4=9Fur via Xenomai <xenomai@xenomai.org> writes:

> Hello all,
>
> I=E2=80=99m currently trying to run Xenomai on Jetson Xavier (arm64) (bas=
e kernel L4T 32.5). I had some successes and fails so far and I wanted to s=
hare my progress with you all. Maybe we can find a way to accomplish this e=
xperiment.
>
> So far I=E2=80=99ve attempted to build mainline kernel versions 4.19.144,=
 5.4.72, and 5.7.0. I was only able to boot up 5.7.0 on the Jetson Xavier. =
I believe this is a good thing because if we can boot up mainline linux the=
n there is a possibility that Xenomai can run as well. On the other hand, N=
VIDIA supplies us with 4.9.140 and 4.9.210 versions. I have tried to apply =
4.9.55 I-pipe patch to 4.9.140 (L4T) and I=E2=80=99ve resolved almost all c=
onflicts. I couldn=E2=80=99t fix entry.S file...
>
> So right now, I=E2=80=99m thinking about two ways to accomplish this expe=
riment.=20
> 	- Bump I-pipe 5.4.72 to 5.7.0 and use it as mainline kernel on the targe=
t. This could work because Linux 5.7.0 already works without a problem.
> 	- Bump I-pipe 4.9.55 to L4T 4.9.140 and use it as NVIDIA=E2=80=99s forke=
d kernel on the target. If we can solve the conflict on =E2=80=9Centry.S=E2=
=80=9D file then maybe this could work as well.
>
> What do you guys think about these solutions?
> Was this matter already tested by any of you?
>
> I=E2=80=99m definitely open to suggestions as I=E2=80=99m not sure if the=
re are any other barriers on this path to run Xenomai on Jetson Xavier.
>

Since v5.7 boots this SoC, then I guess any later kernel release would
do, including v5.10.

If so, then there may be another option, based not on using Xenomai 3.x
on top of the I-pipe, but on top of Dovetail [1] which is the successor
to the I-pipe (the latter is on its way out).

There is a work in progress rebasing Xenomai 3.x on top of Dovetail for
v5.10 [2]. The x86 and aarch32 ports are in a reasonably good shape at the
moment, aarch64 will be available later next week. I'm confident that
the result should be stable enough to experiment with it.

This said, Dovetail (like the I-pipe) never met the Jetson yet (as far
as I know), so there might be a couple of tweaks required. In the
meantime, you could immediately experiment with the EVL core [5], which
is an evolution of Xenomai's Cobalt core, also running on top of
Dovetail. The EVL core will be at the heart of Xenomai 4.x.

The EVL stable tree is based on v5.10 [3]. Any fix we might have to do
there for the Jetson would likely be part of Dovetail, so this could be
seamlessly inherited by [2].

In short, I would suggest to try booting the Jetson with [3] first,
reporting any issue to this list so we can fix them, then wait for [2]
to be available for arm64 in order to experiment with Xenomai, which
should happen fairly soon.

[1] https://evlproject.org/dovetail/
[2] https://lab.xenomai.org/xenomai-rpm.git/log/?h=3Dfor-upstream/dovetail
[3] https://git.evlproject.org/linux-evl.git/log/?h=3Devl/v5.10
[4] https://evlproject.org/core/build-steps/
[5] https://evlproject.org/core/

--=20
Philippe.

