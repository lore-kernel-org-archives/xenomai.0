MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
From: Andy Pugh <andy@bodgesoc.org>
Date: Fri, 17 Jan 2014 12:44:56 -0800
Message-ID: <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
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
Cc: xenomai <xenomai@xenomai.org>

> On 16 January 2014 22:43, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>
>> Does the
>> unpatched kernel, with exactly the same configuration, compile correctly?

I had a feeling that I was very close, so I commented out the two
calls each to the troublesome functions, figuring that for the
time-being I would live without hdmi-audio and fec ethernet.

After that, the patched Udoo git repository kernel did compile, and
boots the board. I need to figure out how to tidy up the kernel string
(all changes _are_ committed).

How does this look?


[    1.397848] I-pipe: Domain Xenomai registered.
[    1.402368] Xenomai: hal/arm started.
[    1.406363] Xenomai: scheduling class idle registered.
[    1.411520] Xenomai: scheduling class rt registered.
[    1.424750] Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
[    1.431387] Xenomai: debug mode enabled.
[    1.435777] Xenomai: starting native API services
[    1.440587] Xenomai: starting POSIX services.
[    1.445072] Xenomai: starting RTDM services.

andypugh@udoo:~/git/Kernel_Unico$ ls /proc/xenomai/

acct  affinity  apc  faults  heap  interfaces  irq  latency  lock
registry  rtdm  sched  schedclasses  stat  timebases  timer  timerstat
 version

And the testsuite:

andypugh@udoo:~/git/Xenomai$ uname -a

Linux udoo 3.0.35-Xenomai-g58cf7fe-dirty #13 SMP PREEMPT Fri Jan 17
03:26:53 UTC 2014 armv7l armv7l armv7l GNU/Linux

andypugh@udoo:~/git/Xenomai$ sudo xeno-regression-test -l
"/usr/lib/xenomai/testsuite/dohell -m /tmp 100" -t 2

Started child 9158: /bin/bash
/usr/lib/xenomai/testsuite/xeno-test-run-wrapper
/usr/bin/xeno-regression-test -t 2

++ echo 0
++ /usr/lib/xenomai/testsuite/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364
signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 45.615 ns, rejected 0/10000
inlined llimd: 0x79364d9364d9362f: 1727.421 ns, rejected 2/10000
inlined llmulshft: 0x79364d92ffffffe1: 32.735 ns, rejected 0/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 45.375 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 48.075 ns, rejected 0/10000
out of line llimd: 0x79364d9364d9362f: 1788.676 ns, rejected 2/10000
out of line llmulshft: 0x79364d92ffffffe1: 27.764 ns, rejected 0/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 40.441 ns, rejected 0/10000
signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 45.565 ns, rejected 0/10000
inlined llimd: 0x86c9b26c9b26c9d1: 1743.871 ns, rejected 1/10000
inlined llmulshft: 0xd45d172d0000001e: 22.707 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 50.464 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 70.583 ns, rejected 0/10000
out of line llimd: 0x86c9b26c9b26c9d1: 1751.943 ns, rejected 2/10000
out of line llmulshft: 0xd45d172d0000001e: 10.312 ns, rejected 0/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 30.519 ns, rejected 0/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 45.570 ns, rejected 0/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 42.910 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 48.037 ns, rejected 0/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 40.478 ns, rejected 0/10000
++ /usr/lib/xenomai/testsuite/clocktest -C 42 -T 30
== Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.3            0.024          0            0.0
  1                  1.0            0.040          0            0.0
  2                  0.6           -0.046          0            0.0
  3                  1.2            0.046          0            0.0

-- 
atp

