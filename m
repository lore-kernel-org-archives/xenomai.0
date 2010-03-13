Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B9AE065.3030102@domain.hid>
Date: Sat, 13 Mar 2010 01:46:29 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B990EF1.1000400@domain.hid> <4B9985C3.4060100@domain.hid>
	<4B9A6633.9030806@domain.hid>
In-Reply-To: <4B9A6633.9030806@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Experimenting with Analogy. Bugs
 found?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Hi,

Daniele Nicolodi wrote:
> Daniele Nicolodi wrote:
>>> 2. Looks like it is not possible to setup an endless acquisition. If I
>>> set .stop_src = TRIG_NONE and .stop_arg = 0, the command submission goes
>>> fine, but I obtain an ENOENT error at the first a4l_sys_read(). I have
>>> no idea on where to look to track down this issue.
> 
> The attached patch (against Alex git three) fixes the problem, in the
> case of analog input. I haven't test the same condition for analog output.
> 
Sorry, I answered your former mail instead of this one. I will integrate
your patch soon. I will check analog output.

Many thanks for digging into this.

> Cheers,
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

Alexis.

