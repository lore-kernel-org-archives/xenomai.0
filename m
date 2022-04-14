Message-ID: <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
Date: Thu, 14 Apr 2022 13:18:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/9] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
References: <20220413215819.22954-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220413215819.22954-1-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 13.04.22 23:58, Richard Weinberger via Xenomai wrote:
> This patch series is a first attempt to integrate the currently abandoned
> alchemy, pSOS and VxWorks tests into Xenomai's test suite.
> Since each test assumes running as own process a test driver is needed
> which executes each tests separately.
> The driver makes use of the smokey framework.
> 
> Test results on a x86 VM (5.15.19, Xenomai master as of today):
> - Alchemy:
>   test2 fails:
> 	[8] at task-2.c:71
> 	[1] at task-2.c:24
> 	[9] at task-2.c:79
> 	[4] at task-2.c:43
> 	[10] at task-2.c:87
> 	[5] at task-2.c:48
> 	[11] at task-2.c:92
> 	[2] at task-2.c:29
> 	[6] at task-2.c:52
> 	   0"022.972| BUG in __traceobj_check_abort(): [FGND] wrong return status:
> 		      task-2.c:55 => EINVAL (want OK)
> 
>   task5 fails:
> 	[9] at task-5.c:79
> 	[1] at task-5.c:23
> 	[10] at task-5.c:87
> 	[3] at task-5.c:40
> 	[11] at task-5.c:95
> 	[4] at task-5.c:45
> 	[5] at task-5.c:50
> 	[6] at task-5.c:55
> 	[2] at task-5.c:28
> 	[7] at task-5.c:60
> 	   0"003.160| BUG in __traceobj_check_abort(): [FGND] wrong return status:
> 		      task-5.c:63 => EINVAL (want OK)

Seems we need to fix those at least.

> 
>   If Xenomai was configured with --enable-lores-clock, tests mq1, mutex1, pip1 and sem1 fail due to:
> 	undefined symbol: __clockobj_ticks_to_timeout

Missing lib dependency, likely. Cannot try out myself yet as patch 2
does not build.

> 
> - pSOS (Xenomai has to be configured with --enable-lores-clock):

If we add this test to smokey, and it requires lores-clock, we either
need to enable that in debian/rules or the Debian package built in
xenomai-images so that CI/CT will not fail. Well, it will fail so far
due to the test case problems. But that would be next.

>   rn1 fails:
> 	0"001.017| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
> 		rn-1.c:46 => "ret == 0"
>   task2 fails:
> 	[8] at task-2.c:73
> 	[1] at task-2.c:23
> 	[9] at task-2.c:81
> 	[4] at task-2.c:44
> 	[10] at task-2.c:89
> 	[5] at task-2.c:49
> 	[11] at task-2.c:94
> 	[2] at task-2.c:28
> 	[3] at task-2.c:33
> 	[6] at task-2.c:53
> 	   0"004.756| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
> 		      task-2.c:56 => "ret == 0"
> 
>   task6 fails:
> 	[9] at task-6.c:79
> 	[1] at task-6.c:22
> 	[10] at task-6.c:87
> 	[3] at task-6.c:39
> 	[11] at task-6.c:95
> 	[4] at task-6.c:44
> 	[5] at task-6.c:49
> 	[6] at task-6.c:54
> 	[2] at task-6.c:27
> 	[7] at task-6.c:59
> 	   0"002.870| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
> 		      task-6.c:62 => "ret == 0 && oldprio == myprio"
> 
>   task8 runs forever (100% CPU)
> 
> - VxWorks:
>   task2 fails:
> 	[8] at task-2.c:85
> 	[1] at task-2.c:32
> 	[9] at task-2.c:91
> 	[4] at task-2.c:57
> 	[10] at task-2.c:97
> 	[5] at task-2.c:62
> 	[11] at task-2.c:103
> 	[2] at task-2.c:37
> 	[12] at task-2.c:109
> 	[6] at task-2.c:66
> 	   0"005.790| BUG in __traceobj_assert_failed(): [foregroundTask] trace assertion failed:
> 		      task-2.c:69 => "ret == 0"
> 

So... reviving means fixing first, unfortunately. Then enable CI/CT, and
then we can merge. The pattern looks scalable, but then we could also
apply it stepwise: first alchemy, then vxworks and finally psos with
that lores-clock topic.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

