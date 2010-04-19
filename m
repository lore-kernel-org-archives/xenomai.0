From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:55 +0200
Message-Id: <98308c9f1e20645f50a7d673ad22ad05666d8ba2.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 15/25] irqbench: Refactor user space
	helpers
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Indent according to our style, push irqbench's inner loop into separate
function. No functional changes.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/testsuite/irqbench/irqbench.c |  480 ++++++++++++++++++-------------------
 src/testsuite/irqbench/irqloop.c  |  303 ++++++++++++------------
 2 files changed, 393 insertions(+), 390 deletions(-)

diff --git a/src/testsuite/irqbench/irqbench.c b/src/testsuite/irqbench/irqbench.c
index 6b22711..844f187 100644
--- a/src/testsuite/irqbench/irqbench.c
+++ b/src/testsuite/irqbench/irqbench.c
@@ -51,268 +51,266 @@
 #define STAT(base) (base + 1) /* Status register */
 #define CTRL(base) (base + 2) /* Control register */
 
-double tsc2ns_scale;
-long long min_lat = LONG_MAX;
-long long max_lat = LONG_MIN;
-long long avg_lat = 0;
-long outer_loops = 0;
-int warmup = 1;
-int terminate = 0;
+static double tsc2ns_scale;
+static long long min_lat = LONG_MAX;
+static long long max_lat = LONG_MIN;
+static long long avg_lat;
+static long outer_loops;
+static int warmup = 1;
+static int terminate;
+static unsigned long port_ioaddr = 0x3F8;
+static int port_type = SERPORT;
+static unsigned int toggle;
+static long loop_avg;
+static long long period = 100000;
+static int trigger_trace;
 
 static inline long long rdtsc(void)
 {
-    unsigned long long tsc;
+	unsigned long long tsc;
 
-    __asm__ __volatile__("rdtsc" : "=A" (tsc));
-    return tsc;
+	__asm__ __volatile__("rdtsc" : "=A" (tsc));
+	return tsc;
 }
 
-
 static long tsc2ns(long long tsc)
 {
-    if ((tsc > LONG_MAX) || (tsc < LONG_MIN)) {
-        fprintf(stderr, "irqbench: overflow (%lld ns)!\n",
-                (long long)(tsc2ns_scale * (double)tsc));
-        exit(2);
-    }
-    return (long)(tsc2ns_scale * (double)tsc);
+	if (tsc > LONG_MAX || tsc < LONG_MIN) {
+		fprintf(stderr, "irqbench: overflow (%lld ns)!\n",
+			(long long)(tsc2ns_scale * (double)tsc));
+		exit(2);
+	}
+	return (long)(tsc2ns_scale * (double)tsc);
 }
 
-
 static inline long long ns2tsc(long long ns)
 {
-    return (long long)(((double)ns) / tsc2ns_scale);
+	return (long long)(((double)ns) / tsc2ns_scale);
 }
 
-
-void calibrate_tsc(void)
+static void calibrate_tsc(void)
 {
-    FILE *proc;
-    char *lineptr = NULL;
-    size_t len;
-    double cpu_mhz;
-
-    proc = fopen("/proc/cpuinfo", "r");
-    if (proc == NULL) {
-        perror("irqbench: Unable to open /proc/cpuinfo");
-        exit(1);
-    }
-
-    while (getline(&lineptr, &len, proc) != -1)
-        if (strncmp(lineptr, "cpu MHz", 7) == 0) {
-            sscanf(strchr(lineptr, ':') + 1, "%lf", &cpu_mhz);
-            break;
-        }
-
-    if (lineptr)
-        free(lineptr);
-    fclose(proc);
-
-    printf("CPU frequency: %.3lf MHz\n", cpu_mhz);
-
-    tsc2ns_scale = 1000.0 / cpu_mhz;
+	FILE *proc;
+	char *lineptr = NULL;
+	size_t len;
+	double cpu_mhz;
+
+	proc = fopen("/proc/cpuinfo", "r");
+	if (proc == NULL) {
+		perror("irqbench: Unable to open /proc/cpuinfo");
+		exit(1);
+	}
+
+	while (getline(&lineptr, &len, proc) != -1)
+		if (strncmp(lineptr, "cpu MHz", 7) == 0) {
+			sscanf(strchr(lineptr, ':') + 1, "%lf", &cpu_mhz);
+			break;
+		}
+
+	if (lineptr)
+		free(lineptr);
+	fclose(proc);
+
+	printf("CPU frequency: %.3lf MHz\n", cpu_mhz);
+
+	tsc2ns_scale = 1000.0 / cpu_mhz;
 }
 
