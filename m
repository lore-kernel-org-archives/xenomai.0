Message-ID: <67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>
Date: Mon, 3 Nov 2008 12:37:27 -0800
From: "Mark Saiia" <mark.saiia@domain.hid>
In-Reply-To: <490F2F23.2080307@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21486_16943477.1225744647438"
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<490ECE11.208@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>
	<490F2F23.2080307@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_21486_16943477.1225744647438
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

The switchtest output is as follows.  This was run on 2.4.5 with 2.6.26.3
AMD Geode LX800 board.
In order to get it to run, I had to remove modprobe xeno_native from my
start-up script.  I don't know if that is an expected requirement prior to
running the test.

== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5
rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12
rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18
rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|       17250|       17250
RTD|       17250|       34500
RTD|       17250|       51750
RTD|       17250|       69000
RTD|       17273|       86273
RTD|       17273|      103546
RTD|       17273|      120819
RTD|       17250|      138069
RTD|       17250|      155319
RTD|       17273|      172592
RTD|       17250|      189842
RTD|       17250|      207092
RTD|       17273|      224365
RTD|       17273|      241638
RTD|       17273|      258911
RTD|       17250|      276161
RTD|       17250|      293411
RTD|       17250|      310661
RTD|       17273|      327934
RTD|       17273|      345207
RTD|       17250|      362457

Thanks in advance for any help.

Mark Saiia



>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

------=_Part_21486_16943477.1225744647438
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>The switchtest output is as follows.&nbsp; This was run on 2.4.5 with <a href="http://2.6.26.3/" target="_blank">2.6.26.3</a>&nbsp; AMD Geode LX800 board.<br>In order to get it to run, I had to remove modprobe xeno_native from my start-up script.&nbsp; I don&#39;t know if that is an expected requirement prior to running the test.<br>
<br>== Testing FPU check routines...<br>r0: 1 != 2<br>r1: 1 != 2<br>r2: 1 != 2<br>r3: 1 != 2<br>r4: 1 != 2<br>r5: 1 != 2<br>r6: 1 != 2<br>r7: 1 != 2<br>== FPU check routines: OK.<br>== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22<br>
RTT|&nbsp; 00:00:01<br>RTH|ctx switches|-------total<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34500<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51750<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 69000<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 86273<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 103546<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 120819<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 138069<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 155319<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 172592<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 189842<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 207092<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224365<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 241638<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 258911<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 276161<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 293411<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 310661<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 327934<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17273|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 345207<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17250|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 362457<br><br>Thanks in advance for any help.<br><br>Mark Saiia<br><br><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div class="Wj3C7c"><br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br>

------=_Part_21486_16943477.1225744647438--

