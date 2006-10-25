Message-ID: <453FF6AA.6030406@domain.hid>
Date: Wed, 25 Oct 2006 18:43:38 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
In-Reply-To: <453FC4C0.5070105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Jeff Webb wrote:
> When I upgraded to Xenomai 2.2.4, I tried the switchtest program:
> 
>  cd /usr/xenomai/testsuite/switchtest
>  ./run
> 
> The program appeared to run properly, but <ctrl>-c would not stop the 
> application.  I was not able to kill the process cleanly, and 
> /proc/xenomai/stat showed lots of processes still running.

I get the same result with svn trunk (rev 1749) plus this FPU patch:

  https://mail.gna.org/public/xenomai-core/2006-10/msg00069.html

I think the bug may be SMP related.  When I press <ctrl>-c the first time, I see no more references to CPU 0.  When I press <ctrl>-c a second time, all output stops.  I have attached the output below.

Thanks,

Jeff


[root switchtest]# ./run
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
== FPU check routines: OK.
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22
RTT|  00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|           1|        5750|        5750
RTD|           0|        5704|        5704
RTD|           1|        5773|       11523
RTD|           0|        5750|       11454
RTD|           1|        5773|       17296
RTD|           0|        5750|       17204
RTD|           1|        5773|       23069
RTD|           0|        5750|       22954
RTD|           1|        5773|       28842
RTD|           0|        5750|       28704
RTD|           1|        5773|       34615
RTD|           0|        5750|       34454
RTD|           1|        5773|       40388
RTD|           0|        5750|       40204
RTD|           0|        5750|       45954
RTD|           1|        5773|       46161
RTD|           1|        5773|       51934
RTD|           0|        5750|       51704
RTD|           1|        5773|       57707
RTD|           0|        5750|       57454
RTD|           1|        5773|       63480
RTT|  00:00:11
RTH|---------cpu|ctx switches|-------total
RTD|           0|        5750|       63204
RTD|           1|        5773|       69253
RTD|           0|        5750|       68954
RTD|           1|        5773|       75026
RTD|           0|        5750|       74704
RTD|           1|        5773|       80799
RTD|           0|        5750|       80454
RTD|           1|        5773|       86572
RTD|           0|        5750|       86204
RTD|           1|        5773|       92345
RTD|           1|        5773|       98118
RTD|           1|        5773|      103891
RTD|           1|        5773|      109664
RTD|           1|        5773|      115437
RTD|           1|        5773|      121210
RTD|           1|        5773|      126983
RTD|           1|        5773|      132756
RTD|           1|        5773|      138529
RTD|           1|        5773|      144302


