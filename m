Date: Sun, 17 Oct 2010 23:35:03 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20101017213503.GA21390@domain.hid>
References: <4CB41FF2.9030602@domain.hid>
	<AANLkTi=kR0fT-NFOuC_z=Y8HNVaXu1j5f76VG1TVoFD5@domain.hid>
	<4CB5CBCE.9050908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CB5CBCE.9050908@domain.hid>
Subject: Re: [Xenomai-core] Analogy regressions in xenomai 2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Daniele Nicolodi wrote:
> On 13/10/10 08:31, Alexis Berlemont wrote:
> >> 1. Buffer management is badly broken. It is not possible to run any
> >> acquisition command that wraps around in the ring buffer. That can be
> >> simply reproduced with:
> >>
> >> cmd_read -v d analogy0 -s 0 -S 0
> >>
> >> after a while it will fail with: "cmd_read: a4l_read failed (ret=-32)".
> >> In dmesg the driver reports: "Analogy: MITE: DME overwrite of free area".
> > 
> > OK. Maybe, it is not Analogy's buffer management; it may be specific
> > to the NI driver. Did you try to reproduce the bug with another driver
> > (analogy_fake for example)? It may be due to some fix I made this
> > summer (which is surprising, I thought I tested the change quite
> > exhaustively... Sorry for that).
> 
> The problem is probably in the NI driver. I'm unable to reproduce the
> bug with the analogy_fake driver. See attached test script.
> 

The bug was not located in the NI driver but in the wrong setting of
the default size of the buffer. It is fixed now. If you have time to
cross-check on your board, that would be nice (xenomai-abe / branch
analogy). 

> >> 2. Buffer is kept memory mapped after the mapping process dies. If a
> >> process mapping a device buffer dies before un-mapping the buffer, it is
> >> not possible to reconfigure the bnuffer. a4l_set_bufsize fails with
> >> error code 32 and dmesg read "Analogy: a4l_ioctl_bufcfg: please unmap
> >> before configuring buffer". Sinche the mapping process died I do not
> >> know how to do this.
> >>
> > With a 2.4.x release, did you manage to reproduce the bug?
> 
> I'm unable to reproduce the bug with xenomai 2.5.3. See attached test.
> It depends on a patch to make the --read-buffer-size and
> --write-buffer-size options to analogy_config to effectively work. Also
> attached. I do not have a 2.5.4 version handy.
> 
> Cheers,
> -- 
> Daniele
> 



> /**
>  * analogy for linux - input command test program
>  */
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <errno.h>
> #include <getopt.h>
> #include <string.h>
> 
> #include <analogy/analogy.h>
> 
> /* default device name */
> #define DEVICE "analogy0"
> 
> #define DEBUG(frmt, args...) fprintf(stderr, frmt"\n", ##args)
> #define ERROR(frmt, args...) fprintf(stderr, frmt"\n", ##args)
> 
> int main(int argc, char **argv)
> {
>      int rv = 0;
>      unsigned long bufsize;
>      void *map = NULL;
>      a4l_desc_t dsc;
> 
>      char *filename = argv[1];
> 
>      /* open the device */
>      rv = a4l_open(&dsc, filename);
>      if (rv < 0) {	  
> 	  ERROR("analogy open");
> 	  return rv;
>      }
>                     
>      /* cancel any command which might be in progress */
>      a4l_snd_cancel(&dsc, dsc.idx_read_subd);
>      
>      /* get buffer size to map */
>      rv = a4l_get_bufsize(&dsc, dsc.idx_read_subd, &bufsize);
>      if (rv < 0) {
> 	  ERROR("analogy get bufsize");
> 	  return rv;
>      }
> 
>      /* map read subdevice buffer */
>      rv = a4l_mmap(&dsc, dsc.idx_read_subd, bufsize, &map);
>      if (rv < 0) {
> 	  ERROR("analogy mmap");
> 	  return rv;
>      }
> 
>      if (argc > 2) {
> 	  DEBUG("BUG!");
>      } else {	  
> 	  /* unmap subdevice buffer */
> 	  munmap(map, bufsize);
>      }
>      
>      /* close file descriptor */
>      a4l_close(&dsc);
>      
>      exit(0);
> }
> 

