Message-ID: <475DA397.6000408@domain.hid>
Date: Mon, 10 Dec 2007 21:37:43 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <OFD2B0EC2A.B4C937F8-ONC12573AD.0036F9DB-C12573AD.00370BC4@domain.hid>
In-Reply-To: <OFD2B0EC2A.B4C937F8-ONC12573AD.0036F9DB-C12573AD.00370BC4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Antwort: Xenomai v2.4.0:
 CONFIG_XENO_OPT_SHIRQ_LEVEL vs. CONFIG_XENO_OPT_SHIRQ
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Thomas Wiedemann wrote:
> Hi,
> 
> we had a problem compiling the CAN-Driver for the last release candidate 
> when
> shared interrupts had been enabled, because of the re-named option
> "CONFIG_XENO_OPT_SHIRQ_LEVEL.". After a quick look, version 2.4.0 still
> doesn't fix this. A patch is included (for ksrc/drivers/can).

Ah, thanks for reporting. I'm going to remove these #ifdefs a.s.a.p.
It's sufficient to print an appropriate error messsage in case interrupt
registration fails with -EBUSY.

Wolfgang.

> ------------------------------------------------------------------------
> 
> diff -urN sja1000.orig/rtcan_ems_pci.c sja1000/rtcan_ems_pci.c
> --- sja1000.orig/rtcan_ems_pci.c	2007-09-16 19:20:45.000000000 +0200
> +++ sja1000/rtcan_ems_pci.c	2007-12-10 10:14:58.000000000 +0100
> @@ -272,7 +272,7 @@
>  	if ((err = rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
>  					  &master_dev)))
>  		goto failure_cleanup;
> -#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
> +#ifdef CONFIG_XENO_OPT_SHIRQ
>  	if ((err = rtcan_ems_pci_add_chan(pdev, EMS_PCI_SLAVE,
>  					  &master_dev)))
>  		goto failure_cleanup;
> diff -urN sja1000.orig/rtcan_ixxat_pci.c sja1000/rtcan_ixxat_pci.c
> --- sja1000.orig/rtcan_ixxat_pci.c	2007-09-16 19:20:45.000000000 +0200
> +++ sja1000/rtcan_ixxat_pci.c	2007-12-10 10:14:54.000000000 +0100
> @@ -254,7 +254,7 @@
>  	goto failure_iounmap;
>  
>      if (channel != CHANNEL_SINGLE) {
> -#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
> +#ifdef CONFIG_XENO_OPT_SHIRQ
>  	channel = CHANNEL_SLAVE;
>  	if ((ret = rtcan_ixxat_pci_add_chan(pdev, channel,
>  					    &master_dev, conf_addr,
> diff -urN sja1000.orig/rtcan_peak_pci.c sja1000/rtcan_peak_pci.c
> --- sja1000.orig/rtcan_peak_pci.c	2007-09-16 19:20:45.000000000 +0200
> +++ sja1000/rtcan_peak_pci.c	2007-12-10 10:14:51.000000000 +0100
> @@ -292,7 +292,7 @@
>  	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_MASTER, 
>  					   &master_dev)))
>  	    goto failure_cleanup;
> -#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
> +#ifdef CONFIG_XENO_OPT_SHIRQ
>  	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SLAVE, 
>  					   &master_dev)))
>  	    goto failure_cleanup;
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


