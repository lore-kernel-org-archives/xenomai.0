From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <1282320412.1730.637.camel@domain.hid>
References: <1282319702.5255.405.camel@domain.hid>
	<1282320412.1730.637.camel@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 20 Aug 2010 18:20:52 +0200
Message-Id: <1282321252.5255.415.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] rt timer jitter
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2010-08-20 at 18:06 +0200, Philippe Gerum wrote:
> On Fri, 2010-08-20 at 17:55 +0200, Krzysztof Błaszkowski wrote:
> > Do you have any idea about reducing rt timer jitter ?
> > I experience annoyingly big jitter in a thread which is supposed to run
> > at 400us (i reckon this is nothing extra demanding from atom @1.6G)
> > 
> > 
> > the thread's loop looks like:
> > 
> > {
> > function1()
> > ..2()
> > ..3()
> > ..4()
> > 
> > rt_task_wait_period()
> > }
> > 
> > (^yet another simplified model^)
> 
> This is the typical pattern of the latency test. What figures do you get
> with:
> 
> # /usr/xenomai/bin/latency -t0
> ...
> # /usr/xenomai/bin/latency -t1
> 

t0:

RTS|     -1.337|     -0.039|     13.285|       0|     0|
00:02:13/00:02:13


i can't run t1 because of missing seno_timerbench.ko (i have no idea how
to find a config option which would build it)

-- 
Krzysztof Blaszkowski