> commit e7ac38f3f45e439a8d383f3b4adafbb97bf543fe
> Author: Daniele Nicolodi <nicolodi@domain.hid>
> Date:   Wed Oct 13 16:03:30 2010 +0200
> 
>     Make the --read-buffer-size and --write-buffer-size otpions effective.
> 
> diff --git a/src/utils/analogy/analogy_config.c b/src/utils/analogy/analogy_config.c
> index 1482322..2ce3ddd 100644
> --- a/src/utils/analogy/analogy_config.c
> +++ b/src/utils/analogy/analogy_config.c
> @@ -31,28 +31,25 @@
>  
>  #include <analogy/analogy.h>
>  
> -/* Declare precompilation constants */
> -#define __NBMIN_ARG 2
> -#define __NBMAX_ARG 3
> -#define __OPTS_DELIMITER ","
> +enum action {
> +	ATTACH_DRIVER,
> +	DETACH_DRIVER,
> +	CONFIGURE_BUFFER_SIZE,
> +};
>  
> -/* Declare prog variables */
> -int vlevel = 1;
> -int unatt_act = 0;
> -struct option a4l_conf_opts[] = {
> -	{"help", no_argument, NULL, 'h'},
> -	{"verbose", no_argument, NULL, 'v'},
> -	{"quiet", no_argument, NULL, 'q'},
> -	{"version", no_argument, NULL, 'V'},
> -	{"remove", no_argument, NULL, 'r'},
> -	{"read-buffer-size", required_argument, NULL, 'R'},
> -	{"write-buffer-size", required_argument, NULL, 'W'},
> -	{0},
> +enum subdevice {
> +	READ_SUBDEVICE,
> +	WRITE_SUBDEVICE,
>  };
>  
> +/* Verbosity level */
> +int vlevel = 1;
> +
> +/* Driver specific Options delimiter */
> +#define DELIMITER ","
> +
>  int compute_opts(char *opts, unsigned int *nb, unsigned long *res)
>  {
> -
>  	int ret = 0, len, ofs;
>  
>  	/* Check arg and inits it */
> @@ -67,7 +64,7 @@ int compute_opts(char *opts, unsigned int *nb, unsigned long *res)
>  	do {
>  		(*nb)++;
>  		len = strlen(opts);
> -		ofs = strcspn(opts, __OPTS_DELIMITER);
> +		ofs = strcspn(opts, DELIMITER);
>  		if (res != NULL) {
>  			res[(*nb) - 1] = strtoul(opts, NULL, 0);
>  			if (errno != 0) {
> @@ -104,79 +101,57 @@ void do_print_usage(void)
>  		"\t\t -W, --write-buffer-size: write buffer size in kB\n");
>  }
>  
> -int main(int argc, char *argv[])
> +int detach_driver(const char *devfile)
>  {
> -	int c;
> -	char *devfile;
> -	a4l_lnkdesc_t lnkdsc;
> -	int chk_nb, ret = 0, fd = -1;
> -
> -	/* Init the descriptor structure */
> -	memset(&lnkdsc, 0, sizeof(a4l_lnkdesc_t));
> -
> -	/* Compute arguments */
> -	while ((c =
> -		getopt_long(argc, argv, "hvqVrR:W:", a4l_conf_opts,
> -			    NULL)) >= 0) {
> -		switch (c) {
> -		case 'h':
> -			do_print_usage();
> -			goto out_a4l_config;
> -		case 'v':
> -			vlevel = 2;
> -			break;
> -		case 'q':
> -			vlevel = 0;
> -			break;
> -		case 'V':
> -			do_print_version();
> -			goto out_a4l_config;
> -		case 'r':
> -			unatt_act = 1;
> -			break;
> -		case 'R':
> -			break;
> -		case 'W':
> -			break;
> -		}
> +	/* Open device */
> +	int fd = a4l_sys_open(devfile);
> +	if (fd < 0) {
> +		fprintf(stderr, "a4l_open failed ret=%d\n", fd);
> +		return fd;
>  	}
>  
> -	/* Check the last arguments */
> -	chk_nb = (unatt_act == 0) ? __NBMIN_ARG : __NBMIN_ARG - 1;
> -	if (argc - optind < chk_nb) {
> -		do_print_usage();
> -		goto out_a4l_config;
> +	/* Detach driver */
> +	int ret = a4l_sys_detach(fd);
> +	if (ret < 0) {
> +		fprintf(stderr, "a4l_snd_detach failed ret=%d\n", ret);
> +		return ret;
>  	}
> +	
> +	/* Close device */
> +	a4l_sys_close(fd);
>  
> -	/* Get the device file name */
> -	devfile = argv[optind];
> +	return 0;
> +}
> +
> +int attach_driver(const char *devfile, char *driver, char *opts)
> +{	
> +	int ret;
> +	a4l_lnkdesc_t lnkdsc;
> +
> +	/* Init the descriptor structure */
> +	memset(&lnkdsc, 0, sizeof(a4l_lnkdesc_t));
>  
>  	/* Fill the descriptor with the driver name */
> -	if (unatt_act == 0) {
> -		lnkdsc.bname = argv[optind + 1];
> -		lnkdsc.bname_size = strlen(argv[optind + 1]);
> -	}
> +	lnkdsc.bname = driver;
> +	lnkdsc.bname_size = strlen(driver);
>  
> -	/* Handle the last arguments: the driver-specific args */
> -	if (unatt_act == 1 || argc - optind != __NBMAX_ARG)
> -		lnkdsc.opts_size = 0;
> -	else {
> -		char *opts = argv[optind + __NBMAX_ARG - 1];
> +	/* Handle driver specific options */
> +	lnkdsc.opts_size = 0;
> +	if (opts != NULL) {
>  		if ((ret = compute_opts(opts, &lnkdsc.opts_size, NULL)) < 0) {
>  			fprintf(stderr,
>  				"analogy_config: specific-driver options recovery failed\n");
>  			fprintf(stderr,
>  				"\twarning: specific-driver options must be integer value\n");
>  			do_print_usage();
> -			goto out_a4l_config;
> +			return -1;
>  		}
>  
>  		lnkdsc.opts = malloc(lnkdsc.opts_size);
>  		if (lnkdsc.opts == NULL) {
>  			fprintf(stderr,
>  				"analogy_config: memory allocation failed\n");
> -			ret = -ENOMEM;
> -			goto out_a4l_config;
> +			return -ENOMEM;
>  		}
>  
>  		if ((ret =
> @@ -186,38 +161,165 @@ int main(int argc, char *argv[])
>  			fprintf(stderr,
>  				"\twarning: specific-driver options must be integer value\n");
>  			do_print_usage();
> -			goto out_a4l_config;
> +			return -1;
>  		}
>  	}
>  
>  	/* Open the specified file */
> -	fd = a4l_sys_open(devfile);
> +	int fd = a4l_sys_open(devfile);
>  	if (fd < 0) {
> -		ret = fd;
> -		fprintf(stderr, "analogy_config: a4l_open failed ret=%d\n",
> -			ret);
> -		goto out_a4l_config;
> +		fprintf(stderr, "a4l_open failed ret=%d\n", fd);
> +		return fd;
>  	}
>  
> -	/* Trigger the ioctl */
> -	if (unatt_act == 0)
> -		ret = a4l_sys_attach(fd, &lnkdsc);
> -	else
> -		ret = a4l_sys_detach(fd);
> +	/* Attach driver */
> +	ret = a4l_sys_attach(fd, &lnkdsc);
>  	if (ret < 0) {
> -		fprintf(stderr, "analogy_config: %s failed ret=%d\n",
> -			(unatt_act ==
> -			 0) ? "a4l_snd_attach" : "a4l_snd_detach", ret);
> -		goto out_a4l_config;
> +		fprintf(stderr, "a4l_snd_attach failed ret=%d\n", ret);
> +		return ret;
>  	}
>  
> -out_a4l_config:
> +	/* Close device */	
> +	a4l_sys_close(fd);
>  
> -	if (fd >= 0)
> -		a4l_sys_close(fd);
> +	free(lnkdsc.opts);
>  
> -	if (lnkdsc.opts != NULL)
> -		free(lnkdsc.opts);
> +	return 0;
> +}
>  
> -	return ret;
> +int configure_buffer_size(char *device, int subd, unsigned long size)
> +{
> +	/* Open device */
> +	a4l_desc_t dsc;
> +	int ret = a4l_open(&dsc, device);
> +	if (ret < 0) {
> +		fprintf(stderr, "a4l_open error ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Choose subdevice */
> +	unsigned long subd_idx = (subd == READ_SUBDEVICE ? dsc.idx_read_subd : dsc.idx_write_subd);
> +	const char *name = (subd == READ_SUBDEVICE ? "read" : "write");
> +
> +	/* Get buffer size */
> +	unsigned long bufsize;
> +	ret = a4l_get_bufsize(&dsc, subd_idx, &bufsize);
> +	if (ret < 0) {
> +		fprintf(stderr, "a4l_get_bufsize error ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if (size > 0) {
> +
> +		/* Configure buffer size */
> +		ret = a4l_set_bufsize(&dsc, subd_idx, size);
> +		if (ret < 0) {
> +			fprintf(stderr, "a4l_set_bufsize error ret=%d\n", ret);
> +			return -1;
> +		}
> +
> +		/* Report buffer size */
> +		if (vlevel > 1) {
> +			fprintf(stdout, "old %s buffer size = %lu\n", name, bufsize);
> +			fprintf(stdout, "new %s buffer size = %lu\n", name, size);
> +		}
> +
> +	} else {
> +
> +		/* Report buffer size */
> +		if (vlevel > 0)
> +			fprintf(stdout, "%s buffer size = %lu\n", name, bufsize);
> +		else
> +			fprintf(stdout, "%lu\n", bufsize);
> +
> +	}
> +
> +	/* Close device */
> +	ret = a4l_close(&dsc);
> +	if (ret < 0) {
> +		fprintf(stderr, "a4l_close error ret=%d\n", ret);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int c;
> +	int action;
> +	int subdevice = -1;
> +	unsigned long size = 0;
> +
> +	/* Default action is to attach a driver */
> +	action = ATTACH_DRIVER;
> +
> +	struct option options[] = {
> +		{"help",              no_argument,       NULL, 'h'},
> +		{"verbose",           no_argument,       NULL, 'v'},
> +		{"quiet",             no_argument,       NULL, 'q'},
> +		{"version",           no_argument,       NULL, 'V'},
> +		{"remove",            no_argument,       NULL, 'r'},
> +		{"read-buffer-size",  optional_argument, NULL, 'R'},
> +		{"write-buffer-size", optional_argument, NULL, 'W'},
> +		{ 0 },
> +	};
> +
> +	/* Compute arguments */
> +	while ((c =
> +		getopt_long(argc, argv, "hvqVrR::W::", options, NULL)) >= 0) {
> +		switch (c) {
> +		case 'h':
> +			do_print_usage();
> +			return 0;
> +		case 'v':
> +			vlevel = 2;
> +			break;
> +		case 'q':
> +			vlevel = 0;
> +			break;
> +		case 'V':
> +			do_print_version();
> +			return 0;
> +		case 'r':
> +			action = DETACH_DRIVER;
> +			break;
> +		case 'R':
> +			action = CONFIGURE_BUFFER_SIZE;
> +			subdevice = READ_SUBDEVICE;
> +			if (optarg)
> +				size = strtoul(optarg, NULL, 10);
> +			break;
> +		case 'W':
> +			action = CONFIGURE_BUFFER_SIZE;
> +			subdevice = WRITE_SUBDEVICE;
> +			if (optarg)
> +				size = strtoul(optarg, NULL, 10);
> +			break;
> +		}
> +	}
> +
> +	switch (action) {
> +	case ATTACH_DRIVER:
> +		if ((argc - optind) == 2)
> +			return attach_driver(argv[optind], argv[optind+1], NULL);
> +		if ((argc - optind) == 3)
> +			return attach_driver(argv[optind], argv[optind+1], argv[optind+2]);
> +		do_print_usage();
> +		return -1;
> +		
> +	case DETACH_DRIVER:
> +		if ((argc - optind) == 1)
> +			return detach_driver(argv[optind]);
> +		do_print_usage();
> +		return -1;
> +
> +	case CONFIGURE_BUFFER_SIZE:
> +		if ((argc - optind) == 1)
> +			return configure_buffer_size(argv[optind], subdevice, size);
> +		do_print_usage();
> +		return -1;
> +	}
> +
> +	return 0;
>  }
> 

> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Alexis.

