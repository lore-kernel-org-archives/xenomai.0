MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <52EBE4B7.6060800@xenomai.org>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org> <52DBD649.2000908@xenomai.org>
 <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
 <52EB6BBC.8040600@xenomai.org>
 <CAN1+YZUhzb1zRE=dhjX+_1_b2cD2vEWatP6-je7b9NdNPosFvA@mail.gmail.com>
 <52EBE4B7.6060800@xenomai.org>
From: Andy Pugh <andy@bodgesoc.org>
Date: Fri, 31 Jan 2014 20:15:57 +0000
Message-ID: <CAN1+YZXKAen4YAxKfG9TZTL8B5qXqA-u7O41-ZJqbHqCdbcyow@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 31 January 2014 18:00, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

> I am afraid this is off-topic on this mailing list.

OK, thanks.

I will just say that, having figured out how to set the command line
parameters (I needed a serial terminal that did actual terminal
emulation, and I needed to edit a non-standard environment file) I
seem to be able to isolate a CPU, but xeno-test fails when I also add
the supported_cpus parameter (it runs fine without the parameter):

andypugh@udoo:~$ xeno-test

Started child 3840: /bin/bash
/usr/lib/xenomai/testsuite/xeno-test-run-wrapper /usr/bin/xeno-test

++ echo 0

/usr/bin/xeno-test: line 43: /proc/xenomai/latency: Permission denied

++ :

++ /usr/lib/xenomai/testsuite/arith

mul: 0x79364d93, shft: 26

integ: 30, frac: 0x4d9364d9364d9364


signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000

inline calibration: 0x0000000000000000: 45.470 ns, rejected 1/10000

inlined llimd: 0x79364d9364d9362f: 1727.408 ns, rejected 2/10000

inlined llmulshft: 0x79364d92ffffffe1: 32.817 ns, rejected 0/10000

inlined nodiv_llimd: 0x79364d9364d9362f: 45.453 ns, rejected 0/10000

out of line calibration: 0x0000000000000000: 47.993 ns, rejected 0/10000

out of line llimd: 0x79364d9364d9362f: 1778.918 ns, rejected 3/10000

out of line llmulshft: 0x79364d92ffffffe1: 27.894 ns, rejected 0/10000

out of line nodiv_llimd: 0x79364d9364d9362f: 40.399 ns, rejected 0/10000


signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000

inline calibration: 0x0000000000000000: 45.458 ns, rejected 0/10000

inlined llimd: 0x86c9b26c9b26c9d1: 1750.968 ns, rejected 3/10000

inlined llmulshft: 0xd45d172d0000001e: 22.732 ns, rejected 0/10000

inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 50.516 ns, rejected 0/10000

out of line calibration: 0x0000000000000000: 70.571 ns, rejected 1/10000

out of line llimd: 0x86c9b26c9b26c9d1: 1740.908 ns, rejected 1/10000

out of line llmulshft: 0xd45d172d0000001e: 10.245 ns, rejected 0/10000

out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 30.462 ns, rejected 0/10000


unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000

inline calibration: 0x0000000000000000: 45.460 ns, rejected 0/10000

inlined nodiv_ullimd: 0x79364d9364d9362f: 42.926 ns, rejected 0/10000

out of line calibration: 0x0000000000000000: 47.993 ns, rejected 0/10000

out of line nodiv_ullimd: 0x79364d9364d9362f: 40.411 ns, rejected 0/10000

++ /usr/lib/xenomai/testsuite/clocktest -C 42 -T 30

Xenomai Posix skin init: pthread_setschedparam: Invalid argument

++ /usr/lib/xenomai/testsuite/clocktest -T 30

Xenomai Posix skin init: pthread_setschedparam: Invalid argument



-- 
atp

