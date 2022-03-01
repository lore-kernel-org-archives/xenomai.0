Message-ID: <df8bc468-69f0-2216-7ff7-6010a2a1bb6d@siemens.com>
Date: Tue, 1 Mar 2022 19:29:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] y2038: Fixes for compat mode
Content-Language: en-US
References: <20220221132504.55876-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220221132504.55876-1-florian.bezdeka@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
Cc: johannes.lauenstein@siemens.com

On 21.02.22 14:25, Florian Bezdeka wrote:
> I started testing the compat mode on a Ubuntu based system with glibc
> 2.34 which supports switching to 64 bit based time_t. These are the fixes
> for problems observed while testing the kernel / cobalt part.
> 
> More tests, especially for the libcobalt part will be necessary,
> especially because the way how glibc implemented the switch to 64 bit
> time_t affects the function wrapping we use.
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (3):
>   y2038: posix/mqueue: Fix compat case for mq_timedreceive64
>   y2038: cobalt: rtdm/fd: Take care of compat mode for recvmmsg64
>   y2038: cobalt: posix/signal: Take care of compat mode for
>     sigtimedwait64
> 
>  .../x86/include/asm/xenomai/syscall32-table.h |  3 +++
>  kernel/cobalt/posix/mqueue.c                  | 26 +++++++++----------
>  kernel/cobalt/posix/mqueue.h                  |  2 +-
>  kernel/cobalt/posix/syscall32.c               | 17 ++++++++++--
>  kernel/cobalt/posix/syscall32.h               |  3 ++-
>  5 files changed, 34 insertions(+), 17 deletions(-)
> 

Applied all, but we likely need more thunks, see comment on patch 3

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

