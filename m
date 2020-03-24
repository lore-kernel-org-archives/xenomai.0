Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Tue, 24 Mar 2020 17:05:33 +0100
Subject: Slow path detected in RTCAP
Message-ID: <7230-5e7a3000-1f-4d48c480@89258041>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm trying to port an old application that used to be running on DSPBIO=
S to Xenomai, using RTNET for the network part.
I'm getting some weird results with semaphores, but before that I got t=
hat debug dump :

[   49.201310] WARNING: CPU: 0 PID: 958 at /home/dev/UCC/linux-4.4.189/=
kernel/ipipe/core.c:1912 =5F=5Fipipe=5Fpost=5Fwork=5Froot+0xe8/0xfc()
[   49.214809] CPU: 0 PID: 958 Comm: Ma=C3=AEtre de R=C3=A9s Not tainte=
d 4.4.189 #47
[   49.222636] Hardware name: Xilinx Zynq Platform
[   49.227791] I-pipe domain: Xenomai
[   49.231705] [<c00159e8>] (unwind=5Fbacktrace) from [<c0012e24>] (sho=
w=5Fstack+0x10/0x14)
[   49.240511] [<c0012e24>] (show=5Fstack) from [<c0222798>] (dump=5Fst=
ack+0x104/0x120)
[   49.248887] [<c0222798>] (dump=5Fstack) from [<c0025568>] (warn=5Fsl=
owpath=5Fcommon+0x80/0xb0)
[   49.258162] [<c0025568>] (warn=5Fslowpath=5Fcommon) from [<c0025660>=
] (warn=5Fslowpath=5Fnull+0x1c/0x24)
[   49.268172] [<c0025660>] (warn=5Fslowpath=5Fnull) from [<c008b7bc>] =
(=5F=5Fipipe=5Fpost=5Fwork=5Froot+0xe8/0xfc)
[   49.278344] [<c008b7bc>] (=5F=5Fipipe=5Fpost=5Fwork=5Froot) from [<c=
00a4df0>] (rtdm=5Fnrtsig=5Fpend+0x24/0x2c)
[   49.288219] [<c00a4df0>] (rtdm=5Fnrtsig=5Fpend) from [<c034e2c8>] (r=
tcap=5Fxmit=5Fhook+0x150/0x1bc)
[   49.297550] [<c034e2c8>] (rtcap=5Fxmit=5Fhook) from [<c033fc64>] (rt=
dev=5Flocked=5Fxmit+0x28/0x3c)
[   49.307010] [<c033fc64>] (rtdev=5Flocked=5Fxmit) from [<c0340be4>] (=
rtdev=5Fxmit+0x38/0x84)
[   49.315871] [<c0340be4>] (rtdev=5Fxmit) from [<c034935c>] (rt=5Fpack=
et=5Fsendmsg+0x2d4/0x304)
[   49.324865] [<c034935c>] (rt=5Fpacket=5Fsendmsg) from [<c00a6380>] (=
rtdm=5Ffd=5Fsendmsg+0x80/0x98)
[   49.334205] [<c00a6380>] (rtdm=5Ffd=5Fsendmsg) from [<c00aa0d8>] (Co=
BaLt=5Fsendmsg+0x78/0xa4)
[   49.343275] [<c00aa0d8>] (CoBaLt=5Fsendmsg) from [<c00b602c>] (handl=
e=5Fhead=5Fsyscall+0x168/0x320)
[   49.352953] [<c00b602c>] (handle=5Fhead=5Fsyscall) from [<c000f9d0>]=
 (local=5Frestart+0x20/0x44)
[

The indicated thread "Ma=C3=AEtre de R=C3=A9s" is a xenomai posix threa=
d.

I see that the call stack includes RTCAP code, and I checked that this =
does not happen when RTCAP is disabled in kernel build. Anyway, Is this=
 slow path to be expected in RTCAP ?

Thanks

Fran=C3=A7ois


