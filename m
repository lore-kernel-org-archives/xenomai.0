Message-ID: <4C0CA863.9000304@domain.hid>
Date: Mon, 07 Jun 2010 10:05:55 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTil10j3uoPdVXmgE8kIPrMQRSAArQB5gz3swDruD@mail.gmail.com>
In-Reply-To: <AANLkTil10j3uoPdVXmgE8kIPrMQRSAArQB5gz3swDruD@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM rs232 strange behavior
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

On 06/05/2010 04:22 AM, Everett Wang wrote:
> Hi All,
> 
> I am playing around with xenomai and RTDM serial driver on a
> 1.7Ghz Pentium-M machine running xenomai 2.5.3. The example cross-link
> produced this result:
> 
> main : starting read-task
>  Nr |   write->irq    |    irq->read    |   write->read   |
> -----------------------------------------------------------
>   0 |          118948 |          614135 |          733083
>   1 |          115598 |          614281 |          729879
>   2 |          108917 |          614982 |          723899
>   3 |          106101 |          616560 |          722661
>   4 |          113457 |          614971 |          728428
>   5 |          110358 |          614265 |          724623
>   6 |          106499 |          614406 |          720905
>   7 |          110363 |          615015 |          725378
>   8 |          115478 |          614840 |          730318
>   9 |          110766 |          614168 |          724934
>  10 |          108986 |          616435 |          725421
>  11 |          108030 |          614299 |          722329
>  12 |          109369 |          614420 |          723789
>  13 |          105862 |          614456 |          720318
>  14 |          110428 |          616301 |          726729
> 
> Is 0.7 millisecond between write and read a reasonable number?

No, at least not for a baudrate of 115200. Does the "latency" test
report reasonable latency figures? And how did you load xeno_16550A.ko?

> I then changed the example a little: I let write task only
> write 4 characters and instruct read task to read 10 characters.
> I thought the read task will tell me when that only 4 characters
> is read. But to my surprise, it waited until write-task
> filled all 10 characters before finish reading. How can I
> change the code to just do the read to whatever charaters
> are avaliable without waiting to fill all the characters I
> asked for? I will use this capability to read a GPS. It's
> output length is unknow before reading.

Setting the config rx timeout to RTSER_TIMEOUT_NONE should help.

> Most GPS can also produce a precisive time pulse when data
> is ready. Is it be possible to connect this to a pin in rs232 (CTS, for example)
> to triger a IRQ so the data can be read in a timely manner?

That depends on the signals, I can imagine. I'm not a hardware guy but I
know that many GPS receiver come with a read-to-use RS232 interface.

Wolfgang.

