MIME-Version: 1.0
Sender: andret7@gmail.com
In-Reply-To: <20160422132926.GE1780@hermes.click-hack.org>
References: <CAMQ-e4_L=X+8Nn5R+LnsEgtz4ZRgz8KaN48qhV-4vFCwpkFt5A@mail.gmail.com>
 <5719E9A4.5050701@xenomai.org>
 <CAMQ-e4_PrqpX3Eo8nQLo8k4B9aEKPXTEe1Ug4bThcA3kpA2aOA@mail.gmail.com>
 <20160422132926.GE1780@hermes.click-hack.org>
From: Andrea <andrea.schiappacasse@camelotbio.com>
Date: Fri, 22 Apr 2016 16:57:29 +0200
Message-ID: <CAMQ-e49mWXPShiX9S=MQ2LB10AHwrqGSW=AiOzPkAnbHpH-p-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Assertion failed on "test posix_clock" on some
 executions of xeno-test.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Hi Gilles, thanks for your answer,
I verified and I can reproduce it with nothing running in background.

By the way, this was the output of autotune, I forgot to attach to my
previous message.

/usr/xenomai/sbin# ./autotune
== auto-tuning started, period=100000 ns (may take a while)
irq gravity... 0 ns
kernel gravity... 999 ns
user gravity... 999 ns
== auto-tuning completed after 8s

Andrea

2016-04-22 15:29 GMT+02:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On Fri, Apr 22, 2016 at 02:32:19PM +0200, Andrea wrote:
> > Hi Philippe, thanks for your answer,
> >
> > I ran autotune but the output didn't change, sometimes the assertion just
> > fails as before.
> > Do you think that it could lead to any problem in the standard Xenomai
> > usage? Or is it something that I may safely ignore? I didn't notice any
> > strange behaviour so far, but I'm wondering if this could be an indicator
> > of something going wrong in the system I'm testing.
> >
> > Just in case it can be of any use, you can find attached the config of my
> > kernel.
>
> Are you sure that nothing else is running in the background? Like
> dohell processes from the previous run? Most of the unit test are
> supposed to be run on the machine with no load.
>
> --
>                                             Gilles.
> https://click-hack.org
>
