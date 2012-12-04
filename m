Message-ID: <50BDF922.9030805@grandegger.com>
Date: Tue, 04 Dec 2012 14:22:42 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CADy-PFjUiqnyaP5_1T934OLZQPU2NvNZnZj1uEG3MJvzKhgALQ@mail.gmail.com>
	<5069E424.9090500@grandegger.com>
	<CADy-PFjCScUGXgUebJj9a6arhZ6mRCnJPuwE3kHT=XcjkY0SpA@mail.gmail.com>
	<CADy-PFjg9NuOLte1CzoMFs3u+_cPUXE5xu7fzfDOug-qz0sQbg@mail.gmail.com>
	<50B4EF81.50307@grandegger.com>
	<CADy-PFjLCRbPc8MuYYsqEoEPXOuWNurzoG6nKaZFF_2+hQUoEw@mail.gmail.com>
	<50B6619A.10300@grandegger.com>
	<CADy-PFjz_CeJ7-RC8xfr5PLrMcKH6sFTJP56z4ULKL8sS_q-VA@mail.gmail.com>
	<CADy-PFgMDBt693UF0QbUnAAYZgGXG+H+7RdZc0G1fpeYLv_0oA@mail.gmail.com>
In-Reply-To: <CADy-PFgMDBt693UF0QbUnAAYZgGXG+H+7RdZc0G1fpeYLv_0oA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM and PEAK PCIe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jonathan Bohren <jonathan.bohren@gmail.com>
Cc: xenomai@xenomai.org

On 12/03/2012 04:43 PM, Jonathan Bohren wrote:
> Ok, here's the PEAK CANBus PCIE patch with all the necessary metadata:
> thanks!
> -j
> 
>>From d97ee63e108c3f6eff26368af0df3ba1d1050692 Mon Sep 17 00:00:00 2001
> From: Jonathan Bohren <jbo@jhu.edu>
> Date: Tue, 27 Nov 2012 09:13:11 -0500
> Subject: [PATCH] Adding device ID for PEAK PCIe card IPEH-003027

Please add an empty line between the subject and the commit message.

> Signed-off-by: Jonathan Bohren <jbo@jhu.edu>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  #define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory

Hm, where does that line come from. Maybe the result of the missing line
above.

>  ksrc/drivers/can/sja1000/rtcan_peak_pci.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
> b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
> index 53c8fef..b5ad226 100644
> --- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
> +++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
> @@ -71,13 +71,15 @@ struct rtcan_peak_pci
>  #define PITA_MISC        0x1C        // miscellanoes register
>  #define PEAK_PCI_VENDOR_ID   0x001C  // the PCI device and vendor IDs
> -#define PEAK_PCI_DEVICE_ID   0x0001
> +#define PEAK_PCI_DEVICE_ID   0x0001  // Device ID for PCI and older PCIe
> cards
> +#define PEAK_PCIE_DEVICE_ID  0x0003  // Device ID for newer PCIe
> cards (IPEH-003027)
>  #define PCI_PORT_SIZE        0x0400  // size of a channel io-memory
> 
>  static struct pci_device_id peak_pci_tbl[] = {
>   {PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> + {PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> 0},

Unfortunately, you mail client has wrapped lines. This patch will not
apply. To avoid such problems I recommend to post the patch with  "git
send-email".

Thanks,

Wolfgang.


