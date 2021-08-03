From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: about RTnet* smokey test skipped issue on Qemu
Date: Tue, 3 Aug 2021 04:31:15 +0000
Message-ID: <BN9PR11MB5227AA25E0CD6ACB67B8CE8EF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
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

Firstly, I found that all smokey tests including RTnet* pass on bare metal =
x86 platform
but three RTnet* related test items  are skipped on Qemu.  After further de=
bug, actually there is
no supported rtnet device found on Qemu with current network setting when x=
enomai image
is running over even we already enable all supported rtnet devices on xenom=
ai so that
the test is skipped on qemu.

After I replace virtio-net-pci with e1000 device like [1] patch , rt_e1000 =
and rtnet modules
would be automatically loaded by udevd so that rtnet* test item can go on w=
ithout test skipped issue.
But system report error like  [2] because there is late packet.  It seems t=
hat bad rtnet performance
with virtual network on Qemu may block our RTnet smokey test?  Any Suggesti=
ons?


[1]:
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -30,7 +30,7 @@ case "$1" in
                        -cpu host -smp 4 \
                        -enable-kvm -machine q35 \
                        -device ide-hd,drive=3Ddisk \
-                       -device virtio-net-pci,netdev=3Dnet"
+                       -device e1000,netdev=3Dnet"

[2]:
=3D=3D=3D  running net_udp =3D=3D=3D

Configuring interface rtlo (driver rt_loopback) for RTnet UDP test
rt_loopback module not there: modprobing
rtipv4 module not there: modprobing
rtudp module not there: modprobing
Waiting for interface rtlo to be running
Running RTnet UDP test on interface rtlo

PPS, LOST, LATE: packet count
MIN, MAX, BEST, AVG, WORST: microseconds

   PPS      LOST    LATE     MIN     MAX    BEST     AVG     WORST
------------------------------------------------------------------
  999.91       0       0     9.35     119     9.35     53     119
  999.93       0       0     24.8     104     9.35     54.5     119
  999.99       0       0     29.9     102     9.35     54.7     119
  999.98       0       0     19.9     180     9.35     54.8     180
1000.00       0       1     26.8     92.4     9.35     54.9     180
1000.00       0       1     31.7     190     9.35     54.8     190
1000.11       0       1     27.7     101     9.35     54.5     190
  999.91       0       1     21.2     89.9     9.35     54.4     190
  999.99       0       2     22.5     101     9.35     53.9     190
1000.07       0       2     27.8     97.3     9.35     53.9     190
unloading rtudp module
unloading rt_loopback module
unloading rtipv4 module
rtnet module was there on entry, keeping it
/usr/lib/xenomai/testsuite/smokey: test net_udp failed: Protocol error


Regards

Hongzhan Chen

