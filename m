MIME-Version: 1.0
Date: Wed, 13 May 2009 14:04:01 +0200
Message-ID: <ff1d78710905130504h2588d8c5te0b918dce3a8f0da@domain.hid>
From: Steven Kauffmann <steven.kauffmann@domain.hid>
Content-Type: multipart/mixed; boundary=001636c92477cc4ecb0469ca019b
Subject: [Xenomai-help] Periodic threads not scheduled anymore during debug
	session
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001636c92477cc4ecb0469ca019b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

If I connect a debugger to my application, other Xenomai periodic
threads (threads that not belong to the current process I'm debugging
) are not scheduled anymore. Attached you can find a simple example
that reproduces the problem. I run the program 2 times in a different
terminal and connected a debugger to one of them. When a breakpoint is
reached both programs stops their execution but I would expect that
only the program that I'm debugging should stop and not both.

$ cat /proc/xenomai/sched

CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT
  0  5469     0      1000000001 331274938  master    D
  0  5471     0      1000000001 0          master    XT

This looks normal one thread is stopped ( thread that reaches the
breakpoint ) and the other one is delayed because it's a periodic
thread. Every time I call this command the timeout of the delayed
thread changes so it looks like this thread is still running but in
reality it is not.

I'm using the xenomai 2.4 branch and kernel linux-2.6.28.9 patched
with adeos-ipipe-2.6.28.9-x86-2.2-07.

Regards

Steven

--001636c92477cc4ecb0469ca019b
Content-Type: text/x-csrc; charset=US-ASCII; name="test_gdb.c"
Content-Disposition: attachment; filename="test_gdb.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_funzdriq0

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVkZSA8
bmF0aXZlL3RpbWVyLmg+CgpSVF9UQVNLIHRhc2s7Cgp2b2lkIG15dGFzayh2b2lkKiBjb29raWUp
IHsKCiAgaW50IHJldDsKCiAgcmV0ID0gcnRfdGFza19zZXRfcGVyaW9kaWMoJnRhc2ssIFRNX05P
VywgMTAwMDAwMDAwMCk7CiAgaWYocmV0ICE9IDApIHsKICAgIHByaW50ZigiRXJyb3I6IHJ0X3Rh
c2tfc2V0X3BlcmlvZCByZXR1cm5lZCAlZFxuIiwgcmV0KTsKICAgIHJ0X3Rhc2tfZGVsZXRlKCZ0
YXNrKTsKICAgIHJldHVybjsKICB9CgogIGludCBjb3VudGVyID0gMDsKCiAgd2hpbGUoMSkgewog
ICAgcHJpbnRmKCJDb3VudGVyOiAlZFxuIiwgY291bnRlcik7CiAgICBjb3VudGVyKys7CiAgICBy
dF90YXNrX3dhaXRfcGVyaW9kKE5VTEwpOwogIH0KCn0KCmludCBtYWluKCkgewoKICBpbnQgcmV0
OwoKICBtbG9ja2FsbChNQ0xfQ1VSUkVOVHxNQ0xfRlVUVVJFKTsKCiAgcmV0ID0gcnRfdGFza19j
cmVhdGUoJnRhc2ssIE5VTEwsIDAsIDAsIDApOwogIGlmKHJldCAhPSAwKSB7CiAgICBwcmludGYo
IkVycm9yOiBydF90YXNrX2NyZWF0ZSByZXR1cm5lZCAlZFxuIiwgcmV0KTsKICAgIHJldHVybiAt
MTsKICB9CgogIHJldCA9IHJ0X3Rhc2tfc3RhcnQoJnRhc2ssICZteXRhc2ssIE5VTEwpOwogIGlm
KHJldCAhPSAwKSB7CiAgICBwcmludGYoIkVycm9yOiBydF90YXNrX3N0YXJ0IHJldHVybmVkICVk
XG4iLCByZXQpOwogICAgcmV0dXJuIC0xOwogIH0KCiAgcmV0ID0gcnRfdGFza19zZXRfcGVyaW9k
aWMoJnRhc2ssIFRNX05PVywgMTAwMDAwMDAwMCk7CiAgaWYocmV0ICE9IDApIHsKICAgIHByaW50
ZigiRXJyb3I6IHJ0X3Rhc2tfc2V0X3BlcmlvZCByZXR1cm5lZCAlZFxuIiwgcmV0KTsKICAgIHJ0
X3Rhc2tfZGVsZXRlKCZ0YXNrKTsKICAgIHJldHVybiAtMTsKICB9CgogIGdldGNoYXIoKTsKCiAg
cmV0ID0gcnRfdGFza19kZWxldGUoJnRhc2spOwogIGlmKHJldCAhPSAwKSB7CiAgICBwcmludGYo
IkVycm9yOiBydF90YXNrX2RlbGV0ZSByZXR1cm5lZCAlZFxuIiwgcmV0KTsKICAgIHJldHVybiAt
MTsKICB9CgogIHJldHVybiAwOwp9Cg==
--001636c92477cc4ecb0469ca019b--

