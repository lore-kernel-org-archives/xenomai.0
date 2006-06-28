Message-ID: <44A275DE.5080500@domain.hid>
Date: Wed, 28 Jun 2006 14:28:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
References: <20060626172116.019532000@domain.hid>	<20060626172120.322015000@domain.hid>
	<17570.29185.754625.871443@domain.hid>
In-Reply-To: <17570.29185.754625.871443@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig600F1A9555C1645AD07D8474"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig600F1A9555C1645AD07D8474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> jan.kiszka@domain.hid wrote:
>  > Index: xenomai/src/testsuite/irqbench/irqbench.c
>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  > --- /dev/null
>  > +++ xenomai/src/testsuite/irqbench/irqbench.c
>  > @@ -0,0 +1,301 @@
>  > +/*
>  > + * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
>  > + *
>  > + * Xenomai is free software; you can redistribute it and/or modify =
it
>  > + * under the terms of the GNU General Public License as published b=
y
>  > + * the Free Software Foundation; either version 2 of the License, o=
r
>  > + * (at your option) any later version.
>  > + *
>  > + * Xenomai is distributed in the hope that it will be useful, but
>  > + * WITHOUT ANY WARRANTY; without even the implied warranty of
>  > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
>  > + * General Public License for more details.
>  > + *
>  > + * You should have received a copy of the GNU General Public Licens=
e
>  > + * along with Xenomai; if not, write to the Free Software Foundatio=
n,
>  > + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>  > + */
>  > +
>  > +#include <limits.h>
>  > +#include <stdio.h>
>  > +#include <stdlib.h>
>  > +#include <string.h>
>  > +#include <signal.h>
>  > +#include <unistd.h>
>  > +#include <sys/io.h>
>  > +#include <sys/mman.h>
>  > +
>  > +
>  > +#define SERPORT                 0
>  > +#define PARPORT                 1
>  > +
>  > +/* --- Serial port --- */
>  > +
>  > +#define MCR_DTR                 0x01
>  > +#define MCR_RTS                 0x02
>  > +#define MCR_OUT2                0x08
>  > +
>  > +#define MSR_DELTA               0x0F
>  > +
>  > +#define LCR(base) (base + 3) /* Line Control Register */
>  > +#define MCR(base) (base + 4) /* Modem Control Register */
>  > +#define LSR(base) (base + 5) /* Line Status Register */
>  > +#define MSR(base) (base + 6) /* Modem Status Register */
>  > +
>  > +/* --- Parallel port --- */
>  > +
>  > +#define CTRL_INIT               0x04
>  > +
>  > +#define STAT_STROBE             0x10
>  > +
>  > +#define DATA(base) (base + 0) /* Data register */
>  > +#define STAT(base) (base + 1) /* Status register */
>  > +#define CTRL(base) (base + 2) /* Control register */
>  > +
>  > +double tsc2ns_scale;
>  > +long long min_lat =3D LLONG_MAX;
>  > +long long max_lat =3D LLONG_MIN;
>  > +long long avg_lat =3D 0;
>  > +long outer_loops =3D 0;
>  > +int warmup =3D 1;
>  > +
>  > +static inline long long rdtsc(void)
>  > +{
>  > +    unsigned long long tsc;
>  > +
>  > +    __asm__ __volatile__("rdtsc" : "=3DA" (tsc));
>  > +    return tsc;
>  > +}
>  > +
>  > +
>  > +static long tsc2ns(long long tsc)
>  > +{
>  > +    if ((tsc > LONG_MAX) || (tsc < LONG_MIN)) {
>  > +        fprintf(stderr, "irqbench: overflow (%lld ns)!\n",
>  > +                (long long)(tsc2ns_scale * (double)tsc));
>  > +        exit(2);
>  > +    }
>  > +    return (long)(tsc2ns_scale * (double)tsc);
>  > +}
>  > +
>  > +
>  > +static inline long long ns2tsc(long long ns)
>  > +{
>  > +    return (long long)(((double)ns) / tsc2ns_scale);
>  > +}
>  > +
>  > +
>  > +void calibrate_tsc(void)
>  > +{
>  > +    FILE *proc;
>  > +    char *lineptr =3D NULL;
>  > +    size_t len;
>  > +    double cpu_mhz;
>  > +
>  > +    proc =3D fopen("/proc/cpuinfo", "r");
>  > +    if (proc =3D=3D NULL) {
>  > +        perror("irqbench: Unable to open /proc/cpuinfo");
>  > +        exit(1);
>  > +    }
>  > +
>  > +    while (getline(&lineptr, &len, proc) !=3D -1)
>  > +        if (strncmp(lineptr, "cpu MHz", 7) =3D=3D 0) {
>  > +            sscanf(strchr(lineptr, ':') + 1, "%lf", &cpu_mhz);
>  > +            break;
>  > +        }
>  > +
>  > +    if (lineptr)
>  > +        free(lineptr);
>  > +    fclose(proc);
>  > +
>  > +    printf("CPU frequency: %.3lf MHz\n", cpu_mhz);
>  > +
>  > +    tsc2ns_scale =3D 1000.0 / cpu_mhz;
>  > +}
>  > +
>  > +
>  > +void sighand(int signal)
>  > +{
>  > +    if (!warmup) {
>  > +        avg_lat /=3D outer_loops;
>  > +        printf("---\n%.3f / %.3f / %.3f us\n",
>  > +               ((double)min_lat) / 1000.0, ((double)avg_lat) / 1000=
=2E0,
>  > +               ((double)max_lat) / 1000.0);
>  > +    }
>  > +    exit(0);
>  > +}
>  > +
>  > +
>  > +int main(int argc, char *argv[])
>  > +{
>  > +    int             port_type   =3D SERPORT;
>  > +    unsigned long   port_ioaddr =3D 0x3F8;
>  > +    long long       period =3D 100000;
>  > +    long long       timeout;
>  > +    long long       start, delay;
>  > +    unsigned int    toggle;
>  > +    int             trigger_trace =3D 0;
>  > +    int             c;
>  > +
>  > +
>  > +    signal(SIGINT, sighand);
>  > +    signal(SIGTERM, sighand);
>  > +    signal(SIGHUP, sighand);
>  > +    signal(SIGALRM, sighand);
>  > +
>  > +    calibrate_tsc();
>  > +
>  > +    while ((c =3D getopt(argc,argv,"p:T:o:a:f")) !=3D EOF)
>  > +        switch (c) {
>  > +            case 'p':
>  > +                period =3D atoi(optarg) * 1000;
>  > +                break;
>  > +
>  > +            case 'T':
>  > +                alarm(atoi(optarg));
>  > +                break;
>  > +
>  > +            case 'o':
>  > +                port_type =3D atoi(optarg);
>  > +                break;
>  > +
>  > +            case 'a':
>  > +                port_ioaddr =3D strtol(optarg, NULL,
>  > +                    (strncmp(optarg, "0x", 2) =3D=3D 0) ? 16 : 10);=

>  > +                break;
>  > +
>  > +            case 'f':
>  > +                trigger_trace =3D 1;
>  > +                break;
>  > +
>  > +            default:
>  > +                fprintf(stderr, "usage: irqbench [options]\n"
>  > +                        "  [-p <period_us>]             # signal pe=
riod, default=3D100 us\n"
>  > +                        "  [-T <test_duration_seconds>] # default=3D=
0, so ^C to end\n"
>  > +                        "  [-o <port_type>]             # 0=3Dseria=
l (default), 1=3Dparallel\n"
>  > +                        "  [-a <port_io_address>]       # default=3D=
0x3f8\n"
>  > +                        "  [-f]                         # freeze tr=
ace for each new max latency\n");
>  > +                exit(2);
>  > +        }
>  > +
>  > +    if (iopl(3) < 0) {
>  > +        fprintf(stderr, "irqbench: superuser permissions required\n=
");
>  > +        exit(1);
>  > +    }
>  > +    mlockall(MCL_CURRENT | MCL_FUTURE);
>  > +
>  > +    switch (port_type) {
>  > +        case SERPORT:
>  > +            toggle =3D MCR_OUT2;
>  > +            inb(MSR(port_ioaddr));
>  > +            break;
>  > +
>  > +        case PARPORT:
>  > +            toggle =3D 0xAA;
>  > +            outb(0xAA, DATA(port_ioaddr));
>  > +            outb(CTRL_INIT, CTRL(port_ioaddr));
>  > +            break;
>  > +
>  > +        default:
>  > +            fprintf(stderr, "irqbench: invalid port type\n");
>  > +            exit(1);
>  > +    }
>  > +
>  > +    period =3D ns2tsc(period);
>  > +
>  > +    printf("Port type:     %s\n"
>  > +           "Port address:  0x%lx\n\n",
>  > +           (port_type =3D=3D SERPORT) ? "serial" : "parallel", port=
_ioaddr);
>  > +
>  > +    printf("Waiting on target...\n");
>  > +
>  > +    while (1)
>  > +        if (port_type =3D=3D  SERPORT) {
>  > +            toggle ^=3D MCR_RTS;
>  > +            outb(toggle, MCR(port_ioaddr));
>  > +            usleep(100000);
>  > +            if ((inb(MSR(port_ioaddr)) & MSR_DELTA) !=3D 0)
>  > +                break;
>  > +        } else {
>  > +            int status =3D inb(STAT(port_ioaddr));
>  > +
>  > +            toggle ^=3D 0xFF;
>  > +            outb(toggle, DATA(port_ioaddr));
>  > +            if (inb(STAT(port_ioaddr)) !=3D status)
>  > +                break;
>  > +        }
>  > +
>  > +    printf("Warming up...\n");
>  > +
>  > +    while (1) {
>  > +        long long loop_timeout =3D rdtsc() + ns2tsc(1000000000LL);
>  > +        long loop_avg =3D 0;
>  > +        int inner_loops;
>  > +
>  > +        for (inner_loops =3D 0; rdtsc() < loop_timeout; inner_loops=
++) {
>  > +            long lat;
>  > +
>  > +            __asm__ __volatile__("cli");
>  > +
>  > +            if (port_type =3D=3D  SERPORT) {
>  > +                start =3D rdtsc();
>  > +
>  > +                toggle ^=3D MCR_RTS;
>  > +                outb(toggle, MCR(port_ioaddr));
>  > +
>  > +                timeout =3D start + period * 100;
>  > +                while (((inb(MSR(port_ioaddr)) & MSR_DELTA) =3D=3D =
0) &&
>  > +                       (rdtsc() < timeout));
>  > +
>  > +                delay =3D rdtsc() - start;
>  > +            } else {
>  > +                int status =3D inb(STAT(port_ioaddr));
>  > +
>  > +                start =3D rdtsc();
>  > +
>  > +                toggle ^=3D 0xFF;
>  > +                outb(toggle, DATA(port_ioaddr));
>  > +
>  > +                timeout =3D start + period * 100;
>  > +                while ((inb(STAT(port_ioaddr)) =3D=3D status) &&
>  > +                       (rdtsc() < timeout));
>  > +
>  > +                delay =3D rdtsc() - start;
>  > +            }
>  > +
>  > +            if (!warmup) {
>  > +                lat =3D tsc2ns(delay);
>  > +
>  > +                loop_avg +=3D lat;
>  > +                if (lat < min_lat)
>  > +                    min_lat =3D lat;
>  > +                if (lat > max_lat) {
>  > +                    max_lat =3D lat;
>  > +                    if (trigger_trace) {
>  > +                        if (port_type =3D=3D SERPORT) {
>  > +                            toggle ^=3D MCR_DTR;
>  > +                            outb(toggle, MCR(port_ioaddr));
>  > +                        } else {
>  > +                            // todo
>  > +                        }
>  > +                    }
>  > +                }
>  > +            }
>  > +
>  > +            __asm__ __volatile__("sti");
>  > +
>  > +            while (rdtsc() < start + period);
>  > +        }
>  > +        if (!warmup) {
>  > +            loop_avg /=3D inner_loops;
>  > +
>  > +            printf("%.3f / %.3f / %.3f us\n",
>  > +                ((double)min_lat) / 1000.0, ((double)loop_avg) / 10=
00.0,
>  > +                ((double)max_lat) / 1000.0);
>  > +
>  > +            avg_lat +=3D loop_avg;
>  > +            outer_loops++;
>  > +        } else
>  > +            warmup =3D 0;
>  > +    }
>  > +}
>=20
> Is there no way to make this code easier to port for example by using
> native or posix services for timings measurement and by abstracting the=

> non portable part and moving them to include/asm-i386 ?

This tool is intentionally left Xenomai-free. You can put it on any x86
box around (and I assume that there is almost always some...) and run
the test. Thus, no need for a second RT-patched system.

Anyway, suggestions or patches to add a porting layer are welcome. The
following points need to be addressed: time measuring, irq protection,
hardware access. I just wonder if this is worth the effort.

>=20
> Also note that calling printf from a signal handler risk deadlocking if=

> the signal handler get called on the return path of the write call that=

> take place in the middle of a printf call on the main thread.
>=20

Ok, then we also need a fix for the latency test (this is where I
grabbed that pattern from). Is there a high risk that this locks up? I
wonder why I never observed or heard of problems with latency.

Jan


--------------enig600F1A9555C1645AD07D8474
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEonXeniDOoMHTA+kRAqQuAJ0ZKFAQupQYwYfdOXPlN9yaZNiB4QCfTitA
BNWUwbCkjAA5L8LIoa4WNRI=
=7r75
-----END PGP SIGNATURE-----

--------------enig600F1A9555C1645AD07D8474--

