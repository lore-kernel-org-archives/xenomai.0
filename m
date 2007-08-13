Message-ID: <46C07D9C.70907@domain.hid>
Date: Mon, 13 Aug 2007 17:49:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] [Fwd: Re:  rtcan bufferoverflow but no evidence]
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
To: Xenomai-help@domain.hid

Sent the previous one off-list. Sorry.

-------- Original Message --------
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
Date: Mon, 13 Aug 2007 17:49:07 +0200
From: Roland Tollenaar <rolandtollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
To: Wolfgang Grandegger <wg@domain.hid>
References: <46C0719B.1010102@domain.hid> <46C07AF2.60402@domain.hid>

Hi,

> When you have bound a RTCAN socket, it will receive messages and put 
> them into the RX socket queue. If no task reads them via recv* function 
This is the strange thing, I read them via rt_dev_recv. Sure as I am
here wrting this email every message gets read out. I send a sync, I get
a reply, the reply is read. I can see this very very clearly by
monitoring with rtcanrecv as well.

> calls, the buffer will overflow sooner than later. Do you use a bound 
> socket just for sending messages?
I send the sync, I recieve the position frame. Like clockwork. There
should be no overflow. I have checked all error masks, nothing.


> You can (or even should) suppress the overflow messages by disabling the 
> kernel option CONFIG_XENO_DRIVERS_CAN_DEBUG.
Well yes, but at the same time it would be interesting to know why the
buffer seems to be overflowing? I am very curious. :)

Thanks.

Regards,

Roland.





> 
> Wolfgang.
> 


