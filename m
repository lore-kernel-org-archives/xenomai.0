MIME-Version: 1.0
In-Reply-To: <530F17EC.6020204@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
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
 <CAEbDrgmo==15Zar2X=yz=wBL3pJ4DOiqKy2xx43UPxuu6_5LhA@mail.gmail.com>
 <530F17EC.6020204@xenomai.org>
Date: Thu, 27 Feb 2014 18:43:13 +0000
Message-ID: <CAEbDrgnq46OJ6bi1FCQmC8JBWhSA6o=M9K=fg4x4hq3JpwcBjw@mail.gmail.com>
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

Here is the trace with 10000 points:
https://github.com/gregd72002/rpicopter/blob/master/tmp/frozen



On 27 February 2014 10:48, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/26/2014 11:37 PM, Gregory Dymarek wrote:
> > Right,
> > here is updated trace:
> > http://pastebin.com/FW6i2Gds
> >
> > there is unstall root call on line 39
> > followed by read_current_timer at line 88
> >
> > if I understand this well read_current_timer fails with bad_irq?
>
> I would say the driver interrupt handler does not acknowledge the
> interrupt correctly at device level, so that the interrupt triggers
> again, as soon as it is unmasked at interrupt controller level.
>
> Could you take a trace with say 10000 points, in order to confirm this?
>
> To add trace points, use
>
> echo 10000 > /proc/ipipe/trace/back_trace_points
>
> To save the trace to a file use:
>
> cat /proc/ipipe/trace/frozen > frozen.txt
>
> --
>                                                                 Gilles.
>
