Message-ID: <4FED4B42.6000808@wanadoo.fr>
Date: Fri, 29 Jun 2012 08:29:22 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <4FED4948.8080906@basystemes.fr>
In-Reply-To: <4FED4948.8080906@basystemes.fr>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have ported the adv_pci driver from =

http://git.toiit.sgu.ru/people/samarkinpa/public/?p=3Dadv_pci.git;a=3Dtree;=
h=3Da57c5d22415f8dbf92eeae0e05ff482839d8c2f3;hb=3Da57c5d22415f8dbf92eeae0e0=
5ff482839d8c2f3

I has been quite intensively been tested and cycled for several days in =

real industrial conditions.

The patch for 2.6.38-8 is attached to this mail.

Is it of interest and does is have a chance to be integrated in the =

xenomai mainline ?

Thanks
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sja1000_adv_pci_driver.patch
Type: text/x-patch
Size: 13390 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120629/e7b587e=
d/attachment.bin>
