Date: Fri, 16 Aug 2019 07:01:52 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1320236447.8271136.1565956912620.JavaMail.zimbra@wolfram.com>
In-Reply-To: <CAEmXcAzKYTm-ExSxnU6XDuD6evBb4S_=NDQFLO7N8d6V1dtU7A@mail.gmail.com>
References: <CAEmXcAzKYTm-ExSxnU6XDuD6evBb4S_=NDQFLO7N8d6V1dtU7A@mail.gmail.com>
Subject: Re: Differences of Roundtrip time, latency between Xenomai 2 and
 Xenomai 3
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
To: danwe <daniel.wenninger92@gmail.com>, xenomai <xenomai@xenomai.org>


----- Den 16 aug 2019, p=C3=A5 kl 10:17, xenomai xenomai@xenomai.org skrev:

> Hello,

> I have made a comparison for Roundtrip time between Xenomai 2 / RTnet,
> Xenomai 3 and Debian distribution. I would like to ask you some specific
> questions as I am not sure.

> 1. I have read that Xenomai does work on Linux and the Interrupt Pipeline
> does know which message is for real-time (Xenomai) and which not (Debian)=
.
> As I am copy Xenomai on a SD-Card am I just using real-time messages or i=
s
> it also possible to use non-real-time messages? Does Xenomai need Debian
> distribution or can it work by itself?

You would probably need at least a small Linux distribution.
Xenomai does not now how to talk to all hardware there is, e.g. read write =
to disk or allocate memory etc. so someone else has to do that. And just to=
 be clear, let's differentiate between a Linux kernel and a GNU/Linux OS. T=
he programs you write needs libraries with common functions,  for example m=
ath functions or stdio or similar and these are not part of the Linux kerne=
l. They are most often GNU (or from other sources).=20

And also, the Xenomai kernel IS a Linux kernel with some addons to handle i=
nterrupts and some of the hardware.=20

If you really want to slim down you would need

a) A Xenomai Linux kernel (would boot on its own, but may also need some he=
lp with loading firmware blobs for certain hardware)
b) A Xenomai compiled application. I guess if it's statically linked you co=
uld actually get away with running that instead of the regular init.

But in most cases you also need

c) A minimal Linux distribution, possibly just something to be able to load=
 drivers, set the time etc. (See for example Yocto/Openembedded that can ru=
n busybox)
d) Some Xenomai runtime software like dynamically linked libraries for code=
 you haven't statically linked and some software for controlling Xenomai dr=
ivers such as rtcan etc.=20


> 2. I have seen some big difference in jitter between Xenomai 2 / RTnet an=
d
> Xenomai 3 without RTnet while testing the latency. Xenomai 3 does have a
> much smaller jitter than Xenomai 2 / RTnet. Can you tell me where exactly
> the difference come from?

> 3. I have also seen that the Roundtrip time for Xenomai 3 is twice the si=
ze
> of Xenomai 2 / RTnet. So my question is: I thought that RTnet ist just fo=
r
> synchronization and TDMA. Does RTnet also make it "more" real-time than
> Xenomai 3 itself?

Lets see if I can clarify things a bit. Perhaps it will answer some of your=
 questions indirectly.=20

First, with regards to networking there are simply put two driver variants =
to choose from in Xenomai, the regular Kernel driver or the RTNet driver.=
=20

The regular kernel driver is handled by the regular kernel which is allowed=
 to process data when Xenomai thinks its fitting to do so. The RTNet driver=
 is handled directly by Xenomai. The problem with handing over things to th=
e regular kernel is that it might have other things that it thinks it needs=
 to to while in charge of the CPU, so this should give a bit more random be=
havior. If we decide to wait for an answer/result we may be waiting a long =
time if the Linux kernel has other things to do so we may miss or deadline.=
=20

Secondly, when programming for Xenomai you may choose a skin of your liking=
. When using the posix skin you may write posix UDP/TCP code for sending/re=
ading a socket regardless of if its a RTNet driver or a regular driver. Xen=
omai should use the correct function automatically, but if it doesn't you m=
ay use macros or special functions with prefixes (__STD or __COBALT).=20

In practice this means that sending a UDP message from Xenomai on a network=
 card that has the RTNet driver loaded is completely handled by the real ti=
me part while sending on network card that has the regular Linux driver wil=
l need regular Linux kernel to step in.

> Kind regards

> Daniel

Best regards
Per =C3=96berg=20

