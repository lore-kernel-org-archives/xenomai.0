Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Mon, 25 May 2009 23:28:57 +0200
In-Reply-To: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	(Cristian Axenie's message of "Mon\,
	25 May 2009 14\:46\:04 +0300")
Message-ID: <878wkkzxba.fsf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Cristian Axenie <cristian.axenie@domain.hid> writes:

> Hello!
> I've took a snapshot of the git tree from Alexis's when he added the PCIMIO drivers. I've built my kernel and created an own usbflash filesystem. Now what should I do to
> begin testing the drivers ?
> The drivers are now kernel built-in and there is no comedi_config anymore.
That is not correct; even if the comedi driver is statically linked into
the kernel does not mean the comedi layer automatically linked it to a
specific device. Have a look at the proc file /proc/comedi/devices, you
will see the devices are initialized unattached in any case.

Nonetheless, you should have had a message, somewhere, telling you such
thing. I will fix that as soon as possible.

Regards.

Alexis.

