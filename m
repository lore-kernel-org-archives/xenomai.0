From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: [I-PIPE][ARM64] Experimenting on Jetson Xavier
Message-Id: <CD72004A-77C0-4041-8FD6-FF64932138D4@gmail.com>
Date: Sat, 20 Feb 2021 21:49:18 +0300
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello all,

I=E2=80=99m currently trying to run Xenomai on Jetson Xavier (arm64) =
(base kernel L4T 32.5). I had some successes and fails so far and I =
wanted to share my progress with you all. Maybe we can find a way to =
accomplish this experiment.

So far I=E2=80=99ve attempted to build mainline kernel versions =
4.19.144, 5.4.72, and 5.7.0. I was only able to boot up 5.7.0 on the =
Jetson Xavier. I believe this is a good thing because if we can boot up =
mainline linux then there is a possibility that Xenomai can run as well. =
On the other hand, NVIDIA supplies us with 4.9.140 and 4.9.210 versions. =
I have tried to apply 4.9.55 I-pipe patch to 4.9.140 (L4T) and I=E2=80=99v=
e resolved almost all conflicts. I couldn=E2=80=99t fix entry.S file...

So right now, I=E2=80=99m thinking about two ways to accomplish this =
experiment.=20
	- Bump I-pipe 5.4.72 to 5.7.0 and use it as mainline kernel on =
the target. This could work because Linux 5.7.0 already works without a =
problem.
	- Bump I-pipe 4.9.55 to L4T 4.9.140 and use it as NVIDIA=E2=80=99s=
 forked kernel on the target. If we can solve the conflict on =
=E2=80=9Centry.S=E2=80=9D file then maybe this could work as well.

What do you guys think about these solutions?
Was this matter already tested by any of you?

I=E2=80=99m definitely open to suggestions as I=E2=80=99m not sure if =
there are any other barriers on this path to run Xenomai on Jetson =
Xavier.

Thank you.
Be safe.

-Deniz=

