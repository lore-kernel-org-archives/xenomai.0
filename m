From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Mon, 4 Jul 2011 16:07:07 -0300
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201107041607.08779.carlosnov@domain.hid>
Subject: [Xenomai-help] Can a module create multiple devices?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I am developing a driver for a pci acquisition board. The system can handle up 
to 16 boards and I would like to know how can i deal with this.

I tried to modify the tut-01-skeleton to create two devices, and would like to 
have each one with his own private area, so i created the device structures as 
device1 and device2, each one named rtdm_test_1 and rtdm_test2. The two 
devices show up in proc and they are accecible by the application.
But, it appears that the private area of each one are the same, I mean, if one 
write "KKK" to rtdm_test_1, then it can read "KKK" from rtdm_test_1 or 
rtdm_test_2. Is this normal behavior? There is another way to deal with 
multiple cards on the same system?

Thanks.

Carlos Novaes

