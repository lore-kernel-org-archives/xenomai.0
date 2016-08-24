MIME-Version: 1.0
In-Reply-To: <20160824211117.GE14309@csclub.uwaterloo.ca>
References: <78f5f51a-dce0-f7f3-bed3-e2c908a14276@ethz.ch>
 <20160824194934.GD14309@csclub.uwaterloo.ca>
 <9a164b1c-a1bf-ff3f-9142-e37ae2478066@ethz.ch>
 <20160824211117.GE14309@csclub.uwaterloo.ca>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Date: Wed, 24 Aug 2016 23:41:54 +0200
Message-ID: <CAPRPZsByP-HNfbKxBUp6Y0QfoHN8LZVKWe57ULZBvFOrYn9hsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] 16550A Baud Rate Limitation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

It could be useful for debugging to compare the contents of the UART
registers after configuration by the Linux vs RTDM driver ?

I believe there's a tool somewhere (ioport) to access the ports
directly. Get a 16550 datasheet to see what they mean. There are 8
registers, but you must set the bit 7 (DLAB) in register offset 3 to
read the baud rate divisor in reg offsets 0 and 1. Be sure to clear it
afterwards and have no activity on the serial line while doing this.


Jeroen.


2016-08-24 23:11 GMT+02:00 Lennart Sorensen <lsorense@csclub.uwaterloo.ca>:
> On Wed, Aug 24, 2016 at 10:06:20PM +0200, Asutosh Satapathy wrote:
>> Yes. The port works at 230400 in linux driver. I tested it using
>> Cutecom/minicom.
>>
>> I am changing the baud base by the command as follows:
>> sudo insmod ~/xen/linux-3.14.17/drivers/xenomai/serial/xeno_16550A.ko
>> io=0x3f8 irq=4 baud_base=230400
>
> And if all you change is that baud_base it works at 115200?
>
> You actually have a uart at the old ISA port numbers that supports high
> baud rates?  (I have seen this, but it isn't very common, so I figure
> I would ask in case you copied that from an example and your uart is
> actually at a different port).
>
> --
> Len Sorensen
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

