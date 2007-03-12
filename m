Message-ID: <45F53A89.4080409@domain.hid>
Date: Mon, 12 Mar 2007 11:33:29 +0000
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM and user space hardware drivers
References: <17648569.1173693688643.JavaMail.ngmail@domain.hid>
In-Reply-To: <17648569.1173693688643.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

Hi,

I think you need only a standard kernel driver that mmaps the memory 
area of your pci board.

Thus, from user space program , you mmap it and can do whatever you want 
in userspace world

Best Regards
steph



M. Koehrer wrote:
> Hi everybody,
> 
> the RTDM API is really very good as API for drivers. 
> I have a real time (Xenomai) application in user space that has to access PCI boards.
> The "classical" approach is now to use a kernel driver and to use RTDM as interface
> between the user space application an the kernel space driver.
> However, for performance issues, I prefer to write a pure user mode driver.
> As the memory of the PCI board can be accesses from user space (using /dev/mem) 
> I want to write a pure user space driver  as this seems to me more efficient (and easier to debug) than
> a kernel driver.
> Also, only one application is accessing the driver at a time, I can link the driver directly to my application.
> 
> My questions are now:
> 1. Is it possible to use the RTDM API also for pure user space drivers?
> 
> 2. Is there any experience concerning the performance of a user space driver versus a kernel space
> driver?
> In my use case, I have to write and read about 60 byte (each direction) of (block) data to/from the PCI I/O system.
> 
> Thanks for any ideas or hints on that!
> 
> Regards
> 
> Mathias
> 
> 


