Message-ID: <46C07AF2.60402@domain.hid>
Date: Mon, 13 Aug 2007 17:38:26 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
In-Reply-To: <46C0719B.1010102@domain.hid>
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
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
> Hi,
> 
> I seem to be getting major buffer overflow. Yet when I check the 
> messages with rtcanrecv with relative time stamp I get confirmation of 
> the fact that there are only two messages on the bus every ms and the 
> EASILY fit withing the 1ms task. I have tried to mask all errors but see 
> nothing. Why would i get about one billion messagebuffer overflow errors 
> to syslog? How can I make these mysterious messages visible?
> 
> Or is there a setting that i may have wrong such that the rtcan rev 
> function does not empty the ring buffer?
> 
> I hope there is something obvious I am doing wrong because this rtcan is 
> really giving me a headache.

When you have bound a RTCAN socket, it will receive messages and put 
them into the RX socket queue. If no task reads them via recv* function 
calls, the buffer will overflow sooner than later. Do you use a bound 
socket just for sending messages? Then you could avoid buffer overflows 
by defining an empty receive filter list as show here
http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/rtcansend.c#251.
Or use rt_dev_sendto() without binding the socket.

You can (or even should) suppress the overflow messages by disabling the 
kernel option CONFIG_XENO_DRIVERS_CAN_DEBUG.

Wolfgang.

