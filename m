Message-ID: <45E6C642.80801@domain.hid>
Date: Thu, 01 Mar 2007 13:25:38 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN rt_dev_recvfrom
References: <bc4264770702281208u7d7ee013qa5be819a5856d4ea@domain.hid>
	<45E5ED29.8070505@domain.hid> <45E6B77A.5030600@domain.hid>
	<45E6B9D7.2000000@domain.hid> <45E6C2CA.5000404@domain.hid>
In-Reply-To: <45E6C2CA.5000404@domain.hid>
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
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
> Hi,
> 
>>> Where can I find the buffer size option in the kernel config menu? 
>>> What is the default size?
>>
>> On the first menu of the RT-Socket-CAN configuration options:
>>
>> config XENO_DRIVERS_CAN_RXBUF_SIZE
>>         depends on XENO_DRIVERS_CAN
>>         int "Size of receive ring buffers (must be 2^N)"
>>         default 1024
>>
>> Note that the messages are stored in "packed" format.
> 
> Does this mean that the buffer will store 1024 can_frame's ?

The size is usually in bytes. And as the messages are packed, the FIFO 
can hold from 1024/5 to 1024/13 messages (without time-stamp).

> If yes (or even if no) when rt_dev_recv is called, does it place the 
> last recieved message (youngest message) or the oldest (behave like a 
> FIFO) into *Buf?

It is a FIFO.

Wolfgang.


