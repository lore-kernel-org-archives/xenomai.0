From: Jan Kiszka <jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
Message-ID: <ac3360a7-532c-3d35-98ec-9ed9c7195909@siemens.com>
Date: Tue, 4 Sep 2018 19:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0/4] Avoid RT-unsafe printk_ratelimited,
 RTDM cleanup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 2018-07-05 17:46, Jan Kiszka wrote:
> Patch 4 should likely be next-only, the others should go to stable as
> well.
> 
> Jan
> 
> Jan Kiszka (4):
>    cobalt/kernel/xnclock: Introduce xnclock_ratelimit()
>    cobalt/posix/signal: Replace RT-unsafe printk_ratelimit with
>      xnclock_ratelimit
>    cobalt/rtdm: Switch rtdm_printk_ratelimited to xnclock_ratelimit
>    cobalt/rtdm: Remove rtdm_ratelimit()
> 
>   include/cobalt/kernel/clock.h       | 22 ++++++++++++++++++
>   include/cobalt/kernel/rtdm/driver.h | 32 +++-----------------------
>   kernel/cobalt/clock.c               | 35 ++++++++++++++++++++++++++++
>   kernel/cobalt/posix/signal.c        |  2 +-
>   kernel/cobalt/rtdm/drvlib.c         | 46 -------------------------------------
>   5 files changed, 61 insertions(+), 76 deletions(-)
> 

I haven't heard concerns about these, so I'm applying them the next now. 
Patch 2 with patch 1 are stable candidates IMHO.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

