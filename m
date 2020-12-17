Subject: Re: [PATCH 0/3] Dovetail:
References: <20201216164455.158920-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <afb9c1f6-8591-2d62-34f1-ccbc2e1905b0@siemens.com>
Date: Thu, 17 Dec 2020 18:22:59 +0100
MIME-Version: 1.0
In-Reply-To: <20201216164455.158920-1-rpm@xenomai.org>
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

On 16.12.20 17:44, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> This series starts introducting an abstraction layer between the core
> and the interrupt pipeline interface, either Dovetail or the legacy
> I-pipe.
> 
> Although the goal is to enable Cobalt on top of Dovetail eventually,
> we keep the ability to interface with the I-pipe using a build time
> switch, in order to make it easier to pinpoint regressions by
> comparing the behaviour of the common code based on the different
> pipeline infrastructures.
> 
> Eventually, the Cobalt implementation should branch off at the
> following points:
>     
> - kernel/cobalt/{ipipe, dovetail}/arch, the arch-specific
>   implementation which overwhelmingly depends on the pipeline flavour.
>     
> - kernel/cobalt/{ipipe, dovetail}, the generic Cobalt code calling
>   pipeline services.
>     
> - kernel/cobalt/include/{ipipe, dovetail}, the client glue types and
>   definitions pulled into some basic kernel types by the pipeline
>   implementation (e.g. the thread_info extension structure).
>     
> - include/cobalt/kernel/{ipipe, dovetail}, the generic Cobalt headers
>   depending on services and definitions the pipeline provides for.
> 
> We start with the machine-specific, IRQ management support.
> 
> Philippe Gerum (3):
>   cobalt/kernel: substitute ipipe_processor_id() with
>     raw_smp_processor_id()
>   cobalt/init: pipeline: abstract pipeline-specific inits
>   cobalt/intr: pipeline: IRQ management code is pipeline-specific
> 
>  include/cobalt/kernel/assert.h                |   2 +-
>  .../cobalt/kernel/ipipe/pipeline/machine.h    |  71 ++++++++++
>  include/cobalt/kernel/lock.h                  |   4 +-
>  kernel/cobalt/Makefile                        |   3 +-
>  kernel/cobalt/arch/arm/thread.c               |  10 +-
>  kernel/cobalt/arch/arm64/thread.c             |   2 +-
>  kernel/cobalt/arch/x86/thread.c               |   6 +-
>  kernel/cobalt/debug.c                         |   2 +-
>  .../include/asm-generic/xenomai/machine.h     |  51 +-------
>  kernel/cobalt/init.c                          | 121 +-----------------
>  kernel/cobalt/ipipe/Makefile                  |   3 +
>  kernel/cobalt/ipipe/init.c                    | 116 +++++++++++++++++
>  kernel/cobalt/{ => ipipe}/intr.c              |   0
>  scripts/prepare-kernel.sh                     |   2 +
>  14 files changed, 212 insertions(+), 181 deletions(-)
>  create mode 100644 include/cobalt/kernel/ipipe/pipeline/machine.h
>  create mode 100644 kernel/cobalt/ipipe/Makefile
>  create mode 100644 kernel/cobalt/ipipe/init.c
>  rename kernel/cobalt/{ => ipipe}/intr.c (100%)
> 

Thanks, all applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

