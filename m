Message-ID: <453BAD90.9020306@domain.hid>
Date: Sun, 22 Oct 2006 19:42:40 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] switchtest FPU register error on PPC 2.6.18
References: <453B4816.4010007@domain.hid>
	<17723.27846.168894.602494@domain.hid>
In-Reply-To: <17723.27846.168894.602494@domain.hid>
Content-Type: multipart/mixed; boundary="------------080507090204000906020704"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080507090204000906020704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>  > Hello,
>  > 
>  > I just realized the error message:
>  > 
>  >    Error after context switch from task 8(rtup-8) to task
>  >    10(rtup_ufpp-10), FPU registers were set to 1000 (maybe task
>  >    sleeper_ufps-0)
>  > 
>  > when running "switchtest" on an PPC under Linux 2.6.18 with Xenomai head 
>  > of SVN. I have attached the full output log.
> 
> Are you sure you did ?

Oh, well, ... see attachment.

>  >  Can some tell me what went 
>  > exactly wrong and where I should start looking at?
> 
> It means that after a switch from task 8 to task 10, the FPU context is
> the one of task 0. So, some context switches which should have switched
> the FPU did not. If you are lucky, you should get this error
> systematically.
> 
> In order to investigate, you should try and reduce the number of tasks
> created by switchtest. switchtest --help will tell you the list of tasks
> created by switchtest by default, start from this list, and try removing
> some tasks, keeping the failure. When you have the minimum set of tasks
> that create the failure, try to trace the fpu switches, to see which one
> does not do its job correctly.

OK, thanks for the hint. I forgot to mention that it only happens once 
after reboot. Re-exectution does not show the error any more.

Wolfgang.


--------------080507090204000906020704
Content-Type: text/x-log;
 name="switchtest-error.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="switchtest-error.log"

bash-3.00# cd xenomai/testsuite/switchtest/
bash-3.00# ./run
*
*
* Type ^C to stop this application.
*
*
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
r8: 1 != 2
r9: 1 != 2
r10: 1 != 2
r11: 1 != 2
r12: 1 != 2
r13: 1 != 2
r14: 1 != 2
r15: 1 != 2
r16: 1 != 2
r17: 1 != 2
r18: 1 != 2
r19: 1 != 2
r20: 1 != 2
r21: 1 != 2
r22: 1 != 2
r23: 1 != 2
r24: 1 != 2
r25: 1 != 2
r26: 1 != 2
r27: 1 != 2
r28: 1 != 2
r29: 1 != 2
r30: 1 != 2
r31: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
r0: 1000 != 10
r1: 1000 != 10
r2: 1000 != 10
r3: 1000 != 10
r4: 1000 != 10
r5: 1000 != 10
r6: 1000 != 10
r7: 1000 != 10
r8: 1000 != 10
r9: 1000 != 10
r10: 1000 != 10
r11: 1000 != 10
r12: 1000 != 10
r13: 1000 != 10
r14: 1000 != 10
r15: 1000 != 10
r16: 1000 != 10
r17: 1000 != 10
r18: 1000 != 10
r19: 1000 != 10
r20: 1000 != 10
r21: 1000 != 10
r22: 1000 != 10
r23: 1000 != 10
r24: 1000 != 10
r25: 1000 != 10
r26: 1000 != 10
r27: 1000 != 10
r28: 1000 != 10
r29: 1000 != 10
r30: 1000 != 10
r31: 1000 != 10
Error after context switch from task 8(rtup-8) to task 10(rtup_ufpp-10),
FPU registers were set to 1000 (maybe task sleeper_ufps-0)
RTT|  00:00:00
RTH|ctx switches|-------total
RTD|          28|          28
--------------080507090204000906020704--

