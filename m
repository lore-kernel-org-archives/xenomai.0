Subject: Re: [PATCH v2 0/5] y2038: Adding support for mq_timed{send,recv}64
References: <20210731071942.69806-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <559efe19-d3cb-2130-d167-e801bf86217f@siemens.com>
Date: Mon, 2 Aug 2021 11:10:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210731071942.69806-1-florian.bezdeka@siemens.com>
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

On 31.07.21 09:19, Florian Bezdeka wrote:
> Hi all,
> 
> this is kind of a re-send of the patch series originall published by
> Song. There were some things that had to be addressed:
> 
>  - Code formattings
>  - Copy paste errors in the test suite
>  - Failing / incomplete tests, missing test cleanups
>  - Incorrect compat syscall declerations
> 
> @Song: Especially the missing test cleanups and the incorrect compat
> syscall declerations made me unhappy. Did you really test that once?
> Please make sure to send properly tested patches. There are many
> pitfalls in the game which makes the review process time consuming,
> especially when I have to assume that it was not tested till now.
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (1):
>   y2038: testsuite/smokey/y2038: Adding tests for mq_timed{send,recv}64
> 
> Song Chen (4):
>   y2038: cobalt/posix/mqueue: Adding mq_timedsend64
>   y2038: lib/cobalt/mqueue: dispatch mq_timedsend
>   y2038: cobalt/posix/muqueue: Adding mq_timedreceive64
>   y2038: lib/cobalt/mqueue: dispatch mq_timedreceive
> 
>  include/cobalt/uapi/syscall.h          |   2 +
>  kernel/cobalt/posix/mqueue.c           |  49 ++++++-
>  kernel/cobalt/posix/mqueue.h           |  18 +++
>  kernel/cobalt/posix/syscall32.c        |  16 +++
>  kernel/cobalt/posix/syscall32.h        |  10 ++
>  kernel/cobalt/trace/cobalt-posix.h     |   4 +-
>  lib/cobalt/mq.c                        |  10 ++
>  testsuite/smokey/y2038/syscall-tests.c | 177 ++++++++++++++++++++++++-
>  8 files changed, 283 insertions(+), 3 deletions(-)
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

