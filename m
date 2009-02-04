MIME-Version: 1.0
Sender: salvatore.deastis@domain.hid
Date: Wed, 4 Feb 2009 11:59:22 +0100
Message-ID: <5eecf1c50902040259q487b1bf1udf0bf2eda2d9a2ae@domain.hid>
From: Salvatore De Astis <dev.rinux@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] xeno_16550A
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

Hi at all,
I'm implementing a driver for a UART 16550 compatible PMC device. I've
a VME crate with x86 CPU and a Tundra UniverseII PCI2VME bridge. I
wrote a rtdm driver for that bridge porting the  Andreas Ehmanns's
linux driver http://universe2.sourceforge.net/. Now I want to handle
UART 16550 compatible PMC devices plugged on a VME carrierboard. I
prefer to use the module xeno_16550A but how can I do this?
Thanks!

-- 
Salvatore De Astis
TXT e-solutions spa
www.txtgroup.com

