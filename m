Message-ID: <4BF3953D.8070108@domain.hid>
Date: Wed, 19 May 2010 09:37:33 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1274245032-10610-1-git-send-email-P.B.Cheblakov@domain.hid>
In-Reply-To: <1274245032-10610-1-git-send-email-P.B.Cheblakov@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH V2] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Pavel Cheblakov <P.B.Cheblakov@domain.hid>
Cc: xenomai@xenomai.org

On 05/19/2010 06:57 AM, Pavel Cheblakov wrote:
> This is a general driver for cards based on PLX90xx PCI-bridges.
> It supports following cards:
>  - Adlink PCI-7841/cPCI-7841 card (http://www.adlinktech.com/)
>  - Adlink PCI-7841/cPCI-7841 SE card
>  - esd CAN-PCI/CPCI/PCI104/200 (http://www.esd.eu/)
>  - esd CAN-PCI/PMC/266
>  - esd CAN-PCIe/2000
>  - Marathon CAN-bus-PCI card (http://www.marathon.ru/)
>  - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
> 
> This driver has been ported from socketcan of mainline Linux kernel 2.6.34.
> Support of esd cards has been added by Matthias Fuchs in linux-next
> 
> 'rtcan_esd_pci' driver marked as deprecated.
> 
> Signed-off-by: Pavel Cheblakov <P.B.Cheblakov@domain.hid>
> Acked-by: Wolfgang Grandegger <wg@domain.hid>

Looks good now, thanks.

Wolfgang.

