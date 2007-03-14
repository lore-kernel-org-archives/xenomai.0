MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5
Content-Transfer-Encoding: 7bit
Message-ID: <17912.34386.408353.651285@domain.hid>
Date: Thu, 15 Mar 2007 00:33:38 +0100
Subject: Re: [Xenomai-help] mem usage and other application
In-Reply-To: <45F884EC.3060006@domain.hid>
References: <45F86426.9000309@domain.hid>
	<17912.26777.313494.393466@domain.hid>
	<45F87970.5060506@domain.hid>
	<17912.31765.786905.929691@domain.hid>
	<45F87F03.9090202@domain.hid>
	<17912.32723.685853.878873@domain.hid>
	<45F884EC.3060006@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai-help@domain.hid

Maksym Veremeyenko wrote:
 > Gilles Chanteperdrix ~~~~~:
 > 
 > > What I would like to know is if switchtest fails in the same condition
 > > as your non real-time applications, just to see if the situation you
 > > observe is an FPU bug. But for switchtest to start correctly, you need
 > > to increase CONFIG_XENO_OPT_SYS_HEAPSZ.
 > > 
 > 
 > I significantly increased CONFIG_XENO_OPT_SYS_HEAPSZ and switchtest 
 > seems to me runs fine:
 > 
 > [root@domain.hid bin]# ./switchtest
 > == Testing FPU check routines...
 > r0: 1 != 2
 > r1: 1 != 2
 > r2: 1 != 2
 > r3: 1 != 2
 > r4: 1 != 2
 > r5: 1 != 2
 > r6: 1 != 2
 > r7: 1 != 2
 > == FPU check routines: OK.
 > == Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 
 > rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 
 > rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 
 > rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
 > RTT|  00:00:01
 > RTH|ctx switches|-------total
 > RTD|        7544|        7544
 > RTD|        7590|       15134
 > RTD|        7567|       22701
 > RTD|        7590|       30291
 > RTD|        7544|       37835
 > RTD|        7544|       45379
 > RTD|        7544|       52923
 > RTD|        7567|       60490
 > RTD|        7567|       68057
 > RTD|        7498|       75555
 > RTD|        7544|       83099
 > RTD|        7521|       90620
 > RTD|        7567|       98187
 > RTD|        7544|      105731
 > RTD|        7613|      113344
 > RTD|        7567|      120911
 > RTD|        7544|      128455
 > RTD|        7521|      135976
 > RTD|        7567|      143543
 > RTD|        7590|      151133
 > RTD|        7475|      158608
 > RTT|  00:00:22
 > RTH|ctx switches|-------total
 > RTD|        7613|      166221
 > RTD|        7567|      173788
 > RTD|        7544|      181332
 > RTD|        5244|      186576
 > 
 > My problem with non-RT application happens only if RT application 
 > (running in the same time) uses native skin. Perl and Eclipse 
 > application fails when switchbench is running, but not problems during 
 > switchtest.

Ok. If you can run switchtest at the same time as your application and
switchtest does not fail, it does not look like an FPU bug. What is
the error message when perl or eclipse fail to start ?

-- 


					    Gilles Chanteperdrix.

