Subject: Re: [PATCH v3 0/3] y2038:clock_nanosleep for timespec64
References: <1619505639-13582-1-git-send-email-chensong_2000@189.cn>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <3b8cc1d1-1999-e6cf-efda-8e8fd1b92392@siemens.com>
Date: Tue, 1 Jun 2021 11:38:16 +0200
In-Reply-To: <1619505639-13582-1-git-send-email-chensong_2000@189.cn>
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

On 27.04.21 08:40, Song Chen wrote:
> This patch serial is aimed to introduce a new syscall clock_nanosleep64
> which is specific for 64-bit time_t.
> 
> ---
> v2:
> 1, introduce a new helper __cobalt_clock_nanosleep64 given the behavior
> in compat syscall is identical.
> 2, REALTIME --> MONOTONIC in testsuite
> 3, more combinations of parameters in testsuite
> 4, smokey warning if clock_gettime goes wrong in testsuite
> 5, remove magic number in testsuite
> 
> v3:
> 1, check lower boundary if nanosleep sleeps long enough
> 
> chensong (3):
>   y2038: cobalt/posix/clock: Adding clock_nanosleep64
>   y2038: lib/cobalt/clock: dispatch clock_nanosleep
>   y2038: testsuite/smokey/y2038: testcase for nanosleep64
> 
>  include/cobalt/uapi/syscall.h          |  1 +
>  kernel/cobalt/posix/clock.c            | 30 ++++++++++++++
>  kernel/cobalt/posix/clock.h            |  9 +++++
>  kernel/cobalt/posix/syscall32.c        |  9 +++++
>  kernel/cobalt/posix/syscall32.h        |  6 +++
>  lib/cobalt/clock.c                     |  5 +++
>  testsuite/smokey/y2038/syscall-tests.c | 72 ++++++++++++++++++++++++++++++++++
>  7 files changed, 132 insertions(+)
> 

I applied this series with some minor modifications to florian/y2038. I
will send out a series together with the {s,g}ettime64 stuff later today.


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

