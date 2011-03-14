Message-ID: <4D7E5F7D.9060508@domain.hid>
Date: Mon, 14 Mar 2011 19:33:33 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] NI analog card shows wrong IRQ number after reboot
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Which is due to the fact that pci_enable_device (mite.c) is called at mite_setup
instead of mite_init. The bad thing with this, is that interrupt conflicts can
only be found AFTER the driver has been started with analogy_config, which is
often too late (since interrupt conflicts will bring down the machine).

Would it be a good idea to pci_enable_device in mite_init as well, or will that
break something else?

Regards

Anders Blomdell


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

