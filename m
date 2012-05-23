From: Chris Stone <chris.stone@optelian.com>
Date: Wed, 23 May 2012 15:43:49 +0000
Message-ID: <623784B6C75D274389918D358E89E8BB0B7FD420@OPTELIAN5.optelian.local>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] MDIO on Freescale MX35.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am using Xenomai 2.6.0. We wish to run Xenomai on two different target bo=
ards, one uses the Freescale MPC8378 CPU,
which is powerpc, the other uses the Freescale MX35 which is arm11. This is=
 for real products that are under development,=20
so there are some factors that affect our choices. For instance, to simplif=
y maintenance of these cards for many=20
years to come, we want to use the same kernel version on the MPC8378 as we =
do on the MX35. For this reason, we=20
chose to use kernel 3.0.13, because there are Adeos patches against kernel =
3.0.13 for both arm and powerpc. However,=20
I know that the Adeos patches and kernel 3.0.13 are not really supported by=
 Xenomai 2.6.0 because they are only in the=20
Git tree and not in the official tarball download. Nonetheless, the powerpc=
 target has been running with no problem=20
for some time now, and the card is actually in product verification now, wh=
ich means that testing has not discovered=20
any problems with Xenomai 2.6.0 on that target. I am now attempting bring X=
enomai up on the mx35 card.

I am using the adeos patch adeos-ipipe-3.0.13-arm-1.18.08.patch. I tried fo=
llowing the README for the MXC, but the=20
Freescale IMX git has no tag rel_imx_3.0.15_12.03.00. The denx tree has the=
 tag, but the mxc patches as described in=20
the README do not apply without errors. Even after fixing the patch rejects=
, I ended up with compilation errors, so I=20
lost confidence in that approach. So, I applied the adeos-ipipe-3.0.13-arm-=
1.18.08.patch to the kernel.org 3.0.13=20
kernel, without the pre and post patches, which went without error. The ker=
nel boots, and many things work, but the=20
FEC Ethernet is broken with an MDIO read timeout.=20

I would like to debug this issue and provide whatever fixes back to the com=
munity. I don't really know where to=20
start. I am looking for some guidance on what I should do to debug the issu=
e.

Cheers,

Chris Stone
Embedded Linux Architect
Optelian
1 Brewer Hunt Way
Ottawa, Ontario K2K 2B5

Phone: 613-287-2000 x2106

www.optelian.com


