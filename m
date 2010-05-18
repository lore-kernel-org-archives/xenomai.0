From: Sebastian Smolorz <smolorz@domain.hid>
Date: Tue, 18 May 2010 14:29:59 +0200
References: <1274182125-12750-1-git-send-email-P.B.Cheblakov@domain.hid>
	<201005181342.57816.smolorz@domain.hid>
	<4BF27FB4.6090301@domain.hid>
In-Reply-To: <4BF27FB4.6090301@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005181429.59169.smolorz@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Hi Wolfgang,

Wolfgang Grandegger wrote:
> On 05/18/2010 01:42 PM, Sebastian Smolorz wrote:
> > Pavel Cheblakov wrote:
> >> This is a general driver for cards based on PLX90xx PCI-bridges.
> >> It supports following cards:
> >>  - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
> >>  - Adlink PCI-7841/cPCI-7841 SE card
> >>  - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
> >>  - esd CAN-PCI/PMC/266
> >>  - esd CAN-PCIe/2000
> >>  - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
> >>  - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
> >
> > The esd cards mentioned above are supported by the RTCAN driver
> > xeno_can_esd_pci. Why do you propose a new driver instead of extending
> > the existing one?
> 
> For Socket-CAN, this driver is supposed to support all PLX PCI based
> boards including the esd CAN PCI cards and also the IXXAT PCI board (not
> yet done, though). The RTCAN driver xeno_can_esd_pci is a *dedicated*
> driver for that card without generic support for the PLX PCI chips.
> Extending it makes little sense. The question is if we want to drop
> xeno_can_esd_pci and xeno_can_ixxat_pci.

With extending the esd_pci driver I meant to take this driver as a basis to 
add support for more cards. Of course this would mean to rename the driver 
in order to reflect that. I'm not against a unification of esd_pci and 
ixxat_pci but it's unneccessary work to write a new RTCAN driver if there 
exists another one which is tried and tested in the field. So my question 
was why  Pavel did not take the esd_pci driver as the starting position.

So talking about potential issues in Pavel's code (e.g. the function 
plx_pci_check_sja1000()) could be unnecessary if he derived the new driver 
from esd_pci .

-- 
Sebastian

