Message-ID: <4F7555F7.6010102@domain.hid>
Date: Fri, 30 Mar 2012 08:43:03 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
In-Reply-To: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Minh GIANG <giang.hminh@domain.hid>
Cc: Xenomai-help@domain.hid

On 03/29/2012 05:26 PM, Minh GIANG wrote:
> i want to revive the topic over the problem RTSER_RTIOC_WAIT_EVENT
> while compiling cross-link.c program. I cann't resolve my problem
> after doing some solution given by the others
> 
> Loading module:
> 
> insmod ./xeno_16550A.ko io=0x3f8,0x2f8 irq=4,3 tx_fifo=10,20

Hm, is a FIFO size of 20 supported by the hardware? For a first try I
would drop "tx_fifo=10,20" (using the default of 16 for both uarts).

> start_index=0 (i have two serial ports on my pc)
> 
> running crosslink test:
> 
> main : write-file opened
> main : write-config written
> main : read-file opened
> main : read-config written
> main : write-task created
> main : read-task created
> main : starting write-task
> main : starting read-task
>  Nr |   write->irq    |    irq->read    |   write->read   |
> -----------------------------------------------------------
> read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
> read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
> 
> ...
> 
> 
> 
> running test:
> 
> cat /proc/xenomai/irq
> 
> IRQ         CPU0
>   3:        1089         rtser1
>   4:        5155         rtser0

You get interrupts, at least, but not the same amount, strange. What
cross-link command options do you use?

Wolfgang.

