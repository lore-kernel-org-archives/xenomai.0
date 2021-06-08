Subject: Re: [florian/y2038][PATCH v3 0/3] y2038:mutex_timedlock for timespec64
References: <1622721916-1824-1-git-send-email-chensong_2000@189.cn>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <049086bd-62ee-70f0-6bb0-9f2906ff19f6@siemens.com>
Date: Tue, 8 Jun 2021 08:39:37 +0200
In-Reply-To: <1622721916-1824-1-git-send-email-chensong_2000@189.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Song Chen <chensong_2000@189.cn>, xenomai@xenomai.org

Hi Song,

On 03.06.21 14:05, Song Chen wrote:
> This patch serial is aimed to introduce a new syscall mutex_timedlock64
> which is specific for 64-bit time_t.
> 
> ---
> v2:
> 1, new revision regarding review comments
> 
> v3:
> 1, return -errno
> 2, throw a warning if timeout is NULL

Will you take care of the POSIX violation as well, or should I try to
find a timeslot and do it?

> 
> Song Chen (3):
>   y2038: cobalt/posix/mutex: Adding mutex_timedlock64
>   y2038: lib/cobalt/mutex: dispatch mutex_timedlock
>   y2038: testsuite/smokey/y2038: testcase for mutex_timedlock64
> 
>  include/cobalt/uapi/syscall.h          |   1 +
>  kernel/cobalt/posix/mutex.c            |  22 +++++-
>  kernel/cobalt/posix/mutex.h            |   7 ++
>  kernel/cobalt/posix/syscall32.c        |   7 ++
>  kernel/cobalt/posix/syscall32.h        |   4 +
>  lib/cobalt/mutex.c                     |   4 +
>  testsuite/smokey/y2038/syscall-tests.c | 136 +++++++++++++++++++++++++++++++++
>  7 files changed, 180 insertions(+), 1 deletion(-)
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

