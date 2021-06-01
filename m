Subject: Re: [PATCH 0/3] y2038:clock_getres for timespec64
References: <1619508284-15215-1-git-send-email-chensong_2000@189.cn>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <c61665f2-87de-f406-65b4-215a1fb5278c@siemens.com>
Date: Tue, 1 Jun 2021 13:49:27 +0200
In-Reply-To: <1619508284-15215-1-git-send-email-chensong_2000@189.cn>
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
To: Song Chen <chensong_2000@189.cn>, xenomai@xenomai.org

On 27.04.21 09:24, Song Chen wrote:
> This patch serial is aimed to introduce a new syscall clock_getres64
> which is specific for 64-bit time_t.
> 
> chensong (3):
>   y2038: cobalt/posix/clock: Adding clock_getres64
>   y2038: lib/cobalt/clock: dispatch clock_getres
>   y2038: testsuite/smokey/y2038: testcase for getres64
> 
>  include/cobalt/uapi/syscall.h          |  1 +
>  kernel/cobalt/posix/clock.c            | 26 ++++++++++++++++++++++++-
>  kernel/cobalt/posix/clock.h            |  6 ++++++
>  kernel/cobalt/posix/syscall32.c        |  7 +++++++
>  kernel/cobalt/posix/syscall32.h        |  4 ++++
>  lib/cobalt/clock.c                     |  5 +++++
>  testsuite/smokey/y2038/syscall-tests.c | 35 ++++++++++++++++++++++++++++++++++
>  7 files changed, 83 insertions(+), 1 deletion(-)
> 

I applied this series to florian/y2038 with minor test adjustments. Will
resend soon.

Best regards,
Florian

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

