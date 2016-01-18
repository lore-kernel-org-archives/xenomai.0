MIME-Version: 1.0
In-Reply-To: <569D027B.7040800@xenomai.org>
References: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
 <5697D9DB.6070909@xenomai.org>
 <CA+CJOCyPzwWEQScYL=hjzntHxGFq_oF+qen8WF+LEdZWoDAtnQ@mail.gmail.com>
 <569CD2BB.7000405@xenomai.org>
 <CA+CJOCw1MVqfB8524L3+MXAtfp=UDHP_=1YnDJorJOYb4zdBSQ@mail.gmail.com>
 <569D027B.7040800@xenomai.org>
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Mon, 18 Jan 2016 19:15:36 +0100
Message-ID: <CA+CJOCzZPC+ja-R4m+bwnYhOFRQp-cd1Ag0UB0h5OKN6ZhEWDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] VxWorks API on Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

I switched to branch stable-3.0.x, retrieved your commit b411e4c
"lib/cobalt: add init trace points", and rebuilt everything.

Below is what I have with the new --trace option.

With static linking :

> --  xenomai_init() running
> --  cobalt->init()
> --  connected to Cobalt
> --  memory locked
> --  memory heaps mapped
> --  boilerplate->init()
>    0"000.070| WARNING: [main] Xenomai compiled with full debug enabled,
>                               very high latencies expected
> [--enable-debug=full]
> --  initialization complete
>  [i] [main] Hello, launching root task ...
>    0"001.747| BUG in wind_task_normalize_priority():


I also decided to try with dynamic linking as well, to see if it was
producing anything different :

> --  xenomai_init() running
> --  cobalt->init()
> --  connected to Cobalt
> --  memory locked
> --  memory heaps mapped
> --  boilerplate->init()
> --  copperplate->init()
> --  vxworks->init()
>    0"016.431| WARNING: [rpi-test-bug-wa] low resolution clock disabled
> [--enable-lores-clock]
>    0"019.474| WARNING: [rpi-test-bug-wa] vxworks_init: failed to
> initialize VxWorks clock (res=1000000 ns)
>    0"022.093| WARNING: [main] setup call vxworks failed
>    0"024.535| BUG in xenomai_init(): [main] initialization failed, EINVAL


Regards

2016-01-18 16:19 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:

> On 01/18/2016 01:34 PM, Nicolas SCHURANDO wrote:
> > Hi Philippe,
> >
> > In your previous message you suggested that something might be wrong
> > with the way the application is initialized. And my message was an
> > attempt at further describing what I had already done.
> >
> > Oh, I see. I suppose the tense of my message was misleading. I meant
> > that I had already read the documentation prior to reaching out to you,
> > and the compiler and linker commands above are the one I had already
> used.
> >
> > Are you confirming that the init seems to happen fine ? And if so, what
> > could explain the error I get when trying to spawn the VxWorks task ?
> >
>
> The only reason would be that copperplate_init() did not run, which
> means that your application init sequence does not work as expected.
>
> You may want to pick the latest changes from stable-3.0.x, and start
> your application with the --trace option. This will trace the init
> sequence from xenomai_init() onward. For a VxWorks application based on
> the copperplate layer running over Cobalt, you should see something
> along these lines:
>
> # /your/application --trace
> --  xenomai_init() running
> --  cobalt->init()
> --  connected to Cobalt
> --  memory locked
> --  memory heaps mapped
> --  boilerplate->init()
> --  copperplate->init()
> --  alchemy->init()
> --  initialization complete
>
> If you don't see such output, then something is wrong.
>
> --
> Philippe.
>
