From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Thu, 26 Jun 2008 23:40:02 +0200
References: <1214406057.48625da9bf316@domain.hid>
	<200806260033.15193.berlemont.hauw@domain.hid>
	<Pine.LNX.4.64.0806260935460.11764@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0806260935460.11764@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806262340.03000.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Comedi over RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

Hi,

>
> Is your port xenomai-version independent yet?  Or maybe better, which
> version do you use to test things?

I work with the Xenomai trunk. I already checked with Xenomai 2.4. It should 
work with Xenomai 2.2 / 2.3 but I have not checked recently.

As Philippe told you, this compatibility point must not be an issue thanks to 
the integration of Comedi into the next Xenomai releases.

> > On that last point, I hope some external contributions will help the
> > Comedi4RTDM drivers set to grow as I have no acquisition cards and no way
> > to get some.
>
> What effort/steps does it take to port an existing driver into
> comedi-rtdm-dev?

I have to write a document to explain the little things to update. No deep 
change must be performed as the main concepts (subdevice, channel, range, 
instruction, command, etc.) are the same. However, some functions 
declarations evolved for (I hope) more simplicity. For example, I tried to 
provide a generic API to transfer data thanks to the asynchronous buffer (via 
command) with and without DMA (comedi_buf_put(), comedi_buf_get(), etc.).

To give you an idea: adapting the original Comedi driver "jr3_pci" took me 2-3 
evenings (it was not longer than 4-5 hours if I remember well). I was not 
familiar with this driver, I discovered it during the port.

More documentation should be available, I am working on it.

Best regards.

Alexis.



