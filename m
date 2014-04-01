From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 1 Apr 2014 15:40:53 -0400
Message-ID: <20140401194053.GC17765@csclub.uwaterloo.ca>
References: <5339E2CE.7060703@xenomai.org>
 <20140331215348.GX17765@csclub.uwaterloo.ca>
 <20140331215933.GY17765@csclub.uwaterloo.ca>
 <20140331220421.GZ17765@csclub.uwaterloo.ca>
 <5339E80C.9020604@xenomai.org> <5339EBE1.3060907@xenomai.org>
 <20140401013227.GA17765@csclub.uwaterloo.ca>
 <533A9A7C.7020408@xenomai.org>
 <20140401131257.GB17765@csclub.uwaterloo.ca>
 <533B14FC.1000007@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533B14FC.1000007@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Apr 01, 2014 at 09:35:24PM +0200, Gilles Chanteperdrix wrote:
> On 04/01/2014 03:12 PM, Lennart Sorensen wrote:
> > On Tue, Apr 01, 2014 at 12:52:44PM +0200, Gilles Chanteperdrix wrote:
> >> The way I test it is by running xeno-regression-test, using dohell with
> >> LTP to create a load. Note that the latency result given by
> >> xeno-regression-test should not be taken into account as switchtest is
> >> running concurrently and creates large non-preemptible sections,
> >> xeno-regression-test is more a stress test.
> > 
> > I will see if I can find the invocation to run that then.
> > 
> > I let cyclictest, switchtest and latency running the last 8 hours,
> > and latency test currently says:
> > 
> > RTD|     -0.814|      2.441|      7.486|       0|     0|     -2.116|     20.182
> > 
> > That seems decent at least.
> > 
> 
> I use:
> xeno-regression-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
> 
> Where the machine with ip 192.168.0.5 has the "discard" service enabled
> (port 9, available in inetd), an usb key is mounted on /mnt, and LTP is
> installed in /ltp.

I get an error when I use the -s option.

I ran out of space, so ltp is instaled on the usb key mounted at /mnt.
Hopefully it won't mind that.

++ /usr/lib/xenomai/testsuite/regression/posix/xddp_test
FAILURE xddp_test.c:41: socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP): Address family not supported by protocol

Maybe I am mising a kernel config.

Does this look normal for the start:

root@omap5:~# xeno-regression-test xeno-regression-test -l "dohell -s 10.200.19.25 -m /mnt -l /mnt" -t 2 
Started child 14119: /bin/bash /usr/lib/xenomai/testsuite/xeno-test-run-wrapper /usr/bin/xeno-regression-test xeno-regression-test -l dohell -s 10.200.19.25 -m /mnt -l /mnt -t 2
++ echo 0
++ /usr/lib/xenomai/testsuite/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 0.000 ns, rejected 9999/10000
inlined llimd: 0x79364d9364d9362f: 1141.959 ns, rejected 19/10000
inlined llmulshft: 0x79364d92ffffffe1: 0.000 ns, rejected 9999/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 0.000 ns, rejected 9999/10000
out of line calibration: 0x0000000000000000: 81.380 ns, rejected 9998/10000
out of line llimd: 0x79364d9364d9362f: 1056.477 ns, rejected 15/10000
out of line llmulshft: 0x79364d92ffffffe1: -81.380 ns, rejected 9999/10000
out of line nodiv_llimd: 0x79364d9364d9362f: -81.380 ns, rejected 9999/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 0.000 ns, rejected 9999/10000
inlined llimd: 0x86c9b26c9b26c9d1: 1138.427 ns, rejected 25/10000
inlined llmulshft: 0x86c9b26d0000001e: 0.000 ns, rejected 9999/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 81.380 ns, rejected 9998/10000
out of line calibration: 0x0000000000000000: 81.380 ns, rejected 9998/10000
out of line llimd: 0x86c9b26c9b26c9d1: 1073.095 ns, rejected 17/10000
out of line llmulshft: 0x86c9b26d0000001e: -81.380 ns, rejected 9999/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: -81.380 ns, rejected 9999/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 0.000 ns, rejected 9999/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 81.380 ns, rejected 9998/10000
out of line calibration: 0x0000000000000000: 81.380 ns, rejected 9998/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: -81.380 ns, rejected 9999/10000
++ /usr/lib/xenomai/testsuite/clocktest -C 42 -T 30
== Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.0           -0.014          0            0.0
  1                  1.1           -0.007          0            0.0
++ /usr/lib/xenomai/testsuite/clocktest -T 30
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0           38290685.4          681.125          0            0.0
  1           38290685.7          681.130          0            0.0
++ /usr/lib/xenomai/testsuite/cond-torture-native
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
Test OK
++ /usr/lib/xenomai/testsuite/cond-torture-posix
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
Test OK
++ /usr/lib/xenomai/testsuite/mutex-torture-native
simple_wait
recursive_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
simple_condwait
recursive_condwait
auto_switchback
Test OK
++ /usr/lib/xenomai/testsuite/mutex-torture-posix
simple_wait
recursive_wait
errorcheck_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
simple_condwait
recursive_condwait
auto_switchback
Test OK
++ /usr/lib/xenomai/testsuite/regression/posix/leaks
Checking for leaks in posix skin objects
thread: OK
mutex: OK
cond: OK
sem: OK
named sem: OK
timer: OK
shm: OK
mq: OK
++ /usr/lib/xenomai/testsuite/regression/posix/mprotect
memory read
memory write after exec enable
memory write after write enable
memory read/write after access enable
Test OK
++ /usr/lib/xenomai/testsuite/regression/posix/nano_test
Test OK
++ /usr/lib/xenomai/testsuite/regression/posix/shm
Checking posix skin shared memories
posix skin shared memories: success
++ /usr/lib/xenomai/testsuite/regression/posix/xddp_test
FAILURE xddp_test.c:41: socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP): Address family not supported by protocol


-- 
Len Sorensen

