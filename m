Message-ID: <49100825.9000502@domain.hid>
Date: Tue, 04 Nov 2008 09:30:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>	
	<490ECE11.208@domain.hid>	
	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>	
	<490F2F23.2080307@domain.hid>
	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>
In-Reply-To: <67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Mark Saiia wrote:
> Hello,
> 
> The switchtest output is as follows.  This was run on 2.4.5 with 2.6.26.3
> AMD Geode LX800 board.
> In order to get it to run, I had to remove modprobe xeno_native from my
> start-up script.  I don't know if that is an expected requirement prior to
> running the test.
> 
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
> RTD|       17250|       17250
> RTD|       17250|       34500
> RTD|       17250|       51750
> RTD|       17250|       69000
> RTD|       17273|       86273
> RTD|       17273|      103546
> RTD|       17273|      120819
> RTD|       17250|      138069
> RTD|       17250|      155319
> RTD|       17273|      172592
> RTD|       17250|      189842
> RTD|       17250|      207092
> RTD|       17273|      224365
> RTD|       17273|      241638
> RTD|       17273|      258911
> RTD|       17250|      276161
> RTD|       17250|      293411
> RTD|       17250|      310661
> RTD|       17273|      327934
> RTD|       17273|      345207
> RTD|       17250|      362457
> 
> Thanks in advance for any help.
> 
> Mark Saiia


Hi,

It seems you do not get the same error with switchtest as you get with
your test program. I had a look at linux fpu handling, and it seems to
be very different from Xenomai fpu handling. I need to dig a little bit
more, but will send you a patch soon.

Regards.

-- 
					    Gilles.

