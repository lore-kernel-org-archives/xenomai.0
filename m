From: trem <tremyfr@domain.hid>
Date: Sat, 18 Aug 2007 00:43:13 +0200
Message-ID: <fa58a1$10o$1@domain.hid>
References: <ff1d78710708160504s3f44571fkf12f405c1e71b4f6@domain.hid>	<46C49070.8070807@domain.hid>
	<46C4BAB8.20103@domain.hid> <46C559A2.6090807@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <46C559A2.6090807@domain.hid>
Sender: news <news@domain.hid>
Subject: Re: [Xenomai-help] RTDM context_size question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> > trem wrote:
> >
>> >> Jan Kiszka wrote:
>> >>
>>> >>> Steven Kauffmann wrote:
>>> >>>
>>>> >>>> Hi
>>>> >>>>
>>>> >>>> When looking at the rtdm examples tut01-skeleton en
tut02-skeleton, I have a
>>>> >>>> question about the context_size in the rtdm_device struct.
>>>> >>>>
>>>> >>>> In tut01-skeleton-drv.c, the context_size = sizeof(buffer_t),
in the other
>>>> >>>> example context_size = 0. Both drivers uses the
>>>> >>>> rtdm_safe_copy_to_user/rtdm_safe_copy_from_user functions to
write/read data
>>>> >>>> from buffer_t(kernel space) to user_space. So I don't
understand why the
>>>> >>>> context_size in tut02 is different than in tut01. Or is the
context_size
>>>> >>>> only important if we open the driver several times from one or
more
>>>> >>>> user_space programs?
>>>> >>>>
>>> >>> The context size is important in case you want to attach some
data to
>>> >>> each opened instance of a device. Hmm, but this is something neither
>>> >>> tut01 nor tut02 deals with optimally. tut02 cannot use a
context-based
>>> >>> buffer, because it uses two device instances (opened by two
instances of
>>> >>> the user space program) to transfer the data. But tut01 could
use some
>>> >>> global buffer as well without loosing a feature.
>>> >>>
>>> >>> Philippe (trem), could you rework tut01 and make it use a global
buffer
>>> >>> instead? Then some tut03 would be nice to explain what per
context, per
>>> >>> device, and global data means. I've seen confusion about this fairly
>>> >>> often, so a dedicated tutorial would be great.
>>> >>>
>>> >>> Thanks,
>>> >>> Jan
>>> >>>
>>> >>>
>> >> Hi
>> >>
>> >> I've used per device buffer in tut01 and global buffer in tut02 to
show
>> >> the difference between them. But it seems that it's not very
clear. And
>> >> as the tut01 is just here as first rtdm example, it should be as
simple
>> >> as possible.
>> >>
>> >> So yes, using global buffer in tut01 and tut02 could be done, and
I will
>> >> add a tut03 to show the context.
>> >>
>> >> tutorial index :
>> >> - tut01 : first rtdm program
>> >> you can read and write in this device (tut01-skeleton-drv01). All data
>> >> are global, so I two program read it, they will read the same thing.
>> >>
>> >> - tut02 : show synchronization
>> >> you can only read in the device (tut02-skeleton-drv01) if a write has
>> >> been done before (by this program or another program). data and
>> >> semaphore are global.
>> >>
>> >> - tut03 : show device context
>> >> we can use tut01, and just put data to context. So a program can't
read
>> >> data written by another program. For example, P1 and P2 two programs.
>> >>
>> >> with tut01, the sequence is :
>> >> P1 : write "I'm P1" to tut01-skeleton-drv01
>> >> P2 : write "I'm P2" to tut01-skeleton-drv01
>> >> P1 : read  "I'm P2" from tut01-skeleton-drv01
>> >> P2 : read  "I'm P2" from tut01-skeleton-drv01
>> >>
>> >> with tut03, the sequence is :
>> >> P1 : write "I'm P1" to tut03-skeleton-drv01
>> >> P2 : write "I'm P2" to tut03-skeleton-drv01
>> >> P1 : read  "I'm P1" from tut03-skeleton-drv01
>> >> P2 : read  "I'm P2" from tut03-skeleton-drv01
>> >>
>> >>
>> >> I'm on the right way ?
>> >>
> >
> > Basically, yes. But I would even put all three associations into the
> > same example, may be letting the tut-device user select the data
> > destination via an IOCTL: local, device, global. That would should
> > clearly the association - and would also introduce a first, simple IOCTL
> > mechanism.
> >
> >
First, sorry, I don't understand the 3 choice : local, device, global.
global == 1 buffer for a driver
local   == 1 buffer each open
device == ?

Are you sure you want to do only one tut with all this choice ?
People seems to have some problem to understand a simple example,
and you want to regroup them ?

I propose :
tut01 => really simple example, global buffer
tut02 => synchronization
tut03 => context
tut04 => ioctl

You propose :
tut01 => really simple example (like helloworld)
tut02 => context + synchronizatio + ioctl

Both of them have pros and cons, which one you prefer ?


>> >> If yes, I'll do it ASAP.
>> >>
>> >> regards,
>> >> Philippe
>> >>
>> >>
> >
> > Thanks,
> > Jan
> >
> >



