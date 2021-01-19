Subject: Re: [PATCH Dovetail v2 0/5] Get rid of the APC interface
References: <20210117150803.477767-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f18cd146-2c9e-d62b-1873-6fb191461079@siemens.com>
Date: Tue, 19 Jan 2021 12:44:59 +0100
MIME-Version: 1.0
In-Reply-To: <20210117150803.477767-1-rpm@xenomai.org>
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

On 17.01.21 16:07, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> This is v2, fixing the header install rule in the wake of the API
> removal.
> 
> Philippe Gerum (5):
>   cobalt/pipe: drop dependency on APCs
>   cobalt/registry: drop dependency on APCs
>   cobalt/select: drop dependency on APCs
>   cobalt/machine: drop obsolete APC bits
>   cobalt/apc: drop obsolete APC mechanism
> 
>  include/cobalt/kernel/Makefile.am             |   1 -
>  include/cobalt/kernel/apc.h                   |  32 ---
>  .../cobalt/kernel/ipipe/pipeline/machine.h    |   9 -
>  include/cobalt/kernel/rtdm/driver.h           |   1 -
>  kernel/cobalt/ipipe/Makefile                  |   2 +-
>  kernel/cobalt/ipipe/apc.c                     | 202 ------------------
>  kernel/cobalt/ipipe/init.c                    |  19 --
>  kernel/cobalt/pipe.c                          |  26 ++-
>  kernel/cobalt/procfs.c                        |  42 ----
>  kernel/cobalt/registry.c                      |  30 +--
>  kernel/cobalt/rtdm/core.c                     |   1 -
>  kernel/cobalt/select.c                        |  23 +-
>  12 files changed, 49 insertions(+), 339 deletions(-)
>  delete mode 100644 include/cobalt/kernel/apc.h
>  delete mode 100644 kernel/cobalt/ipipe/apc.c
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

