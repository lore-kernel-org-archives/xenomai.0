MIME-Version: 1.0
Date: Wed, 6 Jun 2012 12:10:15 +0430
Message-ID: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

I have installed xenomai-2.6.0. None of the instrumentation commands
work except latency. What can i do?

/root> switchbench
bash: switchbench: command not found
/root> switchtest
Xenomai Posix skin init: pthread_setschedparam: Function not implemented
/root> cyclictest
Xenomai Posix skin init: pthread_setschedparam: Function not implemented
/root> latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds

/root> xeno-test
Started child 7172: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper
/usr/xenomai/bin/xeno-test
++ echo 0
++ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 28.751 ns, rejected 1/10000
inlined llimd: 0x79364d9364d9362f: 41.292 ns, rejected 1/10000
inlined llmulshft: 0x79364d92ffffffe1: 5.007 ns, rejected 0/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 11.323 ns, rejected 1/10000
out of line calibration: 0x0000000000000000: 30.003 ns, rejected 0/10000
out of line llimd: 0x79364d9364d9362f: 46.075 ns, rejected 1/10000
out of line llmulshft: 0x79364d92ffffffe1: 7.800 ns, rejected 1/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 16.683 ns, rejected 1/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 29.298 ns, rejected 1/10000
inlined llimd: 0x86c9b26c9b26c9d1: 39.658 ns, rejected 1/10000
inlined llmulshft: 0x86c9b26d0000001e: 4.059 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 16.976 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 30.002 ns, rejected 1/10000
out of line llimd: 0x86c9b26c9b26c9d1: 48.757 ns, rejected 0/10000
out of line llmulshft: 0x86c9b26d0000001e: 11.085 ns, rejected 1/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 17.770 ns, rejected 1/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 28.749 ns, rejected 1/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 16.264 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 30.001 ns, rejected 0/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 20.463 ns, rejected 1/10000
++ /usr/xenomai/bin/clocktest -T 30
Xenomai Posix skin init: pthread_setschedparam: Function not implemented


Only latency seems working.

