From: "Beaufils Sylvie (IT&LAB)" <sylvie.beaufils@thomson-networks.com>
Date: Tue, 11 Dec 2012 17:49:53 +0000
Message-ID: <14AA522E86E5754F8BC33C742D045A4A8134EFB4@srv0024.corp.thvnet.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Latency test results Xeon E5-1650 higher than Xeon E5620
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

We run linux kernel 3.2.34 + ipipe-core-3.2.21-x86-1 + xenomai 2.6.1 on two=
 platforms, one with Xeon E5620 and the other with Xeon E5-1650.

E5-1650 shows higher latencies than E5620 when running the following test o=
n an idle system:

latency -t 2 -T60 -q ; latency -t 1 -T60 -q ; latency -t 0 -T60 -q

++++++ Xeon E5-1650 ++++++
=3D=3D Test mode: in-kernel timer handler
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|     -3.156|     -2.073|     10.554|       0|     0|    00:01:00/00:01:=
00
=3D=3D Test mode: in-kernel periodic task
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|     -2.694|     -1.215|     16.683|       0|     0|    00:01:00/00:01:=
00
=3D=3D Test mode: periodic user-mode task
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|     -2.445|     -0.412|     15.308|       0|     0|    00:01:00/00:01:=
00

++++++ Xeon E5620 ++++++
=3D=3D Test mode: in-kernel timer handler
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|     -3.759|     -2.669|      1.056|       0|     0|    00:01:00/00:01:=
00
=3D=3D Test mode: in-kernel periodic task
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|     -2.656|     -1.567|      6.852|       0|     0|    00:01:00/00:01:=
00
=3D=3D Test mode: periodic user-mode task
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|     -2.060|     -0.964|      7.631|       0|     0|    00:01:00/00:01:=
00


I have read that "The most common reason for high latencies on x86 are SMIs=
". But the SMI workaround does not manage the Patsburg LPC controller. I tr=
ied to add the PCI ID [8086:1d41] to ksrc/arch/x86/smi.c with this result:
[    1.926417] Xenomai: SMI-enabled chipset found
[    1.926490] Xenomai: SMI workaround failed!

Should the SMI workaround be managed for the C602 chipset ? Could it explai=
n the above latency results ?

Thanks,
Sylvie

