From: Ulrich Schwab <schwab@domain.hid>
Subject: Re: [Xenomai-help] insmod: error inserting './xeno_posix.ko': -1
	Unknown symbol in module
Date: Thu, 8 Dec 2005 12:36:16 +0100
References: <002301c5fbde$7534e740$0200000a@domain.hid>
	<17304.3484.102658.597744@domain.hid>
In-Reply-To: <17304.3484.102658.597744@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512081236.16769.schwab@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Thursday 08 December 2005 11:40, Gilles Chanteperdrix wrote:
> Martijn Hazenberg (GOVA) wrote:
>  > (...)
>  > insmod: error inserting '/usr/realtime/modules/xeno_hal.ko': -1 No such
>  > device
>
> Heikki is right: your first problem is why insmoding xeno_hal fails.
>
> Maybe your machine has a local APIC, but it is disabled by BIOS. If this
> is your problem, you should try and add "lapic" to your kernel boot
> parameters. For more details, you should read the last two questions
> of the "TROUBLESHOOTING" file.
I had the same problem, but using the lapic bootparam did only solve this 
issue after it was specified as
	lapic=1
only adding 
	lapic
was not enough.
Philippe did mention the working option a few days ago. Thanks, by the way.

Even in the Linux Documentation file kernel_parameters.txt (2.6.13)
this paramter is not shown to have a value like this.

So long,
Ulrich Schwab
-- 
====================================================
  inmess GmbH
  Frankfurter Str. 74
  D - 64521 Gross-Gerau
  Phone: +49 6152 97790
  Fax  : +49 6152 977920
  mail : info@domain.hid
  web:   www.inmess.de
====================================================

