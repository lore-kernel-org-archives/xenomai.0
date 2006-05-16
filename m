From: Marco Jackel <ich@domain.hid>
Date: Tue, 16 May 2006 20:56:15 +0200
Message-ID: <e4d78d$pc4$1@domain.hid>
References: <e4c3bv$829$1@domain.hid> <44699D5A.9070806@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <44699D5A.9070806@domain.hid>
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: [RTDM] best strategy for periodic reading
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

Hi Jan,

Jan Kiszka wrote:
  > What is the usage model of your driver? Is there an application thread
> associated to each frequency or even each channel? Or is there a single
> reader which gets woken up once some channel finishes the conversion? Or
> does the application requests a bulk of samples from multiple channels?

I want to implement this as a single reader. The only thing I've to do 
is to log the data from the different channels to one or more file(s).

> Depending on that usage model, an alternative way to implement your
> driver is to let the application generate the conversion clock, i.e. let
> it poll the data (maybe just blocking on the conversion completion).

I'll try that.

> On the other hand, if the acquisition job currently performed in
> rtdm_tasks is rather light-weight,

I think so, only a few small macros with bit-operations that set/read 
the register from the ISA-card

> maybe timers would help you to reduce
> the overhead involved in multiple threads reading from the same device
> (including locking etc.). Unfortunately, an RTDM interface for direct
> timer usage has not yet been fully specified. Some preliminary patch
> hangs around on my box for quite a few months now. Do you see advantages
> for your scenario when using timers, i.e. executing the periodic jobs
> directly in the context of the timer IRQ handler? If yes, I could try to
> accelerate the finalisation of this patch.

There are some sensors on the serial device, too, and the event-driven 
programming is a very elegant way (using xeno_16550A with 
"rt_dev_ioctl(imu_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );". So I 
thought it would be nice to implement the driver for the ISA-card in a 
similar way.

Thanks
Maggo


