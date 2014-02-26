MIME-Version: 1.0
In-Reply-To: <530E6159.4050204@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
 <530CFB0D.8040001@xenomai.org>
 <CAEbDrgkJCnbWu_J4svoXOU1x2rz=n95A5+3Ee=R_9CpMgx-JmA@mail.gmail.com>
 <530CFC27.5050700@xenomai.org>
 <CAEbDrgnmM_dD3WX42PYawhkW8zTaYczzfozEe1EX7Z5HnERz3g@mail.gmail.com>
 <530D0205.9050406@xenomai.org>
 <CAEbDrgmwch94crHAcrbJDj9MxaiBNaYeLH2U9NtS0tuJKmdDDw@mail.gmail.com>
 <530D0BBD.6070704@xenomai.org>
 <CAK4EZFR_L+=-LtSVHkvZ36rPOA8ViVboB9M9rf4Yqk=crfBotw@mail.gmail.com>
 <CAEbDrgk=yrGq8KdpdN8e7RtO7qUpWTtwRXhrg0A0=KbDjqoDng@mail.gmail.com>
 <530D2C92.9010607@xenomai.org>
 <CAEbDrgkWZqSxjCUfjR3YCp=YOzh1r-=YC6Wyr-Jvk9d7JYEcmQ@mail.gmail.com>
 <530E6159.4050204@xenomai.org>
Date: Wed, 26 Feb 2014 22:37:43 +0000
Message-ID: <CAEbDrgmo==15Zar2X=yz=wBL3pJ4DOiqKy2xx43UPxuu6_5LhA@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Right,
here is updated trace:
http://pastebin.com/FW6i2Gds

there is unstall root call on line 39
followed by read_current_timer at line 88

if I understand this well read_current_timer fails with bad_irq?


On 26 February 2014 21:49, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/26/2014 08:59 PM, Gregory Dymarek wrote:
> > Gilles
> > here is the ipipe trace (see line 112)
> > http://pastebin.com/EcLn0MxJ
>
> There is not enough details on the trace, you should put it before the
> trace dumps, or increase the number of trace points. Because the only
> thing we see is the trace dump.
>
> >
> > that corresponds to
> > http://pastebin.com/vjLJVDGS
> >
> > I do not see any call to enable irq, but there are plenty calls for
> debug.
> >
> >
> > Could you also explain in a few words the previous patch please.
> > What was wrong with local_fiq_disable() defined as ipipe_stall_root() ?
>
> It was wrong because fiqs are not pipelined, so it does not make sense
> to use ipipe_stall_root/ipipe_unstall_root to disable and enable them.
>
> --
>                                                                 Gilles.
>
