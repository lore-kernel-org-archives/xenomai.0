From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Thu, 25 Sep 2014 14:52:48 +0000
Message-ID: <d5e7531ec6454715adde3750c412a062@CVEX13.valentin-carl.de>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] bad syscall <167772715>/ Segmentation fault during
	xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Xenomai people,

I have recently tried to migrate from 2.x to 3.x, but when I tried to run x=
eno-test, I get the following output:

root@dimm-am335x:/usr/xenomai/bin# ./xeno-test latency
Started child 1194: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper ./xeno-t=
est latency
+ echo 0
+ testdir=3D/usr/xenomai/bin
+ /usr/xenomai/bin/smokey --run
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 219.845 ns, rejected 3/10000
inlined llimd: 0x79364d9364d9362f: 1267.191 ns, rejected 8/10000
inlined llmulshft: 0x79364d92ffffffe1: 33.104 ns, rejected 2/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 60.079 ns, rejected 2/10000
out of line calibration: 0x0000000000000000: 229.895 ns, rejected 3/10000
out of line llimd: 0x79364d9364d9362f: 1284.325 ns, rejected 3/10000
out of line llmulshft: 0x79364d92ffffffe1: 30.295 ns, rejected 2/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 53.200 ns, rejected 2/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 220.145 ns, rejected 2/10000
inlined llimd: 0x86c9b26c9b26c9d1: 1279.633 ns, rejected 7/10000
inlined llmulshft: 0x86c9b26d0000001e: 39.912 ns, rejected 1/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 59.633 ns, rejected 2/10000
out of line calibration: 0x0000000000000000: 230.004 ns, rejected 2/10000
out of line llimd: 0x86c9b26c9b26c9d1: 1290.504 ns, rejected 3/10000
out of line llmulshft: 0x86c9b26d0000001e: 30.016 ns, rejected 3/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 60.054 ns, rejected 2/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 219.695 ns, rejected 3/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 60.091 ns, rejected 3/10000
out of line calibration: 0x0000000000000000: 230.037 ns, rejected 7/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 50.025 ns, rejected 5/10000
arith OK
server: received 4 bytes, 1 from port 12
client: sent 4 bytes, 1
server: received 4 bytes, 2 from port 12
client: sent 4 bytes, 2
server: received 4 bytes, 3 from port 12
client: sent 4 bytes, 3
server: received 4 bytes, 4 from port 12
client: sent 4 bytes, 4
server: received 4 bytes, 5 from port 12
client: sent 4 bytes, 5
server: received 4 bytes, 6 from port 12
client: sent 4 bytes, 6
server: received 4 bytes, 7 from port 12
client: sent 4 bytes, 7
server: received 4 bytes, 8 from port 12
client: sent 4 bytes, 8
server: received 4 bytes, 9 from port 12
client: sent 4 bytes, 9
server: received 4 bytes, 10 from port 12
client: sent 4 bytes, 10
server: received 4 bytes, 11 from port 12
client: sent 4 bytes, 11
server: received 4 bytes, 12 from port 12
client: sent 4 bytes, 12
server: received 4 bytes, 13 from port 12
client: sent 4 bytes, 13
server: received 4 bytes, 14 from port 12
client: sent 4 bytes, 14
server: received 4 bytes, 15 from port 12
client: sent 4 bytes, 15
server: received 4 bytes, 16 from port 12
client: sent 4 bytes, 16
server: received 4 bytes, 17 from port 12
client: sent 4 bytes, 17
server: received 4 bytes, 18 from port 12
client: sent 4 bytes, 18
server: received 4 bytes, 19 from port 12
client: sent 4 bytes, 19
server: received 4 bytes, 20 from port 12
client: sent 4 bytes, 20
server: received 4 bytes, 21 from port 12
client: sent 4 bytes, 21
server: received 4 bytes, 22 from port 12
client: sent 4 bytes, 22
server: received 4 bytes, 23 from port 12
client: sent 4 bytes, 23
server: received 4 bytes, 24 from port 12
client: sent 4 bytes, 24
server: received 4 bytes, 25 from port 12
client: sent 4 bytes, 25
server: received 4 bytes, 26 from port 12
client: sent 4 bytes, 26
server: received 4 bytes, 27 from port 12
client: sent 4 bytes, 27
server: received 4 bytes, 28 from port 12
client: sent 4 bytes, 28
server: received 4 bytes, 29 from port 12
client: sent 4 bytes, 29
bufp OK
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
cond_torture OK
Test OK
fork_exec OK
server: received 4 bytes, 1 from port 13
client: sent 4 bytes, 1
server: received 4 bytes, 2 from port 13
client: sent 4 bytes, 2
server: received 4 bytes, 3 from port 13
client: sent 4 bytes, 3
server: received 4 bytes, 4 from port 13
client: sent 4 bytes, 4
server: received 4 bytes, 5 from port 13
client: sent 4 bytes, 5
server: received 4 bytes, 6 from port 13
client: sent 4 bytes, 6
server: received 4 bytes, 7 from port 13
client: sent 4 bytes, 7
server: received 4 bytes, 8 from port 13
client: sent 4 bytes, 8
server: received 4 bytes, 9 from port 13
client: sent 4 bytes, 9
server: received 4 bytes, 10 from port 13
client: sent 4 bytes, 10
server: received 4 bytes, 11 from port 13
client: sent 4 bytes, 11
server: received 4 bytes, 12 from port 13
client: sent 4 bytes, 12
server: received 4 bytes, 13 from port 13
client: sent 4 bytes, 13
server: received 4 bytes, 14 from port 13
client: sent 4 bytes, 14
server: received 4 bytes, 15 from port 13
client: sent 4 bytes, 15
server: received 4 bytes, 16 from port 13
client: sent 4 bytes, 16
server: received 4 bytes, 17 from port 13
client: sent 4 bytes, 17
server: received 4 bytes, 18 from port 13
client: sent 4 bytes, 18
server: received 4 bytes, 19 from port 13
client: sent 4 bytes, 19
server: received 4 bytes, 20 from port 13
client: sent 4 bytes, 20
server: received 4 bytes, 21 from port 13
client: sent 4 bytes, 21
server: received 4 bytes, 22 from port 13
client: sent 4 bytes, 22
server: received 4 bytes, 23 from port 13
client: sent 4 bytes, 23
server: received 4 bytes, 24 from port 13
client: sent 4 bytes, 24
server: received 4 bytes, 25 from port 13
client: sent 4 bytes, 25
server: received 4 bytes, 26 from port 13
client: sent 4 bytes, 26
server: received 4 bytes, 27 from port 13
client: sent 4 bytes, 27
server: received 4 bytes, 28 from port 13
client: sent 4 bytes, 28
server: received 4 bytes, 29 from port 13
client: sent 4 bytes, 29
iddp OK
simple_wait
recursive_wait
errorcheck_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
mutex_torture OK
simple_condwait
recursive_condwait
auto_switchback
Setup
Exclusive open
Successive open
Defer close by pending reference
Normal close
Deferred module unload
rtdm OK
[   94.434282] [Xenomai] bad syscall <167772715>
Segmentation fault
root@dimm-am335x:/usr/xenomai/bin#



Probably I just forgot one or another little thing to adapt...?



Kind regards
Peter Reitinger

