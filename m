Subject: =?UTF-8?Q?Re=3a_ERR_MSG=ef=bc=9a_called_regular_read=28=29_on_/dev/?=
 =?UTF-8?Q?rtdm/fake=5fdev?=
References: <CAAvDm6bm0dd5KMfZuC9n2f8h7hBJb4ppmigKdQhfwEEy1_SRrQ@mail.gmail.com>
 <782cb718-1bfb-c933-6ce4-0c29c40a28c1@siemens.com>
 <CAAvDm6aYF9E0maLf9+KFYAHqAJf9HxHAXExAeuf=j3fAA68WuQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cc1d6e4f-ab28-06a6-5afe-ebc5c6d85775@siemens.com>
Date: Thu, 16 Apr 2020 11:14:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6aYF9E0maLf9+KFYAHqAJf9HxHAXExAeuf=j3fAA68WuQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 16.04.20 11:09, 孙世龙 wrote:
> Hi,
>        I am using native calls.I intentionally not to use the posix 
> calls to avoid the conflicts with the posix calls provided by linux.
>        My makefile is listed below.
> 
>       My makefile:
> 
>       CFLAGS  := $(shell $(XENO_CONFIG) --skin=native --cflags) -Wall
>       LDFLAGS := $(shell $(XENO_CONFIG) --skin=native --ldflags)

Then you need to mark the POSIX IO calls that target your RTDM device 
with __RT() explicitly.

Jan

> 
>      Look forward to hearing from you.
>      Thanks a lot.
> 
> Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> 于 
> 2020年4月16日周四 下午5:01写道：
> 
>     On 16.04.20 10:57, 孙世龙 via Xenomai wrote:
>      > Hi,
>      >         I got the error message listed below when I called read
>     operation to
>      > an opened rtdm file handle in main function.
>      >         I have implemented the rt read operation in my rtdm
>     driver allready.
>      >         I think the main thread is allready turned into xenomai
>     thread
>      > because I have called rt_shadow_task function before the reading
>     opreation.
>      >         I wonder why this error message occurs.
>      >
>      >         Error message from kernel.
>      >         [155453.637967] [Xenomai] task@1[42395][42395] called
>     regular read()
>      > on /dev/rtdm/fake_dev.
>      >         Look forward to hearing from you.
>      >        Thanks a lot.
>      >
> 
>     Your application is not properly wrapping the posix calls, in this case
>     read. Check you makefile, ensure that you use the output of
>     "xeno-config
>     --skin posix --ldflags" for linking.
> 
>     Jan
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

