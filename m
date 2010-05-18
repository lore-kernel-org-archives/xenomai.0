From: Sebastian Smolorz <smolorz@domain.hid>
Date: Tue, 18 May 2010 13:42:57 +0200
References: <1274182125-12750-1-git-send-email-P.B.Cheblakov@domain.hid>
In-Reply-To: <1274182125-12750-1-git-send-email-P.B.Cheblakov@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005181342.57816.smolorz@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Pavel Cheblakov wrote:
> This is a general driver for cards based on PLX90xx PCI-bridges.
> It supports following cards:
>  - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
>  - Adlink PCI-7841/cPCI-7841 SE card
>  - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
>  - esd CAN-PCI/PMC/266
>  - esd CAN-PCIe/2000
>  - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
>  - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)

The esd cards mentioned above are supported by the RTCAN driver 
xeno_can_esd_pci. Why do you propose a new driver instead of extending the 
existing one?

-- 
Sebastian

