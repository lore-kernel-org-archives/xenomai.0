Message-ID: <4B4B6DC6.3020007@domain.hid>
Date: Mon, 11 Jan 2010 19:28:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000101ca92eb$0146fdc0$03d4f940$@kalatchev@domain.hid>
In-Reply-To: <000101ca92eb$0146fdc0$03d4f940$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems with
	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ivan Kalatchev <ivan.kalatchev@domain.hid>
Cc: Xenomai-help@domain.hid

Ivan Kalatchev wrote:
> Hi,
> 
>  
> 
> I was trying to upgrade my application running on Viper (2.6.16.28 kernel
> with xenomai 2.3.1)  to 
> 
> kernel 2.6.30.10 with xenomai 2.4.10 and ran into couple of problems.
> 
>  
> 
> 1. My application uses real-time hook to CPLD interrupt, which is chained
> interrupt.
> 
>    Xenomai 2.4.10 for some reason assigns general purpose interrupt handler
> to I-pipe  acknowledgment handler :
> 
>  
> 
> in kernel/irq/chip.c:

Looks like you hit the send button without finishing your message ?

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

