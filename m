Subject: Re: [RFC PATCH v2 1/4] y2038: Fixing the sem_timedwait syscall for 32
 bit systems
References: <87h7lqzzzw.fsf@xenomai.org>
 <20210308170206.313181-1-florian.bezdeka@siemens.com>
 <20210308170206.313181-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <95879ecb-09d5-79b4-34a3-91d3ca58bd0f@siemens.com>
Date: Mon, 8 Mar 2021 18:12:05 +0100
MIME-Version: 1.0
In-Reply-To: <20210308170206.313181-2-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org, rpm@xenomai.org, chensong@kylinos.cn

On 08.03.21 18:02, Florian Bezdeka wrote:
> On systems using 32 bit for time_t the sem_timedwait syscall was broken
> because the function used for copying the timeout value from userspace
> to kernel (=sem_fetch_timeout()) was always copying
> sizeof(struct timespec64).
> 
> A 32 bit application (or more specific an application with 4 byte
> time_t) would only provide sizeof(struct old_timespec32).
> 
> Notable changes:
>   - The copy operation from userspace to kernel is now already done in
>     the syscall handler. So it is always done. Previously it was copied
>     over and validated before the first use (when used at all).
>     So we have some additional instructions now that may be
>     unnecessary, but that simplifies the code.
> 
>   - Validation: Switched to timespec64_valid() instead of our own
>     check.
> 
> Fixes: 8043eccd232d ("cobalt/kernel: y2038: convert struct timespec to timespec64")

This patch was dropped from next again (and that sha was never applied).
We should go a for fixed version of that series (patches 2..5, only
patch 1 is now applied).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

