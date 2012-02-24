Message-ID: <4F479E23.3010905@domain.hid>
Date: Fri, 24 Feb 2012 15:26:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F461E69.3080602@domain.hid>
In-Reply-To: <4F461E69.3080602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Will ipipe-serial-debug work with a serial port
 on a	PCI board ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thierry Bultel <thierry.bultel@domain.hid>
Cc: xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@domain.hid>

On 02/23/2012 12:09 PM, Thierry Bultel wrote:
> Hello,
>
> I am working on a board that does not have genuine UARTs on it (only
> soldered USBtoSerial converters) :-(
> But it has a free minPci slot, and I was wondering if it would be
> possible to perform serial debug
> with serial ports on a PCI board.

In theory, the implementation of __ipipe_serial_debug() for the 8250 
should tap at a high level enough in the TTY infrastructure, to emit 
characters via the PCI serial core properly. In practice, ... I never tried.

>
> Thanks for your advice
> Regards,
> Thierry Bultel
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

