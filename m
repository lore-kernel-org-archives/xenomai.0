Message-ID: <450F061A.6090507@domain.hid>
Date: Mon, 18 Sep 2006 15:48:26 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rare brokenness in latency output - FPU bug!
References: <450E6745.6050903@domain.hid>
In-Reply-To: <450E6745.6050903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Uhh, wait! I just fired up switchtest on the same box:
> ...
> Gilles, what info do you need? It's all the latest on x86 here:
> 2.6.17.13 (.config attached), ipipe-1.4, SVN #1646, gcc4.1.0.
> 
> Jan

I get a similar result here with xenomai-2.2.3, 2.6.17.13, x86 SMP (see below).  No seg fault, though.

-Jeff


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
r0: 2147483648 != 10
r1: 2147483648 != 10
r2: 2147483648 != 10
r3: 2147483648 != 10
r4: 2147483648 != 10
r5: 2147483648 != 10
r6: 2147483648 != 10
r7: 39868544 != 10
Error after context switch from task 8(rtup1-8) to task 10(rtup_ufpp1-10),
FPU registers were set to 39868544 (maybe task ???)
RTT|  00:00:00
RTH|---------cpu|ctx switches|-------total
RTD|           0|          23|          23
RTD|           1|          28|          28

