Subject: Re: [PATCH v2 0/3] y2038: Adding monitor_wait64()
References: <20210811081120.18402-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0a3ba1e0-5432-22a2-6b70-ef186cb5a1e7@siemens.com>
Date: Fri, 13 Aug 2021 09:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <20210811081120.18402-1-florian.bezdeka@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 11.08.21 10:11, Florian Bezdeka wrote:
> Hi!
> 
> Just another y2038 related syscall, once again based on v1 sent out by
> Song and rebased to current next.
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (2):
>   y2038: cobalt/posix/monitor: Adding monitor_wait64
>   y2038: testsuite/smokey/y2038: Adding testcases for monitor_wait64()
> 
> Song Chen (1):
>   y2038: lib/cobalt/internal: dispatch monitor_wait
> 
>  include/cobalt/uapi/syscall.h          |  1 +
>  kernel/cobalt/posix/monitor.c          | 32 ++++++++++-
>  kernel/cobalt/posix/monitor.h          | 10 ++++
>  kernel/cobalt/posix/syscall32.c        |  8 +++
>  kernel/cobalt/posix/syscall32.h        |  6 ++
>  kernel/cobalt/trace/cobalt-posix.h     |  3 +-
>  lib/cobalt/internal.c                  |  8 ++-
>  testsuite/smokey/y2038/syscall-tests.c | 78 +++++++++++++++++++++++++-
>  8 files changed, 141 insertions(+), 5 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

