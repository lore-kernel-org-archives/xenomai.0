Subject: Re: [PATCH 0/6] y2038: clock_getres64 and clock_adjtime64
References: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <364d983d-799e-97cc-d34b-fd6180c75a90@siemens.com>
Date: Fri, 4 Jun 2021 15:23:19 +0200
MIME-Version: 1.0
In-Reply-To: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
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

On 01.06.21 15:31, Florian Bezdeka wrote:
> Hi!
> 
> The next set of changes for fixing the y2038 problem for Xenomai:
> 
>   - clock_getres64
>   - clock_adjtime64 (only relevant for external clocks, so with limited
>     testing)
> 
> Once again: Patches provided by Song, fixes like style adjustments,
> updated error handling, fixing failing tests done by me and squashed into
> the patch that introdoced the problem.
>  
> Best regards,
> Florian
> 
> Song Chen (3):
>   y2038: cobalt/posix/clock: Adding clock_adjtime64
>   y2038: lib/cobalt/clock: dispatch clock_adjtime
>   y2038: testsuite/smokey/y2038: testcase for adjtime64
> 
> chensong (3):
>   y2038: cobalt/posix/clock: Adding clock_getres64
>   y2038: lib/cobalt/clock: dispatch clock_getres
>   y2038: testsuite/smokey/y2038: testcase for getres64
> 
>  include/cobalt/uapi/syscall.h          |   2 +
>  kernel/cobalt/posix/clock.c            |  48 ++++++++++-
>  kernel/cobalt/posix/clock.h            |  12 +++
>  kernel/cobalt/posix/syscall32.c        |  14 ++++
>  kernel/cobalt/posix/syscall32.h        |   8 ++
>  lib/cobalt/clock.c                     |  10 +++
>  testsuite/smokey/y2038/syscall-tests.c | 105 +++++++++++++++++++++++++
>  7 files changed, 198 insertions(+), 1 deletion(-)
> 

Thanks, also applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

