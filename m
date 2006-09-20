From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 20 Sep 2006 08:06:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200806.47379.niklaus.giger@domain.hid>
Subject: [Xenomai-core] FPU-Problems on a system without FPU?
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

I studied a little bit my buildbot reports on a PPC405 (without FPU) regarding 
the FPU problem. Grepping through the saved reports on the server enabled me 
to pinpoint the changes quickly. I found the following situation:

Last good check with the quick build was build 58 1604
http://ngiger.dyndns.org/buildbot/hcu3_q/builds/58/step-xenotest/0

First bad check with the quick build was build 59 with revision 1605 
http://ngiger.dyndns.org/buildbot/hcu3_q/builds/59/step-xenotest/0

But the full build 13 with revision 1604 already had the failure!
http://ngiger.dyndns.org/buildbot/hcu3_f/builds/13/step-xenotest/0
The full build 12 had revision 1599 and was good.
http://ngiger.dyndns.org/buildbot/hcu3_f/builds/12/step-xenotest/0

May be this helps to pinpoint the FPU problem a bit.

Question: Is reporting 1 != 2 always the expected output of the FPU check?

A bad check looks like:
== Testing FPU cXenomai: suspending kernel thread c1ba8ea0 ('rtk5/0') at 
0xc30303ec after exception #1792
heck routines...
r0: 1 != 2
<..>
r31: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 
rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 
rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 
rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
RTT|  00:01:59
RTH|ctx switches|-------total
RTD|           5|           5


Unfortunately I still do not have a x86-box at home where I could run buildbot 
including xeno-test.

Best regards

-- 
Niklaus Giger

