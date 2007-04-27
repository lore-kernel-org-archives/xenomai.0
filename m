Message-ID: <cbe23c50704270912i1cdb1272hd700a8b83775a34a@domain.hid>
Date: Fri, 27 Apr 2007 18:12:20 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_72382_5582250.1177690340168"
Subject: [Xenomai-help] Core Dump on possibly buggy signal handler
	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

------=_Part_72382_5582250.1177690340168
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I've recently discovered a "possible" bug
only occuring with a system running xenomai-patched kernel.

I have set up a machine (dual-core intel machine).
The machine is installed with a Fedora Core 6 and
may be booted (test purpose)  with different kernel:

1) linux 2.6.20-0119.rt8
    which is an Ingo Molnar precompiled preempt-rt patched kernel
    you may find it there:
     http://people.redhat.com/mingo/realtime-preempt/

2) 2.6.20-xeno-2.3.1-ipipe-1.7-03
    which is a xenomai enabled kernel I've configured and compiled.

My test application is a mixed C/C++ USER-land application
which currently make no xenomai specific call.

The application core dumps at the end of its execution
with the xenomai enabled kernel whereas it does not
with the preempt-rt kernel.

I track down the problem to a misuse of sigaction calls
which install SIGALARM handler with sa_flags not properly setup.

My code is definitely buggy but I let you know because in the first
place it was puzzling to have different (but consistent and repeatable) behavior
on different kernel, with core dump using the Xenomai-enabled kernel :((.

You may try it  yourself:

gcc -o BadTimerSigHandler TimerSigHandler.c

generates a the buggy binary, while

gcc -DGOOD_SIGHANDLING -o GoodTimerSigHandler TimerSigHandler.c

generates the good one.

I don't really know if it may indicates a xenomai bug or not
but I would be glad to understand WHY is this.

I mean I know that uninitialized memory have unpredictable consequence
but here the bug is persistent after rerun, reboot, power cycle etc...


-- 
Erk

------=_Part_72382_5582250.1177690340168
Content-Type: text/x-csrc; name=TimerSigHandler.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f10u5otx
Content-Disposition: attachment; filename="TimerSigHandler.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHNpZ25h
bC5oPgoKc3RhdGljIGludCBzdG9wID0gMDsKCnZvaWQKU2lnbmFsSGFuZGxlcihpbnQgU2lnbmFs
KSB7CiAgaW50IHBpZCA9IGdldHBpZCgpOwogIHByaW50ZigiUmVjZWl2ZWQgc2lnbmFsICVkLiBT
dG9wcGluZyBwZWFjZWZ1bGx5LlxuIiwgU2lnbmFsKTsKICBzdG9wID0gMTsKfQoKCmludAptYWlu
KCkgewoKICBpbnQgaTsKICBzdHJ1Y3Qgc2lnYWN0aW9uIGEgOwoKICBzaWduYWwoU0lHSU5UICwg
U2lnbmFsSGFuZGxlcik7CiAgc2lnbmFsKFNJR1BJUEUsIFNpZ25hbEhhbmRsZXIpOwogIAogIGEu
c2FfaGFuZGxlciA9IFNpZ25hbEhhbmRsZXIgOwogIHNpZ2VtcHR5c2V0KCZhLnNhX21hc2spOwoj
aWYgZGVmaW5lZChHT09EX1NJR0hBTkRMSU5HKQogIGEuc2FfZmxhZ3MgICAgPSBTQV9SRVNUQVJU
OwojZW5kaWYKICBzaWdhY3Rpb24oU0lHQUxSTSwgJmEsIE5VTEwpOwoKICBhbGFybSgzKTsKICAg
IAogIGZvciAoaT0wO2k8MjAwMCAmJiAhc3RvcCA7KytpKSB7CgogICAgcHJpbnRmKCIuIik7CiAg
ICBmZmx1c2goc3Rkb3V0KTsKICAgIHNsZWVwKDEpOwogIH0KfQoK
------=_Part_72382_5582250.1177690340168--

