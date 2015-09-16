From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <CAFkYNwaqLYu7vAAyAt6Q9qfKL4iBa+N1BuzgJWhN6z4NfA5U=g@mail.gmail.com>
Date: Wed, 16 Sep 2015 13:24:33 -0400
In-Reply-To: <CAFkYNwaqLYu7vAAyAt6Q9qfKL4iBa+N1BuzgJWhN6z4NfA5U=g@mail.gmail.com>
 (vibnwis@gmail.com's message of "Thu, 17 Sep 2015 01:31:46 +1200")
Message-ID: <44k2rqz38u.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Error code -19
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: xenomai@xenomai.org

vibnwis <vibnwis@gmail.com> writes:

> I am a newbie and I believe code -19 has been asked before.

That is just reporting ENODEV.

It doesn't tell you much, although it usually means a missing timer.

> My system is made of
>
> arch = arm
> board = PandaBoard ES
> Kernel = 3.18.12
> Patch  =
> xenomai-3/kernel/cobalt/arch/arm/patches/ipipe-core-3.18.12-arm-4.patch
>
> output of dmesg | grep -i xenomai:
> [    1.733825] [Xenomai] scheduling class idle registered.
> [    1.733856] [Xenomai] scheduling class rt registered.
> [    1.734588] [Xenomai] init failed, code -19

If I-pipe reports finding a suitable timer, it may just be having
problems registering it. Look for I-pipe and scheduler messages in your
boot log.

Your board has some kind of OMAP processor. It's a Cortex-A9 CPU core,
so it should work without much problem. The example at
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#The_Cortex-A9_case
is dealing with an extremely similar chip.

