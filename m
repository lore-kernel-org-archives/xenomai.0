MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Fri, 8 Dec 2017 11:14:25 +0000
Message-ID: <CAKJ14NcFezd4xy7R3vCQ2m4E7FREFJMQG_2fTmuZ=L6icKQbnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] xenomai 3.0.3 POSIX rtnet API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jacklee11@foxmail.com

> Message: 4
> Date: Thu, 7 Dec 2017 10:35:59 +0800
> From: JackLee <jacklee11@foxmail.com>
> To: xenomai@xenomai.org
> Subject: [Xenomai] xenomai 3.0.3 POSIX rtnet API
> Message-ID:
>         <830662c3-0cbc-78ab-b7ab-4568616793a7@foxmail.com>+45245C193B26E5A4
> Content-Type: text/plain; charset=utf-8; format=flowed
>
> Hi, all,
>
>  ? My Xenomai version is 3.0.3 and I use the POSIX API with the
> following build options.
>
>
> XENO_CONFIG := /usr/xenomai/bin/xeno-config
> CFLAGS := $(shell $(XENO_CONFIG) --vxworks --cflags)
> LDFLAGS := $(shell $(XENO_CONFIG) --vxworks --ldflags)
> CC := $(shell $(XENO_CONFIG) --cc)

You say you're using the POSIX API, but these compiler options have
the --vxworks switch... so something's not right....

>
>  ? What APIs can I use for RTnet?
>
>  ? The Link below uses alchemy APIs?
>
> http://xenomai.org/rtnet-programming/
>

Basically, RTnet API calls can be derived from the equivalent POSIX
API calls by sticking rt_dev_ in front of the original POSIX API call
(e.g. socket() -> rt_dev_socket(), bind() -> rt_dev_bind(), ...). If
you're using the Alchemy API then you have to do this manually. If
you're using the Xenomai POSIX API instead, then the linker does this
for you with the symbol wrapper script (so it auto replaces e.g.
bind() with rt_dev_bind() before linking it to the rtdm library). In
both cases you also need to link to the rtdm API. I don't remember all
the details right now as I'm using Xenomai 2 at work, but I'll try to
look it up this weekend...

A.

