Subject: Re: [PATCH 0/8] assorted fixes, ARM port to kernel 4.19
References: <20190601151502.27216-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <39cdd6a5-fb34-6333-016f-b8911330ea0a@siemens.com>
Date: Mon, 3 Jun 2019 17:00:04 +0200
MIME-Version: 1.0
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 01.06.19 17:14, Philippe Gerum wrote:
> This is material for both 3.0.9 and -next.
> 
> Philippe Gerum (8):
>    lib/cobalt: init: fix misleading message
>    cobalt/arm: fix context switching code for 4.19+
>    drivers/udd: fix spurious select() read events
>    testsuite/smokey: sched-quota: allow up to 1.5% deviation from plan
>    testsuite/smokey: reset main()'s SCHED_OTHER policy before each test
>    cobalt/thread: send backtracing request only when XNWARN is set
>    cobalt/thread: fix error status (-EINTR) of xnthread_killall()
>    lib/cobalt: kickstart backtrace() from safe context
> 
>   include/cobalt/kernel/rtdm/udd.h           |  2 +-
>   kernel/cobalt/arch/arm/switch.S            | 54 +++++++++++++++++++++-
>   kernel/cobalt/thread.c                     | 10 ++--
>   kernel/drivers/udd/udd.c                   | 31 ++++++++-----
>   lib/cobalt/init.c                          |  2 +-
>   lib/cobalt/sigshadow.c                     |  8 ++++
>   testsuite/smokey/main.c                    |  2 +
>   testsuite/smokey/sched-quota/sched-quota.c |  2 +-
>   8 files changed, 91 insertions(+), 20 deletions(-)
> 

Whole series in next, patches 3-8 also in stable.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