-
-void sighand(int signal)
+static void sighand(int signal)
 {
-    if (warmup)
-        exit(0);
-    else
-        terminate = 1;
+	if (warmup)
+		exit(0);
+	else
+		terminate = 1;
 }
 
+static void do_inner_loop(void)
+{
+	long long start, delay, timeout;
+	long lat;
+
+	__asm__ __volatile__("cli");
+
+	if (port_type ==  SERPORT) {
+		start = rdtsc();
+
+		toggle ^= MCR_RTS;
+		outb(toggle, MCR(port_ioaddr));
+
+		timeout = start + period * 100;
+		while ((inb(MSR(port_ioaddr)) & MSR_DELTA) == 0 &&
+		       rdtsc() < timeout);
+
+		delay = rdtsc() - start;
+	} else {
+		int status = inb(STAT(port_ioaddr));
+
+		outb(0x08, DATA(port_ioaddr));
+
+		start = rdtsc();
+
+		outb(0x00, DATA(port_ioaddr));
+
+		timeout = start + period * 100;
+		while (inb(STAT(port_ioaddr)) == status &&
+		       rdtsc() < timeout);
+
+		delay = rdtsc() - start;
+	}
+
+	if (!warmup) {
+		lat = tsc2ns(delay);
+
+		loop_avg += lat;
+		if (lat < min_lat)
+			min_lat = lat;
+		if (lat > max_lat) {
+			max_lat = lat;
+			if (trigger_trace) {
+				if (port_type == SERPORT) {
+					toggle ^= MCR_DTR;
+					outb(toggle, MCR(port_ioaddr));
+				} else {
+					outb(0x18, DATA(port_ioaddr));
+					outb(0x10, DATA(port_ioaddr));
+				}
+			}
+		}
+	}
+
+	__asm__ __volatile__("sti");
+
+	while (rdtsc() < start + period);
+}
 
 int main(int argc, char *argv[])
 {
-    int                 port_type   = SERPORT;
-    unsigned long       port_ioaddr = 0x3F8;
-    int                 ioaddr_set = 0;
-    long long           period = 100000;
-    long long           timeout;
-    long long           start, delay;
-    unsigned long long  count = 1;
-    unsigned int        toggle = 0;
-    int                 trigger_trace = 0;
-    int                 c;
-
-
-    signal(SIGINT, sighand);
-    signal(SIGTERM, sighand);
-    signal(SIGHUP, sighand);
-    signal(SIGALRM, sighand);
-
-    calibrate_tsc();
-
-    while ((c = getopt(argc,argv,"p:T:o:a:f")) != EOF)
-        switch (c) {
-            case 'p':
-                period = atoi(optarg) * 1000;
-                break;
-
-            case 'T':
-                alarm(atoi(optarg));
-                break;
-
-            case 'o':
-                port_type = atoi(optarg);
-                break;
-
-            case 'a':
-                port_ioaddr = strtol(optarg, NULL,
-                    (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
-                ioaddr_set = 1;
-                break;
-
-            case 'f':
-                trigger_trace = 1;
-                break;
-
-            default:
-                fprintf(stderr, "usage: irqbench [options]\n"
-                        "  [-p <period_us>]             # signal period, default=100 us\n"
-                        "  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
-                        "  [-o <port_type>]             # 0=serial (default), 1=parallel\n"
-                        "  [-a <port_io_address>]       # default=0x3f8/0x378\n"
-                        "  [-f]                         # freeze trace for each new max latency\n");
-                exit(2);
-        }
-
-    /* set defaults for parallel port */
-    if (port_type == 1 && !ioaddr_set)
-        port_ioaddr = 0x378;
-
-    if (iopl(3) < 0) {
-        fprintf(stderr, "irqbench: superuser permissions required\n");
-        exit(1);
-    }
-    mlockall(MCL_CURRENT | MCL_FUTURE);
-
-    switch (port_type) {
-        case SERPORT:
-            toggle = MCR_OUT2;
-            inb(MSR(port_ioaddr));
-            break;
-
-        case PARPORT:
-            outb(CTRL_INIT, CTRL(port_ioaddr));
-            break;
-
-        default:
-            fprintf(stderr, "irqbench: invalid port type\n");
-            exit(1);
-    }
-
-    period = ns2tsc(period);
-
-    printf("Port type:     %s\n"
-           "Port address:  0x%lx\n\n",
-           (port_type == SERPORT) ? "serial" : "parallel", port_ioaddr);
-
-    printf("Waiting on target...\n");
-
-    while (1)
-        if (port_type ==  SERPORT) {
-            toggle ^= MCR_RTS;
-            outb(toggle, MCR(port_ioaddr));
-            usleep(100000);
-            if ((inb(MSR(port_ioaddr)) & MSR_DELTA) != 0)
-                break;
-        } else {
-            int status = inb(STAT(port_ioaddr));
-
-            outb(0x08, DATA(port_ioaddr));
-            outb(0x00, DATA(port_ioaddr));
-            usleep(100000);
-            if (inb(STAT(port_ioaddr)) != status)
-                break;
-        }
-
-    printf("Warming up...\n");
-
-    while (!terminate) {
-        long long loop_timeout = rdtsc() + ns2tsc(1000000000LL);
-        long loop_avg = 0;
-        int inner_loops = 0;
-
-        while (rdtsc() < loop_timeout) {
-            long lat;
-
-            __asm__ __volatile__("cli");
-
-            if (port_type ==  SERPORT) {
-                start = rdtsc();
-
-                toggle ^= MCR_RTS;
-                outb(toggle, MCR(port_ioaddr));
-
-                timeout = start + period * 100;
-                while (((inb(MSR(port_ioaddr)) & MSR_DELTA) == 0) &&
-                       (rdtsc() < timeout));
-
-                delay = rdtsc() - start;
-            } else {
-                int status = inb(STAT(port_ioaddr));
-
-                outb(0x08, DATA(port_ioaddr));
-
-                start = rdtsc();
-
-                outb(0x00, DATA(port_ioaddr));
-
-                timeout = start + period * 100;
-                while ((inb(STAT(port_ioaddr)) == status) &&
-                       (rdtsc() < timeout));
-
-                delay = rdtsc() - start;
-            }
-
-            if (!warmup) {
-                lat = tsc2ns(delay);
-
-                loop_avg += lat;
-                if (lat < min_lat)
-                    min_lat = lat;
-                if (lat > max_lat) {
-                    max_lat = lat;
-                    if (trigger_trace) {
-                        if (port_type == SERPORT) {
-                            toggle ^= MCR_DTR;
-                            outb(toggle, MCR(port_ioaddr));
-                        } else {
-                            outb(0x18, DATA(port_ioaddr));
-                            outb(0x10, DATA(port_ioaddr));
-                        }
-                    }
-                }
-            }
-
-            __asm__ __volatile__("sti");
-
-            inner_loops++;
-
-            while (rdtsc() < start + period);
-        }
-
-        count += inner_loops;
-
-        if (!warmup && !terminate) {
-            loop_avg /= inner_loops;
-
-            printf("%llu: %.3f / %.3f / %.3f us\n", count,
-                ((double)min_lat) / 1000.0, ((double)loop_avg) / 1000.0,
-                ((double)max_lat) / 1000.0);
-
-            avg_lat += loop_avg;
-            outer_loops++;
-        } else
-            warmup = 0;
-    }
-
-    avg_lat /= outer_loops;
-    printf("---\n%llu: %.3f / %.3f / %.3f us\n", count,
-           ((double)min_lat) / 1000.0, ((double)avg_lat) / 1000.0,
-           ((double)max_lat) / 1000.0);
-
-    return 0;
+	int ioaddr_set = 0;
+	unsigned long long count = 1;
+	int c;
+
+	signal(SIGINT, sighand);
+	signal(SIGTERM, sighand);
+	signal(SIGHUP, sighand);
+	signal(SIGALRM, sighand);
+
+	calibrate_tsc();
+
+	while ((c = getopt(argc, argv, "p:T:o:a:f")) != EOF)
+		switch (c) {
+		case 'p':
+			period = atoi(optarg) * 1000;
+			break;
+
+		case 'T':
+			alarm(atoi(optarg));
+			break;
+
+		case 'o':
+			port_type = atoi(optarg);
+			break;
+
+		case 'a':
+			port_ioaddr = strtol(optarg, NULL, (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
+			ioaddr_set = 1;
+			break;
+
+		case 'f':
+			trigger_trace = 1;
+			break;
+
+		default:
+			fprintf(stderr, "usage: irqbench [options]\n"
+				"  [-p <period_us>]             # signal period, default=100 us\n"
+				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
+				"  [-o <port_type>]             # 0=serial (default), 1=parallel\n"
+				"  [-a <port_io_address>]       # default=0x3f8/0x378\n"
+				"  [-f]                         # freeze trace for each new max latency\n");
+			exit(2);
+		}
+
+	/* set defaults for parallel port */
+	if (port_type == 1 && !ioaddr_set)
+		port_ioaddr = 0x378;
+
+	if (iopl(3) < 0) {
+		fprintf(stderr, "irqbench: superuser permissions required\n");
+		exit(1);
+	}
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
+	switch (port_type) {
+	case SERPORT:
+		toggle = MCR_OUT2;
+		inb(MSR(port_ioaddr));
+		break;
+
+	case PARPORT:
+		outb(CTRL_INIT, CTRL(port_ioaddr));
+		break;
+
+	default:
+		fprintf(stderr, "irqbench: invalid port type\n");
+		exit(1);
+	}
+
+	period = ns2tsc(period);
+
+	printf("Port type:     %s\n"
+	       "Port address:  0x%lx\n\n",
+	       (port_type == SERPORT) ? "serial" : "parallel", port_ioaddr);
+
+	printf("Waiting on target...\n");
+
+	while (1)
+		if (port_type ==  SERPORT) {
+			toggle ^= MCR_RTS;
+			outb(toggle, MCR(port_ioaddr));
+			usleep(100000);
+			if ((inb(MSR(port_ioaddr)) & MSR_DELTA) != 0)
+				break;
+		} else {
+			int status = inb(STAT(port_ioaddr));
+
+			outb(0x08, DATA(port_ioaddr));
+			outb(0x00, DATA(port_ioaddr));
+			usleep(100000);
+			if (inb(STAT(port_ioaddr)) != status)
+				break;
+		}
+
+	printf("Warming up...\n");
+
+	while (!terminate) {
+		long long loop_timeout = rdtsc() + ns2tsc(1000000000LL);
+		int inner_loops = 0;
+
+		loop_avg = 0;
+		while (rdtsc() < loop_timeout) {
+			do_inner_loop();
+			inner_loops++;
+		}
+
+		count += inner_loops;
+
+		if (!warmup && !terminate) {
+			loop_avg /= inner_loops;
+
+			printf("%llu: %.3f / %.3f / %.3f us\n", count,
+			       ((double)min_lat) / 1000.0,
+			       ((double)loop_avg) / 1000.0,
+			       ((double)max_lat) / 1000.0);
+
+			avg_lat += loop_avg;
+			outer_loops++;
+		} else
+			warmup = 0;
+	}
+
+	avg_lat /= outer_loops;
+	printf("---\n%llu: %.3f / %.3f / %.3f us\n", count,
+	       ((double)min_lat) / 1000.0, ((double)avg_lat) / 1000.0,
+	       ((double)max_lat) / 1000.0);
+
+	return 0;
 }
diff --git a/src/testsuite/irqbench/irqloop.c b/src/testsuite/irqbench/irqloop.c
index e97123f..3b4de4f 100644
--- a/src/testsuite/irqbench/irqloop.c
+++ b/src/testsuite/irqbench/irqloop.c
@@ -29,165 +29,170 @@
 static int benchdev;
 static int terminate;
 
-void *irq_thread(void *arg)
+static void *irq_thread(void *arg)
 {
-    struct sched_param param = { .sched_priority = (long)arg };
+	struct sched_param param = { .sched_priority = (long)arg };
 
-    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
 
-    while (1) {
-        if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_WAIT_IRQ) ||
-            ioctl(benchdev, RTTST_RTIOC_IRQBENCH_REPLY_IRQ))
-            break;
-    }
+	while (1) {
+		if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_WAIT_IRQ) ||
+		    ioctl(benchdev, RTTST_RTIOC_IRQBENCH_REPLY_IRQ))
+			break;
+	}
 
-    param.sched_priority = 0;
-    pthread_setschedparam(pthread_self(), SCHED_OTHER, &param);
+	param.sched_priority = 0;
+	pthread_setschedparam(pthread_self(), SCHED_OTHER, &param);
 
-    return NULL;
+	return NULL;
 }
 
