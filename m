Subject: Re: [Dovetail PATCH 0/5] More clock and IRQ abstraction
References: <20210327103524.2305814-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7acd9723-dbce-637c-5cb4-90c09d7847b6@siemens.com>
Date: Wed, 7 Apr 2021 18:20:55 +0200
MIME-Version: 1.0
In-Reply-To: <20210327103524.2305814-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 27.03.21 11:35, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Jan Kiszka (1):
>   cobalt/intr: dovetail: Don't do anything in xnintr_enable/disable
> 
> Philippe Gerum (4):
>   cobalt/syscall: dovetail: do not expose clock frequency to user
>   cobalt/sched: dovetail: disable separate per-IRQ statistics
>   cobalt/intr: pipeline: abstract interrupt system inits
>   cobalt/intr: dovetail: implement interrupt management, handling
> 
>  include/cobalt/kernel/dovetail/pipeline/irq.h |  24 ++++
>  .../kernel/dovetail/pipeline/pipeline.h       |   6 +
>  include/cobalt/kernel/intr.h                  |   7 +-
>  include/cobalt/kernel/ipipe/pipeline/irq.h    |  14 ++
>  .../cobalt/kernel/ipipe/pipeline/pipeline.h   |   6 +
>  kernel/cobalt/Kconfig                         |   4 +-
>  kernel/cobalt/dovetail/Makefile               |   2 +-
>  kernel/cobalt/dovetail/intr.c                 | 129 ++++++++++++++++++
>  kernel/cobalt/posix/syscall.c                 |   2 +-
>  9 files changed, 185 insertions(+), 9 deletions(-)
>  create mode 100644 include/cobalt/kernel/dovetail/pipeline/irq.h
>  create mode 100644 include/cobalt/kernel/ipipe/pipeline/irq.h
>  create mode 100644 kernel/cobalt/dovetail/intr.c
> 

Patches 1-3 applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

