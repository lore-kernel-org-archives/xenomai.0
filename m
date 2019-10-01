MIME-Version: 1.0
Date: Tue, 01 Oct 2019 15:04:59 +0200
Subject: Kernel crash at startup when enabling RTNet + RTIPv4
Message-ID: <b7f-5d934f00-47-344a2840@235460637>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
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
To: xenomai@xenomai.org


Hello list,

I've been struggling to get the RTNet + RTIPv4 part to work on a Zynq 7=
000 board. Using source code from stable Xenomai 3.0.9 tarball, and pat=
ching a vanilla 4.4.189 linux.
I consistently had the kernel crash (0 pointer dereference error) at st=
artup when enabling either RTIPv4, RTCFG or RTMAC.

I finally found that there "might" be a problem with the Makefile in=C2=
=A0kernel/drivers/net/stack.
It turns out that (on my system at least), the order in which the proto=
col stacks appear in the Makefile is wrong because (I running a kernel =
with everything builtin, no modules) the protocols are loaded in that o=
rder, and thus, (in my case) RTIPv4 gets initialized before stack=5Fmgr=
 does which cause it to fail while registering (calling=C2=A0=5F=5Frtde=
v=5Fadd=5Fpack with a not initialized=C2=A0rt=5Fpackets array).

When I reorder the protocols in the Makefile, everything works flawless=
ly.

I can provide a patch if this needs to be fixed.

Thanks

Fran=C3=A7ois
