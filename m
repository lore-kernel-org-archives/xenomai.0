References: <9b5a8f4bb2b90758bc94f4fa7c7d96a4c3a0040a.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Where is <mercury/wrappers.h>?
In-reply-to: <9b5a8f4bb2b90758bc94f4fa7c7d96a4c3a0040a.camel@siemens.com>
Date: Mon, 15 Feb 2021 19:28:51 +0100
Message-ID: <87sg5xi3rw.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: xenomai@xenomai.org


florian.bezdeka--- via Xenomai <xenomai@xenomai.org> writes:

> Hi all,
>
> I'm currently inspecting the code base regarding Y2038 problem (=
> overflow of 32 bit time_t in January 2038) and trying to list /
> summarize all affected APIs / drivers / ...
>
> In include/copperplate/wrappers.h we have:
> #include <mercury/wrappers.h>
>
> I guess this is broken since 
> 1fbf0f398064 ("lib/boilerplate: introduce ancillary service layer").
> Right?

Sorry, -ENOPARSE. What may be broken?

>
> Background:
> I'm trying to find the right expansion for __RT() used by the alchemy
> library, e.g. in lib/alchemy/pipe.c. I found two possibilities so far:
>
> - include/cobalt/wrappers.h
> - include/mercury/boilerplate/wrappers.h
>
> Which one is being used by the alchemy library? I was not able to find
> my way through all the include directories and include paths...
>

If you build for Mercury, libcobalt is not involved, Alchemy and other
non-POSIX APIs are built on top of libcopperplate -> *libc
directly. This is merely a native build for prototyping, or running the
APIs on top of PREEMPT_RT. So in this case, __RT() and __STD() expand to:

#define __RT(call)	call
#define __STD(call)	call

meaning, we don't route the call to libcobalt but to the regular
*libc. This is defined in include/mercury/boilerplate/wrappers.h.

So, for a Cobalt-based build:

    include/copperplate/wrappers.h -> include/cobalt/boilerplate/wrappers.h.

For a Mercury build:

    include/copperplate/wrappers.h -> include/mercury/boilerplate/wrappers.h.
-- 
Philippe.

