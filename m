From: "Peter Hua" <Phua@domain.hid>
References: <007901cbb667$db66b860$92342920$@innovative-dsp.com>	<4D347656.1050609@domain.hid>	<008e01cbb675$a916be60$fb443b20$@innovative-dsp.com>
	<1295290329.1857.59.camel@domain.hid>
In-Reply-To: <1295290329.1857.59.camel@domain.hid>
Date: Mon, 17 Jan 2011 14:10:38 -0800
Message-ID: <00d001cbb693$5f101b90$1d3052b0$@innovative-dsp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai-help] Xenomai mmap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>, 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, pwfhua@domain.hid

Let me apologies for my clumsiness, as I am new to all this.  I will be more
careful.

Peter


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On
Behalf Of Philippe Gerum
Sent: Monday, January 17, 2011 10:52 AM
To: Peter Hua
Cc: xenomai@xenomai.org; pwfhua@domain.hid
Subject: Re: [Xenomai-help] Xenomai mmap

On Mon, 2011-01-17 at 10:37 -0800, Peter Hua wrote:
> Platform: X86, 64-bit
> 
> Thanks for the API linke.  I have recoded to not use "rtdm_iomap_to_user"
and used the mmap call.  However, I am not able to open the driver with the
open() call.  It returned -1.   Any suggestion?  Example?
> 

This is getting silly. Please make sure to use anything you may have been
given to do your work, by order of usefulness:

- brain,
- documentation,
- computer.

You obviously have a computer, so, if you are missing any other item from
this list, please make sure to get the complete package before posting anew.

Also, please stop posting whatever code you happen to perpetrate to this
list: it gives anyone with a functional brain a huge feeling of seasickness.

Final note: this list is not a cheap helpdesk to get his work done for free.
Everyone has to do some efforts to keep things rolling.

Thanks (I'm trying hard to mean it).

> Thanks,
> Peter Hua
> Innovative Integration
> 805-578-4275
> 
> 
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Monday, January 17, 2011 9:03 AM
> To: Peter Hua
> Cc: xenomai@xenomai.org; pwfhua@domain.hid
> Subject: Re: [Xenomai-help] Xenomai mmap
> 
> Peter Hua wrote:
> > Is there any example code to map PCI registers into user space?  I am
having
> > problem getting functions rtdm_iomap_to_user and mmap to compile.   My
code
> > is attached.  
> 
> What platform? What error message do you get?
> 

--
Philippe.



_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help


