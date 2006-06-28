From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17570.29185.754625.871443@domain.hid>
Date: Wed, 28 Jun 2006 14:11:45 +0200
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
In-Reply-To: <20060626172120.322015000@domain.hid>
References: <20060626172116.019532000@domain.hid> <20060626172120.322015000@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

jan.kiszka@domain.hid wrote:
 > Index: xenomai/src/testsuite/irqbench/irqbench.c
 > ===================================================================
 > --- /dev/null
 > +++ xenomai/src/testsuite/irqbench/irqbench.c
 > @@ -0,0 +1,301 @@
 > +/*
 > + * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
 > + *
 > + * Xenomai is free software; you can redistribute it and/or modify it
 > + * under the terms of the GNU General Public License as published by
 > + * the Free Software Foundation; either version 2 of the License, or
 > + * (at your option) any later version.
 > + *
 > + * Xenomai is distributed in the hope that it will be useful, but
 > + * WITHOUT ANY WARRANTY; without even the implied warranty of
 > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 > + * General Public License for more details.
 > + *
 > + * You should have received a copy of the GNU General Public License
 > + * along with Xenomai; if not, write to the Free Software Foundation,
 > + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 > + */
 > +
 > +#include <limits.h>
 > +#include <stdio.h>
 > +#include <stdlib.h>
 > +#include <string.h>
 > +#include <signal.h>
 > +#include <unistd.h>
 > +#include <sys/io.h>
 > +#include <sys/mman.h>
 > +
 > +
 > +#define SERPORT                 0
 > +#define PARPORT                 1
 > +
 > +/* --- Serial port --- */
 > +
 > +#define MCR_DTR                 0x01
 > +#define MCR_RTS                 0x02
 > +#define MCR_OUT2                0x08
 > +
 > +#define MSR_DELTA               0x0F
 > +
 > +#define LCR(base) (base + 3) /* Line Control Register */
 > +#define MCR(base) (base + 4) /* Modem Control Register */
 > +#define LSR(base) (base + 5) /* Line Status Register */
 > +#define MSR(base) (base + 6) /* Modem Status Register */
 > +
 > +/* --- Parallel port --- */
 > +
 > +#define CTRL_INIT               0x04
 > +
 > +#define STAT_STROBE             0x10
 > +
 > +#define DATA(base) (base + 0) /* Data register */
 > +#define STAT(base) (base + 1) /* Status register */
 > +#define CTRL(base) (base + 2) /* Control register */
 > +
 > +double tsc2ns_scale;
 > +long long min_lat = LLONG_MAX;
 > +long long max_lat = LLONG_MIN;
 > +long long avg_lat = 0;
 > +long outer_loops = 0;
 > +int warmup = 1;
 > +
 > +static inline long long rdtsc(void)
 > +{
 > +    unsigned long long tsc;
 > +
 > +    __asm__ __volatile__("rdtsc" : "=A" (tsc));
 > +    return tsc;
 > +}
 > +
 > +
 > +static long tsc2ns(long long tsc)
 > +{
 > +    if ((tsc > LONG_MAX) || (tsc < LONG_MIN)) {
 > +        fprintf(stderr, "irqbench: overflow (%lld ns)!\n",
 > +                (long long)(tsc2ns_scale * (double)tsc));
 > +        exit(2);
 > +    }
 > +    return (long)(tsc2ns_scale * (double)tsc);
 > +}
 > +
 > +
 > +static inline long long ns2tsc(long long ns)
 > +{
 > +    return (long long)(((double)ns) / tsc2ns_scale);
 > +}
 > +
 > +
 > +void calibrate_tsc(void)
 > +{
 > +    FILE *proc;
 > +    char *lineptr = NULL;
 > +    size_t len;
 > +    double cpu_mhz;
 > +
 > +    proc = fopen("/proc/cpuinfo", "r");
 > +    if (proc == NULL) {
 > +        perror("irqbench: Unable to open /proc/cpuinfo");
 > +        exit(1);
 > +    }
 > +
 > +    while (getline(&lineptr, &len, proc) != -1)
 > +        if (strncmp(lineptr, "cpu MHz", 7) == 0) {
 > +            sscanf(strchr(lineptr, ':') + 1, "%lf", &cpu_mhz);
 > +            break;
 > +        }
 > +
 > +    if (lineptr)
 > +        free(lineptr);
 > +    fclose(proc);
 > +
 > +    printf("CPU frequency: %.3lf MHz\n", cpu_mhz);
 > +
 > +    tsc2ns_scale = 1000.0 / cpu_mhz;
 > +}
 > +
 > +
 > +void sighand(int signal)
 > +{
 > +    if (!warmup) {
 > +        avg_lat /= outer_loops;
 > +        printf("---\n%.3f / %.3f / %.3f us\n",
 > +               ((double)min_lat) / 1000.0, ((double)avg_lat) / 1000.0,
 > +               ((double)max_lat) / 1000.0);
 > +    }
 > +    exit(0);
 > +}
 > +
 > +
 > +int main(int argc, char *argv[])
 > +{
 > +    int             port_type   = SERPORT;
 > +    unsigned long   port_ioaddr = 0x3F8;
 > +    long long       period = 100000;
 > +    long long       timeout;
 > +    long long       start, delay;
 > +    unsigned int    toggle;
 > +    int             trigger_trace = 0;
 > +    int             c;
 > +
 > +
 > +    signal(SIGINT, sighand);
 > +    signal(SIGTERM, sighand);
 > +    signal(SIGHUP, sighand);
 > +    signal(SIGALRM, sighand);
 > +
 > +    calibrate_tsc();
 > +
 > +    while ((c = getopt(argc,argv,"p:T:o:a:f")) != EOF)
 > +        switch (c) {
 > +            case 'p':
 > +                period = atoi(optarg) * 1000;
 > +                break;
 > +
 > +            case 'T':
 > +                alarm(atoi(optarg));
 > +                break;
 > +
 > +            case 'o':
 > +                port_type = atoi(optarg);
 > +                break;
 > +
 > +            case 'a':
 > +                port_ioaddr = strtol(optarg, NULL,
 > +                    (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
 > +                break;
 > +
 > +            case 'f':
 > +                trigger_trace = 1;
 > +                break;
 > +
 > +            default:
 > +                fprintf(stderr, "usage: irqbench [options]\n"
 > +                        "  [-p <period_us>]             # signal period, default=100 us\n"
 > +                        "  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
 > +                        "  [-o <port_type>]             # 0=serial (default), 1=parallel\n"
 > +                        "  [-a <port_io_address>]       # default=0x3f8\n"
 > +                        "  [-f]                         # freeze trace for each new max latency\n");
 > +                exit(2);
 > +        }
 > +
 > +    if (iopl(3) < 0) {
 > +        fprintf(stderr, "irqbench: superuser permissions required\n");
 > +        exit(1);
 > +    }
 > +    mlockall(MCL_CURRENT | MCL_FUTURE);
 > +
 > +    switch (port_type) {
 > +        case SERPORT:
 > +            toggle = MCR_OUT2;
 > +            inb(MSR(port_ioaddr));
 > +            break;
 > +
 > +        case PARPORT:
 > +            toggle = 0xAA;
 > +            outb(0xAA, DATA(port_ioaddr));
 > +            outb(CTRL_INIT, CTRL(port_ioaddr));
 > +            break;
 > +
 > +        default:
 > +            fprintf(stderr, "irqbench: invalid port type\n");
 > +            exit(1);
 > +    }
 > +
 > +    period = ns2tsc(period);
 > +
 > +    printf("Port type:     %s\n"
 > +           "Port address:  0x%lx\n\n",
 > +           (port_type == SERPORT) ? "serial" : "parallel", port_ioaddr);
 > +
 > +    printf("Waiting on target...\n");
 > +
 > +    while (1)
 > +        if (port_type ==  SERPORT) {
 > +            toggle ^= MCR_RTS;
 > +            outb(toggle, MCR(port_ioaddr));
 > +            usleep(100000);
 > +            if ((inb(MSR(port_ioaddr)) & MSR_DELTA) != 0)
 > +                break;
 > +        } else {
 > +            int status = inb(STAT(port_ioaddr));
 > +
 > +            toggle ^= 0xFF;
 > +            outb(toggle, DATA(port_ioaddr));
 > +            if (inb(STAT(port_ioaddr)) != status)
 > +                break;
 > +        }
 > +
 > +    printf("Warming up...\n");
 > +
 > +    while (1) {
 > +        long long loop_timeout = rdtsc() + ns2tsc(1000000000LL);
 > +        long loop_avg = 0;
 > +        int inner_loops;
 > +
 > +        for (inner_loops = 0; rdtsc() < loop_timeout; inner_loops++) {
 > +            long lat;
 > +
 > +            __asm__ __volatile__("cli");
 > +
 > +            if (port_type ==  SERPORT) {
 > +                start = rdtsc();
 > +
 > +                toggle ^= MCR_RTS;
 > +                outb(toggle, MCR(port_ioaddr));
 > +
 > +                timeout = start + period * 100;
 > +                while (((inb(MSR(port_ioaddr)) & MSR_DELTA) == 0) &&
 > +                       (rdtsc() < timeout));
 > +
 > +                delay = rdtsc() - start;
 > +            } else {
 > +                int status = inb(STAT(port_ioaddr));
 > +
 > +                start = rdtsc();
 > +
 > +                toggle ^= 0xFF;
 > +                outb(toggle, DATA(port_ioaddr));
 > +
 > +                timeout = start + period * 100;
 > +                while ((inb(STAT(port_ioaddr)) == status) &&
 > +                       (rdtsc() < timeout));
 > +
 > +                delay = rdtsc() - start;
 > +            }
 > +
 > +            if (!warmup) {
 > +                lat = tsc2ns(delay);
 > +
 > +                loop_avg += lat;
 > +                if (lat < min_lat)
 > +                    min_lat = lat;
 > +                if (lat > max_lat) {
 > +                    max_lat = lat;
 > +                    if (trigger_trace) {
 > +                        if (port_type == SERPORT) {
 > +                            toggle ^= MCR_DTR;
 > +                            outb(toggle, MCR(port_ioaddr));
 > +                        } else {
 > +                            // todo
 > +                        }
 > +                    }
 > +                }
 > +            }
 > +
 > +            __asm__ __volatile__("sti");
 > +
 > +            while (rdtsc() < start + period);
 > +        }
 > +        if (!warmup) {
 > +            loop_avg /= inner_loops;
 > +
 > +            printf("%.3f / %.3f / %.3f us\n",
 > +                ((double)min_lat) / 1000.0, ((double)loop_avg) / 1000.0,
 > +                ((double)max_lat) / 1000.0);
 > +
 > +            avg_lat += loop_avg;
 > +            outer_loops++;
 > +        } else
 > +            warmup = 0;
 > +    }
 > +}

Is there no way to make this code easier to port for example by using
native or posix services for timings measurement and by abstracting the
non portable part and moving them to include/asm-i386 ?

Also note that calling printf from a signal handler risk deadlocking if
the signal handler get called on the return path of the write call that
take place in the middle of a printf call on the main thread.

-- 


					    Gilles Chanteperdrix.