-
-void sighand(int sig)
+static void sighand(int sig)
 {
-    terminate = 1;
+	terminate = 1;
 }
 
-
 int main(int argc, char *argv[])
 {
-    const char *mode_name[] =
-        { "user-space task", "kernel-space task",
-          "IRQ handler", "hard-IRQ handler" };
-    const char *port_type_name[] = { "serial", "parallel" };
-    char devname[RTDM_MAX_DEVNAME_LEN];
-    int benchdev_no = 0;
-    struct rttst_irqbench_config config = {
-        mode:               RTTST_IRQBENCH_USER_TASK,
-        priority:           sched_get_priority_max(SCHED_FIFO),
-        calibration_loops:  0,
-        port_type:          RTTST_IRQBENCH_SERPORT,
-        port_ioaddr:        0x3f8,
-        port_irq:           4
-    };
-    struct rttst_irqbench_stats stats;
-    unsigned long long last_received = 0;
-    pthread_t thr;
-    int ioaddr_set = 0;
-    int irq_set = 0;
-    int c;
-    int timeout = 10;
-
-
-    while ((c = getopt(argc,argv,"D:t:P:o:a:i:")) != EOF)
-        switch (c) {
-            case 'D':
-                benchdev_no = atoi(optarg);
-                break;
-
-            case 't':
-                config.mode = atoi(optarg);
-                break;
-
-            case 'P':
-                config.priority = atoi(optarg);
-                break;
-
-            case 'o':
-                config.port_type = atoi(optarg);
-                break;
-
-            case 'a':
-                config.port_ioaddr = strtol(optarg, NULL,
-                    (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
-                ioaddr_set = 1;
-                break;
-
-            case 'i':
-                config.port_irq = atoi(optarg);
-                irq_set = 1;
-                break;
-
-            default:
-                fprintf(stderr, "usage: irqloop [options]\n"
-                        "  [-D <testing_device_no>] # number of testing device, default=0\n"
-                        "  [-t <test_mode>]         # 0=user task (default), 1=kernel task,\n"
-                        "                           # 2=IRQ handler, 3=hard-IRQ handler\n"
-                        "  [-P <priority>]          # task priority (test mode 0 and 1 only)\n"
-                        "  [-o <port_type>]         # 0=serial (default), 1=parallel\n"
-                        "  [-a <port_io_address>]   # default=0x3f8/0x378\n"
-                        "  [-i <port_irq>]          # default=4/7\n");
-                exit(2);
-        }
-
-    /* set defaults for parallel port */
-    if (config.port_type == 1) {
-        if (!ioaddr_set)
-            config.port_ioaddr = 0x378;
-        if (!irq_set)
-            config.port_irq = 0x7;
-    }
-
-    signal(SIGINT, sighand);
-    signal(SIGTERM, sighand);
-    signal(SIGHUP, sighand);
-
-    mlockall(MCL_CURRENT|MCL_FUTURE);
-
-    snprintf(devname, RTDM_MAX_DEVNAME_LEN, "/dev/rttest%d", benchdev_no);
-    benchdev = open(devname, O_RDWR);
-    if (benchdev < 0) {
-        perror("irqloop: failed to open benchmark device");
-        fprintf(stderr, "(modprobe xeno_irqbench?)\n");
-        return 1;
-    }
-
-    if (config.mode == RTTST_IRQBENCH_USER_TASK) {
-        pthread_attr_t attr;
-
-        pthread_attr_init(&attr);
-        pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
-
-        pthread_create(&thr, &attr, irq_thread, (void *)(long)config.priority);
-    }
-
-    if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)) {
-        perror("irqloop: error starting test");
-        goto cleanup;
-    }
-
-    printf("Test mode:    %s\n"
-           "Port type:    %s\n"
-           "Port address: 0x%lx\n"
-           "Port IRQ:     %d\n\n\n\n",
-           mode_name[config.mode], port_type_name[config.port_type],
-           config.port_ioaddr, config.port_irq);
-
-    while (!terminate) {
-        if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_GET_STATS, &stats) < 0) {
-            perror("irqloop: error reading stats");
-            break;
-        }
-
-        if ((last_received > 0) && (stats.irqs_received == last_received)) {
-            if (--timeout == 0)
-                break; /* timed out */
-        } else
-            timeout = 10;
-        last_received = stats.irqs_received;
-
-        printf("\033[2AReceived IRQs:     %lld\nAcknowledged IRQs: %lld\n",
-                stats.irqs_received, stats.irqs_acknowledged);
-        usleep(250000);
-    }
-
-    ioctl(benchdev, RTTST_RTIOC_IRQBENCH_STOP);
-
-  cleanup:
-    close(benchdev);
-    if (config.mode == RTTST_IRQBENCH_USER_TASK) {
-        pthread_cancel(thr);
-        pthread_join(thr, NULL);
-    }
-    return 0;
+	const char *mode_name[] = {
+		[RTTST_IRQBENCH_USER_TASK]	= "user-space task",
+		[RTTST_IRQBENCH_KERNEL_TASK]	= "kernel-space task",
+		[RTTST_IRQBENCH_HANDLER]	= "IRQ handler",
+		[RTTST_IRQBENCH_HARD_IRQ]	= "hard-IRQ handler",
+	};
+	const char *port_type_name[] = {
+		[RTTST_IRQBENCH_SERPORT]	= "serial",
+		[RTTST_IRQBENCH_PARPORT]	= "parallel",
+	};
+	char devname[RTDM_MAX_DEVNAME_LEN];
+	int benchdev_no = 0;
+	struct rttst_irqbench_config config = {
+		.mode			= RTTST_IRQBENCH_USER_TASK,
+		.priority		= sched_get_priority_max(SCHED_FIFO),
+		.calibration_loops	= 0,
+		.port_type		= RTTST_IRQBENCH_SERPORT,
+		.port_ioaddr		= 0x3f8,
+		.port_irq		= 4
+	};
+	struct rttst_irqbench_stats stats;
+	unsigned long long last_received = 0;
+	pthread_t thr;
+	int ioaddr_set = 0;
+	int irq_set = 0;
+	int c;
+	int timeout = 10;
+
+	while ((c = getopt(argc, argv, "D:t:P:o:a:i:")) != EOF)
+		switch (c) {
+		case 'D':
+			benchdev_no = atoi(optarg);
+			break;
+
+		case 't':
+			config.mode = atoi(optarg);
+			break;
+
+		case 'P':
+			config.priority = atoi(optarg);
+			break;
+
+		case 'o':
+			config.port_type = atoi(optarg);
+			break;
+
+		case 'a':
+			config.port_ioaddr = strtol(optarg, NULL, (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
+			ioaddr_set = 1;
+			break;
+
+		case 'i':
+			config.port_irq = atoi(optarg);
+			irq_set = 1;
+			break;
+
+		default:
+			fprintf(stderr, "usage: irqloop [options]\n"
+				"  [-D <testing_device_no>] # number of testing device, default=0\n"
+				"  [-t <test_mode>]         # 0=user task (default), 1=kernel task,\n"
+				"                           # 2=IRQ handler, 3=hard-IRQ handler\n"
+				"  [-P <priority>]          # task priority (test mode 0 and 1 only)\n"
+				"  [-o <port_type>]         # 0=serial (default), 1=parallel\n"
+				"  [-a <port_io_address>]   # default=0x3f8/0x378\n"
+				"  [-i <port_irq>]          # default=4/7\n");
+			exit(2);
+		}
+
+	/* set defaults for parallel port */
+	if (config.port_type == 1) {
+		if (!ioaddr_set)
+			config.port_ioaddr = 0x378;
+		if (!irq_set)
+			config.port_irq = 0x7;
+	}
+
+	signal(SIGINT, sighand);
+	signal(SIGTERM, sighand);
+	signal(SIGHUP, sighand);
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	snprintf(devname, RTDM_MAX_DEVNAME_LEN, "/dev/rttest%d", benchdev_no);
+	benchdev = open(devname, O_RDWR);
+	if (benchdev < 0) {
+		perror("irqloop: failed to open benchmark device");
+		fprintf(stderr, "(modprobe xeno_irqbench?)\n");
+		return 1;
+	}
+
+	if (config.mode == RTTST_IRQBENCH_USER_TASK) {
+		pthread_attr_t attr;
+
+		pthread_attr_init(&attr);
+		pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
+
+		pthread_create(&thr, &attr, irq_thread, (void *)(long)config.priority);
+	}
+
+	if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)) {
+		perror("irqloop: error starting test");
+		goto cleanup;
+	}
+
+	printf("Test mode:    %s\n"
+	       "Port type:    %s\n"
+	       "Port address: 0x%lx\n"
+	       "Port IRQ:     %d\n\n\n\n",
+	       mode_name[config.mode], port_type_name[config.port_type],
+	       config.port_ioaddr, config.port_irq);
+
+	while (!terminate) {
+		if (ioctl(benchdev, RTTST_RTIOC_IRQBENCH_GET_STATS,
+			  &stats) < 0) {
+			perror("irqloop: error reading stats");
+			break;
+		}
+
+		if ((last_received > 0) &&
+		    (stats.irqs_received == last_received)) {
+			if (--timeout == 0)
+				break; /* timed out */
+		} else
+			timeout = 10;
+		last_received = stats.irqs_received;
+
+		printf("\033[2AReceived IRQs:     %lld\n"
+		       "Acknowledged IRQs: %lld\n",
+		       stats.irqs_received, stats.irqs_acknowledged);
+		usleep(250000);
+	}
+
+	ioctl(benchdev, RTTST_RTIOC_IRQBENCH_STOP);
+
+cleanup:
+	close(benchdev);
+	if (config.mode == RTTST_IRQBENCH_USER_TASK) {
+		pthread_cancel(thr);
+		pthread_join(thr, NULL);
+	}
+	return 0;
 }
-- 
1.6.0.2


