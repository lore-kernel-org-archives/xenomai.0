Message-ID: <49B03E9C.70203@domain.hid>
Date: Thu, 05 Mar 2009 22:05:32 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01872F90@domain.hid>
	<49AFE525.2080401@domain.hid>
In-Reply-To: <49AFE525.2080401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> roderik.wildenburg@domain.hid wrote:
>> On behalf of Thomas I would like to answer : 
>>
>>> Do you have CONFIG_XENO_OPT_DEBUG_NUCLEUS enabled in your 
>> yes, we can aahhh have this option enabled.
>>
>>> kconfig, and if so, do
>>> you get any message in your kernel log when running fetest?
>> no, no message anywhere (/var/log/messages, console, dmesg).
>> fetest runs and runs till I sent CTRL-C.

I just tried the program fetest on my TQM5200 with a fresh Xenomai 2.4.x
and the linuxppc_2_4_devel tree and the excepetion does *not* get
triggered. Actually I realize the following wired behavior:

/fpu_test
^C
./fpu_test
^C
Feb  3 17:16:12 tqm5200 kernel: Xenomai: Switching trivial to secondary
mode after exception #1792 from user-space at 0x10001974 (pid 342)
Floating point exception
bash-2.05b# ./fpu_test
^C
bash-2.05b# ./fpu_test
 ^C
bash-2.05b# ./fpu_test

After aborting the fpu_test program with ^C, I get the message above,
but only after the second try.

> Gilles sent you a patch affecting include/asm-powerpc/bits/pod.h a few weeks
> ago, that fixed an FPU issue. Are you running with this patch applied?

$ svn log include/asm-powerpc/bits/pod.h
------------------------------------------------------------------------
r4600 | gch | 2009-01-31 19:46:37 +0100 (Sat, 31 Jan 2009) | 1 line

Is that the patch you have in mind?

Wolfgang.

