MIME-Version: 1.0
In-Reply-To: <530FAAE3.6080505@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
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
 <CAEbDrgnq46OJ6bi1FCQmC8JBWhSA6o=M9K=fg4x4hq3JpwcBjw@mail.gmail.com>
 <530F9CA2.2040601@xenomai.org>
 <CAEbDrgmLq08Xq5Cgt7oXX3koQDr+HVx_JS-7Nn_pC53rmTTV-g@mail.gmail.com>
 <530FAAE3.6080505@xenomai.org>
Date: Thu, 27 Feb 2014 22:54:00 +0000
Message-ID: <CAEbDrgnNE__3Tegh7Mm7hmuH1L0a+=RR+t3wS_YgZKu7q_+abA@mail.gmail.com>
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

right, i think i see it.

Up to and including kernel version 3.6 there was no handle_irq abstraction:
https://github.com/raspberrypi/linux/blob/rpi-3.2.27/arch/arm/mach-bcm2708/bcm2708.c

handle_irq was introduced in 3.8 and as such this is not getting patched.


On 27 February 2014 21:15, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/27/2014 09:33 PM, Gregory Dymarek wrote:
> > Not sure if I understand this. This is the first call to
> __report_bad_irq (
> >
> https://github.com/raspberrypi/linux/blob/rpi-3.8.y/kernel/irq/spurious.c)
> >
> > I added the trace on line 192.
> >
> > AFAIK this is the first call to the function. the trace freeze i added is
> > not conditional.
>
> I am looking at the "post" patch for Raspberry, and I do not see that
> it touches drivers/irqchip/irq-bcm2835.c
>
> Here the calls to handle_IRQ are not replaced with ipipe calls, this
> can not work.
>
> See:
>
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Interrupt_controller
>
> --
>                                                                 Gilles.
>
