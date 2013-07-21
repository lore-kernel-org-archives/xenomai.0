From: "George Pontis" <gpontis@z9.com>
Date: Sun, 21 Jul 2013 13:19:13 -0700
Message-ID: <04a701ce864f$91047590$b30d60b0$@z9.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Xenomai] cannot open switchtest device ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I find a problem trying to run xeno-test when it goes to open the switchtest
device. Before this post I searched the web and found a thread started by
"raespi".
We have a similar situation in which we are both using buildroot, but I'm
not sure that the underlying cause is the same. I am building a kernel for
3.8.13 using
the patches from git, and also the current git xenomai. ( Current as of a
month ago ). The target is an custom board based on the iMX53.

To narrow the source of the problem, I modified switchtest.c to report on
any case where the open() returns a negative number. I also made a temporary
patch
to not prepend the name with "/dev/". I might add that I'm using a new RTDM
driver named fpga_rtdm that can be opened and access successfully.
Here's what happens:

~ >> xeno-test
Started child 163: /bin/sh /usr/bin/xeno-test-run-wrapper /usr/bin/xeno-test
+ echo 0
+ /usr/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 223.749 ns, rejected 2/10000
inlined llimd: 0x79364d9364d9362f: 1347.417 ns, rejected 4/10000
inlined llmulshft: 0x79364d92ffffffe1: 31.764 ns, rejected 0/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 61.416 ns, rejected 2/10000
out of line calibration: 0x0000000000000000: 225.021 ns, rejected 1/10000
out of line llimd: 0x79364d9364d9362f: 1340.784 ns, rejected 1/10000
out of line llmulshft: 0x79364d92ffffffe1: 30.378 ns, rejected 2/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 59.940 ns, rejected 0/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 225.024 ns, rejected 0/10000
inlined llimd: 0x86c9b26c9b26c9d1: 1363.566 ns, rejected 3/10000
inlined llmulshft: 0xd45d172d0000001e: 32.283 ns, rejected 1/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 75.027 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 225.030 ns, rejected 2/10000
out of line llimd: 0x86c9b26c9b26c9d1: 1363.653 ns, rejected 4/10000
out of line llmulshft: 0xd45d172d0000001e: 31.272 ns, rejected 0/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 75.045 ns, rejected 0/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 226.083 ns, rejected 3/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 45.735 ns, rejected 1/10000
out of line calibration: 0x0000000000000000: 227.745 ns, rejected 1/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 57.900 ns, rejected 1/10000
+ /usr/bin/clocktest -C 42 -T 30
== Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.6           -0.004          0            0.0
+ /usr/bin/switchtest -T 30
== Testing FPU check routines...
d0: 1 != 2
d1: 1 != 2
d2: 1 != 2
d3: 1 != 2
d4: 1 != 2
d5: 1 != 2
d6: 1 != 2
d7: 1 != 2
d8: 1 != 2
d9: 1 != 2
d10: 1 != 2
d11: 1 != 2
d12: 1 != 2
d13: 1 != 2
d14: 1 != 2
d15: 1 != 2
== FPU check routines: OK.
== Threads:switchtest open rttest-switchtest0: No such file or directory
switchtest open rttest-switchtest1: No such file or directory
switchtest open rttest-switchtest2: No such file or directory
...
switchtest open rttest-switchtest254: No such file or directory
switchtest open rttest-switchtest255: No such file or directory
switchtest: Unable to open switchtest device.
(modprobe xeno_switchtest ?)
~ >> 
~ >> cat /proc/xenomai/rtdm/named_devices 
Hash    Name                            Driver          /proc
24      rttest-timerbench0              xeno_timerbench rttest-timerbench0
55      rttest-switchtest0              xeno_switchtest rttest-switchtest0
B4      fpga_rtdm                       fpga_rtdm_driver        fpga_rtdm
~ >>

George




