Message-ID: <435928DA.3050807@domain.hid>
Date: Fri, 21 Oct 2005 19:43:54 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] signedness issues in testsuite
References: <4358A665.2020903@domain.hid>
In-Reply-To: <4358A665.2020903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Fixes gcc-4 warnings.
> 

Applied, thanks.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: testsuite/latency/latency.c
> ===================================================================
> --- testsuite/latency/latency.c	(revision 54)
> +++ testsuite/latency/latency.c	(working copy)
> @@ -40,9 +40,9 @@
>  #define WARMUP_TIME 1
>  #define HISTOGRAM_CELLS 100
>  int histogram_size = HISTOGRAM_CELLS;
> -unsigned long *histogram_avg = NULL,
> -    *histogram_max = NULL,
> -    *histogram_min = NULL;
> +long *histogram_avg = NULL,
> +     *histogram_max = NULL,
> +     *histogram_min = NULL;
>  
>  int do_histogram = 0, do_stats = 0, finished = 0;
>  int bucketsize = 1000;  /* default = 1000ns, -B <size> to override */
> Index: testsuite/klatency/latency.c
> ===================================================================
> --- testsuite/klatency/latency.c	(revision 54)
> +++ testsuite/klatency/latency.c	(working copy)
> @@ -12,9 +12,9 @@
>  
>  #define HISTOGRAM_CELLS 200
>  int histogram_size = HISTOGRAM_CELLS;
> -unsigned long *histogram_avg = NULL,
> -              *histogram_max = NULL,
> -              *histogram_min = NULL;
> +long *histogram_avg = NULL,
> +     *histogram_max = NULL,
> +     *histogram_min = NULL;
>  
>  int do_histogram = 0, do_stats = 0, finished = 0;
>  int bucketsize = 1000;		/* bucketsize */
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

