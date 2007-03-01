Message-ID: <45E6B77A.5030600@domain.hid>
Date: Thu, 01 Mar 2007 12:22:34 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN rt_dev_recvfrom
References: <bc4264770702281208u7d7ee013qa5be819a5856d4ea@domain.hid>
	<45E5ED29.8070505@domain.hid>
In-Reply-To: <45E5ED29.8070505@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>, Xenomai-help@domain.hid

Hi Wolfgang,

>> Can this be confirmed or is rt_dev_recvfrom() behaving incorrectly in 
>> my case?
> 
> rt_dev_recvfrom() reads message frames (one at a time) from an internal 
> socket buffer (there is actually a kernel configuration option to 
> configure the size). If no messages are available, it will block by 
> default, but it can also be used in non-blocking mode by using the flag 
> MSG_DONTWAIT. It seems, that your application is trying to read messages 
> periodically in polling mode. Either you do reading and buffering in 
> your own thread as you suggested above or you use rt_dev_recvfrom() in 
> non-blocking mode.

Thanks for this. I have not tried it yet but I was looking for that flag 
in the hope that something like this would exist. I thought I had seen 
something like it but when I tried to locate it yesterday I failed. 
Don;t worry it is there, I just checked. Sorry.

Where can I find the buffer size option in the kernel config menu? What 
is the default size?

Thanks again.

Roland

> 
> Wolfgang.
> 
> 

