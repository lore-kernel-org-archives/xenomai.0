Message-ID: <46C0B834.6080105@domain.hid>
Date: Mon, 13 Aug 2007 21:59:48 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid> <46C07AF2.60402@domain.hid>
	<46C07D73.7070302@domain.hid> <46C080C8.10906@domain.hid>
	<46C0835E.8010105@domain.hid> <46C0B036.3030306@domain.hid>
	<46C0B1DF.6090509@domain.hid>
In-Reply-To: <46C0B1DF.6090509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid, xenomai-help <xenomai@xenomai.org>

Roland Tollenaar wrote:
> Hi Wolfgang,
> 
>>> See below. This does not look good. Does it mean that I am only 
>>> always reading out the last socket and the rest are having their 
>>> buffers pumped full? Should I be unbinding somehow?
>>
>> Don't know, check your code ;-).
> Thanks that is exactly what I did because I thought I was unbinding. 
> rt_dev_close () should do that for me correct? Its not. At least not 
> reliably. :(
> 
>>> 778518     1
>>
>> There is a default filter defined for all sockets. If you just want to 
>> receive error frames, there is no need to bind the socket, IIRC.
>>
> I am lost here. I don;t want to receive ANY error frames. My sensor is 
> working, I am getting the readings in rapicly and all these error frames 
> which I cannot make visible anyhow are just causing grievance. I'd feel 
> a lot happier if I knew where the rogue can messages were coming from 
> that are overflowing the buffer. Mind you, if the Buf overflow count in 
> /proc/rtcan/sockets is zero while the application is running (the latest 
> socket will always have that) then syslog still gets messages saying 
> buffer overflow. I'm doing something wrong and I don;t just want to turn 
> off the messaging. If I can help it Id like to know what is wrong. Is 
> there any manner in which I can make visible ANY message error or not 
> that appears on the bus?
> 
> Is there a possibility that there is some loopback route which gets 
> messages intot he buffer which are NOT on the physical bus?

Yes, of course. You have enabled the TX loopback feature via kernel option:

config XENO_DRIVERS_CAN_TX_LOOPBACK
         depends on XENO_DRIVERS_CAN
         bool "Enable TX loopback to local sockets"
         default n
         help

         This options adds support for TX loopback to local sockets. 
Normally,
         messages sent to the CAN bus are not visible to sockets 
listening to
         the same local device. When this option is enabled, TX messages are
         looped back locally when the transmit has been done by default. 
This
         behaviour can be deactivated or reactivated with "setsockopt". 
Enable
         this option, if you want to have a "net-alike" behaviour.


 From your output:

root@domain.hid# cat /proc/rtcan/sockets
fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull 
TX_Lo
  7 rtcan2               1 0x00008      infinite      infinite 0     1

TX_Lo tell you that TX messages are loopback to local sockets.

Wolfgang.


