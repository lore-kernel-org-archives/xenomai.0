Subject: Re: [PATCH 10/11] drivers/can: Convert to rtdm_available() and clean
 up
References: <cover.1568380740.git.jan.kiszka@siemens.com>
 <41d63af7445f7e775312cf281877e9d9148113bf.1568380740.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5ed1e849-83d9-1441-cf6d-7013b79f148a@siemens.com>
Date: Fri, 13 Sep 2019 15:35:55 +0200
MIME-Version: 1.0
In-Reply-To: <41d63af7445f7e775312cf281877e9d9148113bf.1568380740.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 13.09.19 15:18, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Properly fail if the core is not available. Doing this in the central
> CAN module avoids that we have to check in each and every driver.

Nah, this pattern does not work if the module is built in. But we can still 
catch many cases centrally by blocking the registration. Let me try again...

Jan

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   kernel/drivers/can/rtcan_module.c            | 7 ++-----
>   kernel/drivers/can/rtcan_virt.c              | 6 ------
>   kernel/drivers/can/sja1000/rtcan_adv_pci.c   | 6 +-----
>   kernel/drivers/can/sja1000/rtcan_ems_pci.c   | 6 +-----
>   kernel/drivers/can/sja1000/rtcan_esd_pci.c   | 6 +-----
>   kernel/drivers/can/sja1000/rtcan_isa.c       | 6 ------
>   kernel/drivers/can/sja1000/rtcan_ixxat_pci.c | 6 +-----
>   kernel/drivers/can/sja1000/rtcan_mem.c       | 6 ------
>   kernel/drivers/can/sja1000/rtcan_peak_dng.c  | 6 ------
>   kernel/drivers/can/sja1000/rtcan_peak_pci.c  | 6 +-----
>   kernel/drivers/can/sja1000/rtcan_plx_pci.c   | 6 +-----
>   kernel/drivers/can/sja1000/rtcan_sja1000.c   | 9 +++------
>   12 files changed, 11 insertions(+), 65 deletions(-)
> 
> diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
> index eca8acb8cf..fbc5c35e44 100644
> --- a/kernel/drivers/can/rtcan_module.c
> +++ b/kernel/drivers/can/rtcan_module.c
> @@ -415,8 +415,8 @@ int __init rtcan_init(void)
>   {
>       int err = 0;
>   
> -    if (!realtime_core_enabled())
> -	    return 0;
> +    if (!rtdm_available())
> +	return -ENOSYS;
>   
>       printk("RT-Socket-CAN %d.%d.%d - %s\n",
>   	   RTCAN_MAJOR_VER, RTCAN_MINOR_VER, RTCAN_BUGFIX_VER,
> @@ -437,9 +437,6 @@ int __init rtcan_init(void)
>   
>   void __exit rtcan_exit(void)
>   {
> -    if (!realtime_core_enabled())
> -	    return;
> -
>       rtcan_raw_proto_unregister();
>   #ifdef CONFIG_PROC_FS
>       rtcan_proc_unregister();
> diff --git a/kernel/drivers/can/rtcan_virt.c b/kernel/drivers/can/rtcan_virt.c
> index 698c31a24e..d8b4ee2c87 100644
> --- a/kernel/drivers/can/rtcan_virt.c
> +++ b/kernel/drivers/can/rtcan_virt.c
> @@ -157,9 +157,6 @@ static int __init rtcan_virt_init(void)
>   {
>   	int i, err = 0;
>   
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>   	for (i = 0; i < devices; i++) {
>   		err = rtcan_virt_init_one(i);
>   		if (err) {
> @@ -183,9 +180,6 @@ static void __exit rtcan_virt_exit(void)
>   	int i;
>   	struct rtcan_device *dev;
>   
> -	if (!realtime_core_enabled())
> -	    return;
> -
>   	for (i = 0; i < devices; i++) {
>   		dev = rtcan_virt_devs[i];
>   
> diff --git a/kernel/drivers/can/sja1000/rtcan_adv_pci.c b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
> index 32cf71ee1f..26f81ecda8 100644
> --- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
> +++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
> @@ -357,16 +357,12 @@ static struct pci_driver rtcan_adv_pci_driver = {
>   
>   static int __init rtcan_adv_pci_init(void)
>   {
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>   	return pci_register_driver(&rtcan_adv_pci_driver);
>   }
>   
>   static void __exit rtcan_adv_pci_exit(void)
>   {
> -	if (realtime_core_enabled())
> -		pci_unregister_driver(&rtcan_adv_pci_driver);
> +	pci_unregister_driver(&rtcan_adv_pci_driver);
>   }
>   
>   module_init(rtcan_adv_pci_init);
> diff --git a/kernel/drivers/can/sja1000/rtcan_ems_pci.c b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
> index e3c178f7bb..ca85b1d4e3 100644
> --- a/kernel/drivers/can/sja1000/rtcan_ems_pci.c
> +++ b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
> @@ -390,16 +390,12 @@ static struct pci_driver ems_pci_driver = {
>   
>   static int __init ems_pci_init(void)
>   {
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>   	return pci_register_driver(&ems_pci_driver);
>   }
>   
>   static void __exit ems_pci_exit(void)
>   {
> -	if (realtime_core_enabled())
> -		pci_unregister_driver(&ems_pci_driver);
> +	pci_unregister_driver(&ems_pci_driver);
>   }
>   
>   module_init(ems_pci_init);
> diff --git a/kernel/drivers/can/sja1000/rtcan_esd_pci.c b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
> index 924c7d0c74..97163a2228 100644
> --- a/kernel/drivers/can/sja1000/rtcan_esd_pci.c
> +++ b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
> @@ -342,16 +342,12 @@ static struct pci_driver rtcan_esd_pci_driver = {
>   
>   static int __init rtcan_esd_pci_init(void)
>   {
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>   	return pci_register_driver(&rtcan_esd_pci_driver);
>   }
>   
>   static void __exit rtcan_esd_pci_exit(void)
>   {
> -	if (realtime_core_enabled())
> -		pci_unregister_driver(&rtcan_esd_pci_driver);
> +	pci_unregister_driver(&rtcan_esd_pci_driver);
>   }
>   
>   module_init(rtcan_esd_pci_init);
> diff --git a/kernel/drivers/can/sja1000/rtcan_isa.c b/kernel/drivers/can/sja1000/rtcan_isa.c
> index c506081db8..10f4429081 100644
> --- a/kernel/drivers/can/sja1000/rtcan_isa.c
> +++ b/kernel/drivers/can/sja1000/rtcan_isa.c
> @@ -161,9 +161,6 @@ static int __init rtcan_isa_init(void)
>   	int i, err;
>   	int devices = 0;
>   
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>   	for (i = 0; i < RTCAN_ISA_MAX_DEV && io[i] != 0; i++) {
>   		err = rtcan_isa_init_one(i);
>   		if (err) {
> @@ -187,9 +184,6 @@ static void rtcan_isa_exit(void)
>   	int i;
>   	struct rtcan_device *dev;
>   
> -	if (!realtime_core_enabled())
> -		return;
> -
>   	for (i = 0; i < RTCAN_ISA_MAX_DEV; i++) {
>   		dev = rtcan_isa_devs[i];
>   		if (!dev)
> diff --git a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
> index eaabe1ac77..3172c78436 100644
> --- a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
> +++ b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
> @@ -296,17 +296,13 @@ static struct pci_driver rtcan_ixxat_pci_driver = {
>   
>   static int __init rtcan_ixxat_pci_init(void)
>   {
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>       return pci_register_driver(&rtcan_ixxat_pci_driver);
>   }
>   
>   
>   static void __exit rtcan_ixxat_pci_exit(void)
>   {
> -	if (realtime_core_enabled())
> -		pci_unregister_driver(&rtcan_ixxat_pci_driver);
> +	pci_unregister_driver(&rtcan_ixxat_pci_driver);
>   }
>   
>   module_init(rtcan_ixxat_pci_init);
> diff --git a/kernel/drivers/can/sja1000/rtcan_mem.c b/kernel/drivers/can/sja1000/rtcan_mem.c
> index c668f8f430..ff7d2d6649 100644
> --- a/kernel/drivers/can/sja1000/rtcan_mem.c
> +++ b/kernel/drivers/can/sja1000/rtcan_mem.c
> @@ -173,9 +173,6 @@ static int __init rtcan_mem_init(void)
>   	int i, err;
>   	int devices = 0;
>   
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>   	for (i = 0; i < RTCAN_MEM_MAX_DEV && mem[i] != 0; i++) {
>   		err = rtcan_mem_init_one(i);
>   		if (err) {
> @@ -200,9 +197,6 @@ static void rtcan_mem_exit(void)
>   	struct rtcan_device *dev;
>   	volatile void __iomem *vmem;
>   
> -	if (!realtime_core_enabled())
> -		return;
> -
>   	for (i = 0; i < RTCAN_MEM_MAX_DEV; i++) {
>   		dev = rtcan_mem_devs[i];
>   		if (!dev)
> diff --git a/kernel/drivers/can/sja1000/rtcan_peak_dng.c b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
> index b174625077..29e920aecb 100644
> --- a/kernel/drivers/can/sja1000/rtcan_peak_dng.c
> +++ b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
> @@ -345,9 +345,6 @@ static void rtcan_peak_dng_exit(void)
>       int i;
>       struct rtcan_device *dev;
>   
> -    if (!realtime_core_enabled())
> -        return;
> -
>       for (i = 0, dev = rtcan_peak_dng_devs[i];
>   	 i < RTCAN_PEAK_DNG_MAX_DEV && dev != NULL;
>   	 i++)
> @@ -362,9 +359,6 @@ static int __init rtcan_peak_dng_init(void)
>   {
>       int i, ret = -EINVAL, done = 0;
>   
> -    if (!realtime_core_enabled())
> -        return 0;
> -
>       if (pnp_register_driver(&rtcan_peak_dng_pnp_driver) == 0)
>   	pnp_registered = 1;
>   
> diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
> index 0fdc598be8..3f9e40b53a 100644
> --- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
> +++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
> @@ -353,17 +353,13 @@ static struct pci_driver rtcan_peak_pci_driver = {
>   
>   static int __init rtcan_peak_pci_init(void)
>   {
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>           return pci_register_driver(&rtcan_peak_pci_driver);
>   }
>   
>   
>   static void __exit rtcan_peak_pci_exit(void)
>   {
> -	if (realtime_core_enabled())
> -		pci_unregister_driver(&rtcan_peak_pci_driver);
> +	pci_unregister_driver(&rtcan_peak_pci_driver);
>   }
>   
>   module_init(rtcan_peak_pci_init);
> diff --git a/kernel/drivers/can/sja1000/rtcan_plx_pci.c b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
> index b90a43d139..3ede0faa95 100644
> --- a/kernel/drivers/can/sja1000/rtcan_plx_pci.c
> +++ b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
> @@ -596,16 +596,12 @@ static struct pci_driver plx_pci_driver = {
>   
>   static int __init plx_pci_init(void)
>   {
> -	if (!realtime_core_enabled())
> -		return 0;
> -
>   	return pci_register_driver(&plx_pci_driver);
>   }
>   
>   static void __exit plx_pci_exit(void)
>   {
> -	if (realtime_core_enabled())
> -		pci_unregister_driver(&plx_pci_driver);
> +	pci_unregister_driver(&plx_pci_driver);
>   }
>   
>   module_init(plx_pci_init);
> diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000.c b/kernel/drivers/can/sja1000/rtcan_sja1000.c
> index c7712ab307..414af286df 100644
> --- a/kernel/drivers/can/sja1000/rtcan_sja1000.c
> +++ b/kernel/drivers/can/sja1000/rtcan_sja1000.c
> @@ -822,17 +822,14 @@ void rtcan_sja1000_unregister(struct rtcan_device *dev)
>   
>   int __init rtcan_sja_init(void)
>   {
> -	if (realtime_core_enabled())
> -		printk("RTCAN SJA1000 driver initialized\n");
> -
> -    return 0;
> +	printk("RTCAN SJA1000 driver initialized\n");
> +	return 0;
>   }
>   
>   
>   void __exit rtcan_sja_exit(void)
>   {
> -	if (realtime_core_enabled())
> -		printk("%s removed\n", sja_ctrl_name);
> +	printk("%s removed\n", sja_ctrl_name);
>   }
>   
>   module_init(rtcan_sja_init);
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

