Subject: Re: Posix periodic time first tick
References: <20200807171220.E090CB18@centrum.cz>
 <166391923.711496.1597041953464.JavaMail.zimbra@wolfram.com>
 <4baa56a0-13dc-08d7-79d4-00f63f85c2b0@centrum.cz>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8f666cae-3e7d-fc9c-98a5-a6f5bb3a11cc@xenomai.org>
Date: Mon, 10 Aug 2020 11:49:25 +0200
MIME-Version: 1.0
In-Reply-To: <4baa56a0-13dc-08d7-79d4-00f63f85c2b0@centrum.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 8/10/20 9:52 AM, Petr Červenka via Xenomai wrote:
> Hello.
> 
> The problem is only when I use Xenomai linking flags and only with thestart
> time. Period is OK.
> 
> That aprox. 16s time delay can be "compensated" by substracting of any number
> of seconds from the start time.
> 
>     // Create timer
>     timer_fd = timerfd_create(CLOCK_MONOTONIC, 0);
> 
>     // Get current time
>     struct timespec start;
>     clock_gettime(CLOCK_MONOTONIC, &start);
> 
>     // Set periodic
>     struct itimerspec timer_conf;
>     memset(&timer_conf, 0, sizeof (timer_conf));
>     timer_conf.it_value = timespec_add(start, -15 * NANOSEC_PER_SEC); //
> compensation of the delay
>     ...
>     timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &timer_conf, NULL);
> 
> There is strange unexpected difference/time shift between product of
> clock_gettime and timerfd_settime. Only with Xenomai posix wrappers.
> 

To debug that kind of issues, you first need to check whether the symbol
wrapping is ok in the executable image. A common way to do this is to do a
visual inspection of the name list with nm, e.g. for the 'latency' program
which uses the timerfd services, one could do:

{rpm@cobalt} aarch64-linux-gnu-nm -o .../latency | grep -e __wrap
.../latency:                 U __wrap_clock_gettime
.../latency:                 U __wrap_close
.../latency:                 U __wrap_fclose
.../latency:                 U __wrap_fprintf
.../latency:                 U __wrap_fputc
.../latency:                 U __wrap_fputs
.../latency:                 U __wrap_free
.../latency:                 U __wrap_fwrite
.../latency:                 U __wrap_ioctl
.../latency:                 U __wrap_kill
.../latency:0000000000402728 W __wrap_main
.../latency:                 U __wrap_open
.../latency:                 U __wrap_printf
.../latency:                 U __wrap_pthread_attr_init
.../latency:                 U __wrap_pthread_create
.../latency:                 U __wrap_pthread_join
.../latency:                 U __wrap_pthread_setname_np
.../latency:                 U __wrap_puts
.../latency:                 U __wrap_read
.../latency:                 U __wrap_sem_close
.../latency:                 U __wrap_sem_open
.../latency:                 U __wrap_sem_post
.../latency:                 U __wrap_sem_unlink
.../latency:                 U __wrap_sem_wait
.../latency:                 U __wrap_time
.../latency:                 U __wrap_timerfd_create
.../latency:                 U __wrap_timerfd_settime
.../latency:                 U __wrap_write

We can see that all calls to the timerfd and clock_gettime services are
wrapped to libcobalt, which is right.

Weird delays may be caused by discrepancies in the call set, e.g. feeding
cobalt's timerfd services with the output of glibc's regular clock_gettime()
call. Since cobalt clocks defines epochs which differ from the common
kernel's, they won't mix nicely.

IOW, the issue may be in your build recipe, affecting such wrapping, not in
your code.

PS: you could also annotate the calls to clock_gettime() and friends in a way
which guarantees that the cobalt version is going to be used, e.g.

ret = __RT(clock_gettime(...));
...
ret = __RT(timerfd_ceate(...));

Granted, this looks ugly, but in some cases this is helpful, particularly in
order to figure out any issue with the wrapping.

-- 
Philippe.

