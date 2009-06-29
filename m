From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A48DADC.7090309@domain.hid>
References: <4A48DADC.7090309@domain.hid>
Content-Type: text/plain
Date: Mon, 29 Jun 2009 17:42:28 +0200
Message-Id: <1246290148.4040.24.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] comedi rtdm_interface.c build
	fails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, xenomai@xenomai.org

On Mon, 2009-06-29 at 17:16 +0200, Stefan Kisdaroczi wrote:
> Hi,
> 
> comedi rtdm_interface.c build fails (typo), patch attached.
> 
> breaking commit:
>   Fri, 12 Jun 2009 08:03:39 +0000 (10:03 +0200)
>   e20bd3f2613a052b93c1a4ecada6623a5332f54c
>   Made conditional inclusion of owner field in struct proc_dir_entry due to changes in 2.6.30.
> 
> Error:
>   CC [M]  drivers/xenomai/comedi/rtdm_interface.o
> drivers/xenomai/comedi/rtdm_interface.c: In function "comedi_init_proc":
> drivers/xenomai/comedi/rtdm_interface.c:81: error: "enrty" undeclared (first use in this function)
> drivers/xenomai/comedi/rtdm_interface.c:81: error: (Each undeclared identifier is reported only once
> drivers/xenomai/comedi/rtdm_interface.c:81: error: for each function it appears in.)
> 

Thanks for the feedback. Please Cc: Alex for Comedi/RTDM related issues,
and probably xenomai-core instead of -help as well.

TIA,

> plain text document attachment (xeno_comedi_rtdm.patch)
> diff --git a/ksrc/drivers/comedi/rtdm_interface.c b/ksrc/drivers/comedi/rtdm_interface.c
> index d4ea5ac..73687b6 100644
> --- a/ksrc/drivers/comedi/rtdm_interface.c
> +++ b/ksrc/drivers/comedi/rtdm_interface.c
> @@ -78,7 +78,7 @@ int comedi_init_proc(void)
>  	entry->data = NULL;
>  	entry->write_proc = NULL;
>  	entry->read_proc = comedi_rdproc_devs;
> -	wrap_proc_dir_entry_owner(enrty);
> +	wrap_proc_dir_entry_owner(entry);
>  
>  	/* Creates the drivers related file */
>  	entry = create_proc_entry("drivers", 0444, comedi_proc_root);
> @@ -93,7 +93,7 @@ int comedi_init_proc(void)
>  	entry->data = NULL;
>  	entry->write_proc = NULL;
>  	entry->read_proc = comedi_rdproc_drvs;
> -	wrap_proc_dir_entry_owner(enrty);
> +	wrap_proc_dir_entry_owner(entry);
>  
>  	return 0;
>  
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



