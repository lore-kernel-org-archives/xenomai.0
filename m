Message-ID: <48B51FD0.1030300@domain.hid>
Date: Wed, 27 Aug 2008 11:35:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid>
In-Reply-To: <48B3ED52.7080101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 0/6] Registry-related cleanups
	and	improvements
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Here comes the complete series of patches to improve the Xenomai
> registry. #1, #5, and #6 are resends of already posted patches, the
> middle part is fresh from the editor. The series reduces overhead
> and simplifies the registry code. Overall diffstat:
>

Merged, thanks.

>  include/asm-generic/hal.h  |   10 +-
>  include/nucleus/registry.h |   10 --
>  ksrc/arch/generic/hal.c    |   18 +--
>  ksrc/arch/generic/nmi.c    |    6 -
>  ksrc/arch/x86/nmi_32.c     |    6 -
>  ksrc/nucleus/module.c      |   58 ++++-------
>  ksrc/nucleus/registry.c    |  223 ++++++++++++++++++++++-----------------------
>  ksrc/skins/native/alarm.c  |   22 +---
>  ksrc/skins/native/buffer.c |   15 ---
>  ksrc/skins/native/cond.c   |   14 --
>  ksrc/skins/native/event.c  |   15 ---
>  ksrc/skins/native/heap.c   |   14 --
>  ksrc/skins/native/intr.c   |   17 ---
>  ksrc/skins/native/mutex.c  |   15 ---
>  ksrc/skins/native/pipe.c   |   14 --
>  ksrc/skins/native/queue.c  |   12 --
>  ksrc/skins/native/sem.c    |   14 --
>  ksrc/skins/native/task.c   |   16 ---
>  18 files changed, 182 insertions(+), 317 deletions(-)
> 
> So a net gain of more than 130 LOC.
> 
> The series passed basic tests on my virtual target.
> 
> Jan
> 


-- 
Philippe.

