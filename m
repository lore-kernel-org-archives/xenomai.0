Message-ID: <4D7E62B8.6090102@domain.hid>
Date: Mon, 14 Mar 2011 19:47:20 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4D7E5F7D.9060508@domain.hid>
In-Reply-To: <4D7E5F7D.9060508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] NI analog card shows wrong IRQ number after
	reboot
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

On 2011-03-14 19.33, Anders Blomdell wrote:
> Which is due to the fact that pci_enable_device (mite.c) is called at mite_setup
> instead of mite_init. The bad thing with this, is that interrupt conflicts can
> only be found AFTER the driver has been started with analogy_config, which is
> often too late (since interrupt conflicts will bring down the machine).
> 
> Would it be a good idea to pci_enable_device in mite_init as well, or will that
> break something else?

Many other kernel driver seems to call pci_enable_device from the probe
function, and this does give the card it's proper IRQ:

--- ksrc/drivers/analogy/national_instruments/mite.c.orig   2011-02-16
15:26:01.000000000 +0100
+++ ksrc/drivers/analogy/national_instruments/mite.c    2011-03-14
19:38:18.572674136 +0100
@@ -80,6 +80,7 @@
        }

        list_add(&mite->list, &mite_devices);
+       pci_enable_device(mite->pcidev);

        return 0;
 }

Regards

Anders


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

