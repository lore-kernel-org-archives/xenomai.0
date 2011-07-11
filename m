Message-ID: <4E1ADDDF.4050401@domain.hid>
Date: Mon, 11 Jul 2011 13:26:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <SNT127-W46C0FFB2ED99A4AA6D15DAD1410@domain.hid>
In-Reply-To: <SNT127-W46C0FFB2ED99A4AA6D15DAD1410@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Newbee questions - concerning the native API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tony Vinto <tonyvintox@domain.hid>
Cc: xenomai@xenomai.org

On 07/07/2011 04:11 PM, Tony Vinto wrote:
> 
> Hi,
> 
> I apologize if I am asking questions that have been handled many
> times before but at mu skill level searching the list of archives and
> for a similar topic seems overly daunting to me.  ( Is there an
> application that can globally search the archives without me having
> to manually download each and individually un-gzipping them and then
> searching for keywords in each? )

You can use your favorite search engine, adding site:xenomai@xenomai.org

We provide a simplified way to do this at this URL. Correction, this
functionality disappeared. It must have during a mediawiki upgrade. I
will look into this.


> 
> I am six months into Linux programming and only a few days into
> Xenomai... ( I have read the API document once, and am in the second
> reading of the Native API Tour revC.)
> 
> Anyway my questions...
> 
> For sake of discussion these refer to the example code
> "trivial-periodic.c", but are really general questions.
> 
> 
> 1) Is the proceedure "demo(void *arg)" the real time part and the
> "main()" section standard linux?  That is, is "demo()" preempt-able
> or will it run forever without preemption?  if the latter, I presume
> that it is the coders responsibility to build in a means for the
> procedure to return to sleep when it has completed it's job.   ( as
> in the example, the "rt_task_wait_period(NULL)" call. )

Yes. It is also the responsibility of the coder to only use service that
will not cause a switch to secondary mode.

> 
> 
> 2) My application will run in user space and will access a device on
> an SPI bus.  I will be using a user mode SPI driver and making IOCTL
> calls to exchange data with my device. If I do all of my work in a
> real time proceedure ( like demo() in the example code ) will the
> IOCTL calls also be in the real time domain?  That is are they
> protected from preemption?

It depends how the ioctl are implemented, they will remain in primary
mode only if you only call primary-mode only services. But you can use
rt_task_set_mode to set the T_WARNSW bit, and receive a signal when this
thread switches to secondary mode.

> 
> 
> 3) The API tour says "message pipes" are for exchange of data between
> RT user mode and regular user mode. Intertasksynchronous message
> passing, Message queues, and Memory heaps are for kernel mode to user
> mode communication... or for RT user mode to RT user mode
> communication.
> 
> Am I "over reading" this?  ...or can I use any of these techniques
> for RT-User mode to regular user mode data exchange?

If you use RT to RT services, they will require the consumer thread
(assuming the producer thread is the only always in primary mode), to go
back and forth between primary and secondary mode. So, they will require
this thread to be able to switch to primary mode, that means that it
must be a xenomai thread, not a regular linux thread. Message pipes do
not have such a requirement.

-- 
                                                                Gilles.

