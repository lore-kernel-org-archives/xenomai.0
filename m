Message-ID: <4C0F327F.8020900@domain.hid>
Date: Wed, 09 Jun 2010 08:19:43 +0200
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

I just ran this test on my PC and got similar results. The figures are
in *nanoseconds*. And yes, stupid me, 0.7 *milli-seconds* is a resonable
number for 115200: (2 * 4 bytes * 10 bits-per-byte) / 115200 bits/sec.

Wolfgang.

