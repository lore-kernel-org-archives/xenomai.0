From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 6 Nov 2007 00:32:36 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200710310117.44938.berlemont.hauw@domain.hid>
	<200710311036.01469.lepalom@domain.hid>
In-Reply-To: <200710311036.01469.lepalom@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711060032.36444.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
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

Hi

> And after, the jr3 driver, but I got with dmesg:
>
> jr3pci: module license 'unspecified' taints kernel.
> jr3pci: no version for "comedi_add_drv" found: kernel tainted.
> jr3pci: Unknown symbol device_unregister
> jr3pci: Unknown symbol device_register
>
>
> so, I cannot load the driver. What I'm doing grong?

Oops. My fault. Fixed in subversion.

Please update.

Alexis.


