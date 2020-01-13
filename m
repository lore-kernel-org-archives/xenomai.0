From: Jerry Huang <jerry.huang@nxp.com>
Subject: clocktest issue
Date: Mon, 13 Jan 2020 03:38:01 +0000
Message-ID: <VI1PR04MB51361D40890D174B5294A897FE350@VI1PR04MB5136.eurprd04.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,
Now I am testing some Xenomai features, but I got some issues, any guys can=
 give some comment about them?

1.    Clockset

# clocktest -C 32

clock_gettime failed for clock id 32

XNVDSO_FEAT_HOST_REALTIME not available



I-PIPE patches provide this features for arm64 on Linux-4.19? if yes, how t=
o enable it?



2.    Smokey

# smokey --run

arith OK

bufp OK

cpu_affinity skipped (no kernel support)

fpu_stress OK

iddp OK

leaks OK

net_packet_dgram skipped (no kernel support)

net_packet_raw skipped (no kernel support)

net_udp skipped (no kernel support)

posix_clock OK

cond_wait waited 9999.860 us



        How to enable cpu_affinity features in kernel? I used parameter in =
bootloader "xenomai.supported_cpus=3D0x3" (I just have 2 cores), but it see=
ms this feature yet not works.



3.    My environment:
Arm64 with Linux-4.19.68
Ipipe-arm64:
CommitID: 282d55f6 arm64: ipipe: bump release code<https://gitlab.denx.de/X=
enomai/ipipe-arm64/commit/282d55f6a742adb870b8d3451f112902b31b1742>
Xenomai:
Branch: next; CommitID: d3cdecbe1 ci: Update ARM/ARM64 4.19 kernel releases


Best Regards
Jerry Huang

