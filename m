Message-ID: <46C0BD19.5040806@domain.hid>
Date: Mon, 13 Aug 2007 22:20:41 +0200
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid> <46C07AF2.60402@domain.hid>
	<46C07D73.7070302@domain.hid> <46C080C8.10906@domain.hid>
	<46C0835E.8010105@domain.hid> <46C0B036.3030306@domain.hid>
	<46C0B1DF.6090509@domain.hid> <46C0B834.6080105@domain.hid>
In-Reply-To: <46C0B834.6080105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Hi,
>> Is there a possibility that there is some loopback route which gets 
>> messages intot he buffer which are NOT on the physical bus?
> 
> Yes, of course. You have enabled the TX loopback feature via kernel option:
> 
> config XENO_DRIVERS_CAN_TX_LOOPBACK
>         depends on XENO_DRIVERS_CAN
>         bool "Enable TX loopback to local sockets"
>         default n
>         help
> 
>         This options adds support for TX loopback to local sockets. 
> Normally,
>         messages sent to the CAN bus are not visible to sockets 
> listening to
>         the same local device. When this option is enabled, TX messages are
>         looped back locally when the transmit has been done by default. 
> This
>         behaviour can be deactivated or reactivated with "setsockopt". 
I'll have a look. But I understnad you correctly that even if I have 
activated the loopback behaviour in the kernel I can deactivate at 
runtime with setsockopt?

I still don;t see why this would generate overflows in the case when i 
only have one socket active? For the case that there are still lingering 
sockets which have not been closed it is obvious.


> TX_Lo tell you that TX messages are loopback to local sockets.
I'll turn this off in the morning if i can figure out how to with 
setsockopt.

Thanks a-plenty!

Roland


> 
> Wolfgang.
> 
> 

