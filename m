Message-ID: <44FACCCF.8070903@domain.hid>
Date: Sun, 03 Sep 2006 14:38:39 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <44F5FA88.3030206@domain.hid>
In-Reply-To: <44F5FA88.3030206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] refactor and enhance rtcanrecv/send
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Jan,

Jan Kiszka wrote:
> For review:
> 
> This patch folds the rt-threads of rtcanrecv/send into the main thread,
> assigns unique thread names, and lowers the priorities to some less
> critical level. Furthermore, rtcanrecv is enhanced by a printout of the
> CAN device and support for listening on all interfaces. On reception of
> RTR frames, no more data is printing now. I also kicked out the
> rt_timer_set_mode call, please speak up if it was there for a reason.

Looks good and still works. I was also thinking to use recvmsg in 
rtcanrecv to show timestamps on request. Will provide a patch sooner 
than later.

Wolfgang.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: src/utils/can/rtcansend.c
> ===================================================================
> --- src/utils/can/rtcansend.c	(Revision 1525)
> +++ src/utils/can/rtcansend.c	(Arbeitskopie)
> @@ -69,7 +69,7 @@ void cleanup_and_exit(int sig)
>      exit(0);
>  }
>  
> -void rt_task(void *arg)
> +void rt_task(void)
>  {
>      int i, j, ret;
>  
> @@ -107,7 +107,6 @@ void rt_task(void *arg)
>  	    printf("\n");
>  	}
>      }
> -    loops = 0;
>  }
>  
>  int main(int argc, char **argv)
> @@ -115,6 +114,7 @@ int main(int argc, char **argv)
>      struct sockaddr_can addr;
>      int i, opt, ret;
>      struct ifreq ifr;
> +    char name[32];
>  
>      struct option long_options[] = {
>  	{ "help", no_argument, 0, 'h' },
> @@ -252,16 +252,14 @@ int main(int argc, char **argv)
>  	}
>      }
>  
> -     rt_timer_set_mode(TM_ONESHOT);
> -
> -    ret = rt_task_spawn(&rt_task_desc, "", 0, 99, 0, &rt_task, 0);
> +    snprintf(name, sizeof(name), "rtcansend-%d", getpid());
> +    ret = rt_task_shadow(&rt_task_desc, name, 1, 0);
>      if (ret) {
> -        fprintf(stderr, "rt_task_spawn: %s\n", strerror(-ret));
> +	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
>  	goto failure;
>      }
>  
> -    while (loops)
> -	usleep(100000);
> +    rt_task();
>  
>      cleanup();
>      return 0;
> Index: src/utils/can/rtcanrecv.c
> ===================================================================
> --- src/utils/can/rtcanrecv.c	(Revision 1525)
> +++ src/utils/can/rtcanrecv.c	(Arbeitskopie)
> @@ -15,14 +15,13 @@
>  static void print_usage(char *prg)
>  {
>      fprintf(stderr,
> -	    "Usage: %s <can-interface> [Options]\n"
> +	    "Usage: %s [<can-interface>] [Options]\n"
>  	    "Options:\n"
>  	    " -f  --filter=id:mask[:id:mask]... apply filter\n"
>  	    " -e  --error=mask      receive error messages\n"
>  	    " -t, --timeout=MS      timeout in ms\n"
>  	    " -v, --verbose         be verbose\n"
>  	    " -p, --print=MODULO    print every MODULO message\n"
> -	    " -n, --name=STRING     name of the RT task\n"
>  	    " -h, --help            this help\n",
>  	    prg);
>  }
> @@ -30,7 +29,7 @@ static void print_usage(char *prg)
>  
>  extern int optind, opterr, optopt;
>  
> -static int s = -1, running = 1, verbose = 0, print = 1;
> +static int s = -1, verbose = 0, print = 1;
>  static nanosecs_rel_t timeout = 0;
>  
>  RT_TASK rt_task_desc;
> @@ -75,18 +74,20 @@ void cleanup_and_exit(int sig)
>  {
>      if (verbose)
>  	printf("Signal %d received\n", sig);
> -    running = 0;
>      cleanup();
>      exit(0);
>  }
>  
> -void rt_task(void *arg)
> +void rt_task(void)
>  {
>      int i, ret, count = 0;
>      struct can_frame frame;
> +    struct sockaddr_can addr;
> +    socklen_t addrlen = sizeof(addr);
>  
> -    while (running) {
> -	ret = rt_dev_recv(s, (void *)&frame, sizeof(can_frame_t), 0);
> +    while (1) {
> +	ret = rt_dev_recvfrom(s, (void *)&frame, sizeof(can_frame_t), 0,
> +	                      (struct sockaddr *)&addr, &addrlen);
>  	if (ret < 0) {
>  	    switch (ret) {
>  	    case -ETIMEDOUT:
> @@ -100,12 +101,11 @@ void rt_task(void *arg)
>  	    default:
>  		fprintf(stderr, "rt_dev_recv: %s\n", strerror(-ret));
>  	    }
> -	    running = 0;
>  	    break;
>  	}
>  
>  	if (print && (count % print) == 0) {
> -	    printf("#%d: ", count);
> +	    printf("#%d: (%d) ", count, addr.can_ifindex);
>  	    if (frame.can_id & CAN_ERR_FLAG)
>  		printf("!0x%08x!", frame.can_id & CAN_ERR_MASK);
>  	    else if (frame.can_id & CAN_EFF_FLAG)
> @@ -114,9 +114,10 @@ void rt_task(void *arg)
>  		printf("<0x%03x>", frame.can_id & CAN_SFF_MASK);
>  
>  	    printf(" [%d]", frame.can_dlc);
> -	    for (i = 0; i < frame.can_dlc; i++) {
> -		printf(" %02x", frame.data[i]);
> -	    }
> +	    if (!(frame.can_id & CAN_RTR_FLAG))
> +		for (i = 0; i < frame.can_dlc; i++) {
> +		    printf(" %02x", frame.data[i]);
> +		}
>  	    if (frame.can_id & CAN_ERR_FLAG) {
>  		printf(" ERROR ");
>  		if (frame.can_id & CAN_ERR_BUSOFF)
> @@ -138,6 +139,7 @@ int main(int argc, char **argv)
>      u_int32_t err_mask = 0;
>      struct ifreq ifr;
>      char *ptr;
> +    char name[32];
>  
>      struct option long_options[] = {
>  	{ "help", no_argument, 0, 'h' },
> @@ -153,7 +155,7 @@ int main(int argc, char **argv)
>      signal(SIGTERM, cleanup_and_exit);
>      signal(SIGINT, cleanup_and_exit);
>  
> -    while ((opt = getopt_long(argc, argv, "hve:f:t:p:n:",
> +    while ((opt = getopt_long(argc, argv, "hve:f:t:p:",
>  			      long_options, NULL)) != -1) {
>  	switch (opt) {
>  	case 'h':
> @@ -200,19 +202,6 @@ int main(int argc, char **argv)
>  	}
>      }
>  
> -    if (optind == argc) {
> -	print_usage(argv[0]);
> -	exit(0);
> -    }
> -
> -    if (argv[optind] == NULL) {
> -	fprintf(stderr, "No Interface supplied\n");
> -	exit(-1);
> -    }
> -
> -    if (verbose)
> -	printf("interface %s\n", argv[optind]);
> -
>      ret = rt_dev_socket(PF_CAN, SOCK_RAW, 0);
>      if (ret < 0) {
>  	fprintf(stderr, "rt_dev_socket: %s\n", strerror(-ret));
> @@ -220,17 +209,26 @@ int main(int argc, char **argv)
>      }
>      s = ret;
>  
> -    strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
> -    if (verbose)
> -	printf("s=%d, ifr_name=%s\n", s, ifr.ifr_name);
> +    if (argv[optind] == NULL) {
> +	if (verbose)
> +	    printf("interface all\n");
>  
> -    ret = rt_dev_ioctl(s, SIOCGIFINDEX, &ifr);
> -    if (ret < 0) {
> -	fprintf(stderr, "rt_dev_ioctl GET_IFINDEX: %s\n", strerror(-ret));
> -	goto failure;
> +	ifr.ifr_ifindex = 0;
> +    } else {
> +	if (verbose)
> +	    printf("interface %s\n", argv[optind]);
> +	
> +	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
> +	if (verbose)
> +	    printf("s=%d, ifr_name=%s\n", s, ifr.ifr_name);
> +	
> +	ret = rt_dev_ioctl(s, SIOCGIFINDEX, &ifr);
> +	if (ret < 0) {
> +	    fprintf(stderr, "rt_dev_ioctl GET_IFINDEX: %s\n", strerror(-ret));
> +	    goto failure;
> +	}
>      }
>  
> -
>      if (err_mask) {
>  	ret = rt_dev_setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
>  				&err_mask, sizeof(err_mask));
> @@ -271,19 +269,15 @@ int main(int argc, char **argv)
>  	}
>      }
>  
> -    rt_timer_set_mode(TM_ONESHOT);
> -
> -    ret = rt_task_spawn(&rt_task_desc, "", 0, 99, 0, &rt_task, 0);
> +    snprintf(name, sizeof(name), "rtcanrecv-%d", getpid());
> +    ret = rt_task_shadow(&rt_task_desc, name, 1, 0);
>      if (ret) {
> -        fprintf(stderr, "rt_task_spawn: %s\n", strerror(-ret));
> +	fprintf(stderr, "rt_task_shadow: %s\n", strerror(-ret));
>  	goto failure;
>      }
>  
> -    while (running)
> -	usleep(100000);
> -
> -    cleanup();
> -    return 0;
> +    rt_task();
> +    /* never returns */
>  
>   failure:
>      cleanup();


