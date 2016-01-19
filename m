References: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
 <5697D9DB.6070909@xenomai.org>
 <CA+CJOCyPzwWEQScYL=hjzntHxGFq_oF+qen8WF+LEdZWoDAtnQ@mail.gmail.com>
 <569CD2BB.7000405@xenomai.org>
 <CA+CJOCw1MVqfB8524L3+MXAtfp=UDHP_=1YnDJorJOYb4zdBSQ@mail.gmail.com>
 <569D027B.7040800@xenomai.org>
 <CA+CJOCzZPC+ja-R4m+bwnYhOFRQp-cd1Ag0UB0h5OKN6ZhEWDw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <569DF24E.4080202@xenomai.org>
Date: Tue, 19 Jan 2016 09:22:38 +0100
MIME-Version: 1.0
In-Reply-To: <CA+CJOCzZPC+ja-R4m+bwnYhOFRQp-cd1Ag0UB0h5OKN6ZhEWDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] VxWorks API on Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>
Cc: xenomai@xenomai.org

On 01/18/2016 07:15 PM, Nicolas SCHURANDO wrote:
> Hi Philippe,
> 
> I switched to branch stable-3.0.x, retrieved your commit b411e4c
> "lib/cobalt: add init trace points", and rebuilt everything.
> 
> Below is what I have with the new --trace option.
> 
> With static linking : 
> 
>     --  xenomai_init() running
>     --  cobalt->init()
>     --  connected to Cobalt
>     --  memory locked
>     --  memory heaps mapped
>     --  boilerplate->init()
>        0"000.070| WARNING: [main] Xenomai compiled with full debug enabled,
>                                   very high latencies expected
>     [--enable-debug=full]
>     --  initialization complete
>      [i] [main] Hello, launching root task ...
>        0"001.747| BUG in wind_task_normalize_priority(): 

The init call for the VxWorks API is missing, which explains the issue.

> 
> 
> I also decided to try with dynamic linking as well, to see if it was
> producing anything different :
> 
>     --  xenomai_init() running
>     --  cobalt->init()
>     --  connected to Cobalt
>     --  memory locked
>     --  memory heaps mapped
>     --  boilerplate->init()
>     --  copperplate->init()
>     --  vxworks->init()

The issue is most likely with static linking. It seems that the linker
is eliminating the interface setup descriptor in lib/vxworks/init.c from
the final executable; unfortunately this is a library constructor,
connecting the API to the system. We already stumbled upon this issue,
but no fix could be found at this point, with toolchains ignoring
explicit requests to keep such symbols into the name list.

Some (likely terminally ugly) work around may exist, but support for
static linking is very low priority here, so I would advise to stay with
dynamic linking for now.

>        0"016.431| WARNING: [rpi-test-bug-wa] low resolution clock
>     disabled [--enable-lores-clock]

--enable-lores-clock when configuring is required by tick-based APIs.

-- 
Philippe.

