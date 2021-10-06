Subject: Re: [PATCH v5 0/3] y2038: Adding recvmmsg64
References: <20211006135415.223689-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a769c9e1-0262-9f0d-bb85-497cb93f3939@siemens.com>
Date: Wed, 6 Oct 2021 17:31:22 +0200
MIME-Version: 1.0
In-Reply-To: <20211006135415.223689-1-florian.bezdeka@siemens.com>
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

On 06.10.21 15:54, Florian Bezdeka wrote:
> Hi,
> 
> Just another y2038 related syscall, once again based on v4 sent out by
> Song with the following changes (squashed into the affected patches):
> 
> - rebased to current next (especially patch 3)
> - minor code cleanups / reformattings
> - Added the syscall name to the tracing infrastructure
> - Switched the test from CLOCK_REALTIME to CLOCK_MONOTONIC
> 
> Best regards,
> Florian
>  
> 
> Song Chen (3):
>   y2038: cobalt/posix/io: Adding recvmmsg64
>   y2038: lib/cobalt/rtdm: dispatch recvmmg
>   y2038: testsuite/smokey/y2038: testcase for recvmmsg64
> 
>  include/cobalt/kernel/rtdm/fd.h        |   5 +
>  include/cobalt/uapi/syscall.h          |   1 +
>  kernel/cobalt/posix/io.c               |   9 ++
>  kernel/cobalt/posix/io.h               |   5 +
>  kernel/cobalt/posix/syscall32.c        |   9 ++
>  kernel/cobalt/posix/syscall32.h        |   6 ++
>  kernel/cobalt/rtdm/fd.c                |  21 +++-
>  kernel/cobalt/trace/cobalt-posix.h     |   3 +-
>  lib/cobalt/rtdm.c                      |   5 +
>  testsuite/smokey/y2038/syscall-tests.c | 127 +++++++++++++++++++++++++
>  10 files changed, 189 insertions(+), 2 deletions(-)
> 

Thanks, applied to next (with that minor style tweak).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

