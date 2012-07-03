Message-ID: <4FF34B1B.3080007@xenomai.org>
Date: Tue, 03 Jul 2012 21:42:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FED4948.8080906@basystemes.fr>
	<4FED4B42.6000808@wanadoo.fr>	<4FEDF65A.50401@grandegger.com>
	<1012208988.15650.1341343674156.JavaMail.www@wwinf1m30>
In-Reply-To: <1012208988.15650.1341343674156.JavaMail.www@wwinf1m30>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry BULTEL <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 07/03/2012 09:27 PM, Thierry BULTEL wrote:
> - patches inline ... Really ??? In the mail content ? But that makes
> huge mails. I can do so of course, but I do not see the point.

This allows people to comment your patch by simply replying to your
mail. And tools like git-apply and git-am are made to apply patches from
mails.

The biggest problem I see with your patch is this hunk:
@@ -41,21 +41,12 @@
        the second channel working, Xenomai's shared interrupt support
        must be enabled.

-config XENO_DRIVERS_CAN_SJA1000_PLX_PCI
+config XENO_DRIVERS_CAN_SJA1000_ADV_PCI
        depends on XENO_DRIVERS_CAN_SJA1000 && PCI
-       tristate "PLX90xx PCI-bridge based Cards"
+       tristate "ADVANTECH PCI 168x Card"
        help

-       This driver is for CAN interface cards based on
-       the PLX90xx PCI bridge.
-       Driver supports now:
-        - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
-        - Adlink PCI-7841/cPCI-7841 SE card
-        - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
-        - esd CAN-PCI/PMC/266
-        - esd CAN-PCIe/2000
-        - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
-        - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
+       This driver is for the Advantech 1680.

 config XENO_DRIVERS_CAN_SJA1000_EMS_PCI
        depends on XENO_DRIVERS_CAN_SJA1000 && PCI

You remove the config option for XENO_DRIVERS_SJA1000_PLX_PCI to add the
option for the driver you use. We naturally want to have the two options.

-- 
                                                                Gilles.

