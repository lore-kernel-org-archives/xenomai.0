Subject: Re: [dovetail][PATCH v3 0/3] Fix state corruption on fault migration, 
 cleanups
References: <cover.1623046779.git.jan.kiszka@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <2c8d62b2-c712-6eae-c57e-e8c5e85e934b@siemens.com>
Date: Mon, 7 Jun 2021 17:03:45 +0200
In-Reply-To: <cover.1623046779.git.jan.kiszka@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 07.06.21 08:19, Jan Kiszka via Xenomai wrote:
> Changes in v3:
>  - do not track oob stalling on iryentry
>  - add check that oob is unstalled on irqentry
> 
> Jan
> 
> Jan Kiszka (3):
>   irq_pipeline: Clean up stage_info field and users
>   irq_pipeline: Account for stage migration across faults
>   irq_pipeline: Warn when calling irqentry_enter with oob stalled
> 
>  arch/x86/kernel/irq_pipeline.c |  2 +-
>  arch/x86/mm/fault.c            |  2 +-
>  include/linux/entry-common.h   | 11 ++++++++---
>  kernel/entry/common.c          | 17 ++++++++++-------
>  4 files changed, 20 insertions(+), 12 deletions(-)
> 

Tested and Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>

I stressed my system for a few hours with the stress-ng workload that
was triggering the complete system hang. Normally the system was dead
after 40-50 minutes, it survived for at least a couple of hours now.

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

