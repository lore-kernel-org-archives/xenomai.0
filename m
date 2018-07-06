References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fd18fc55-8cb3-70cf-10c2-00d056506360@xenomai.org>
Date: Fri, 6 Jul 2018 11:04:11 +0200
MIME-Version: 1.0
In-Reply-To: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] i.MX6q memory write causes high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Federico Sbalchiero <f.sbalchiero@sferapro.com>, xenomai@xenomai.org

On 07/04/2018 07:06 PM, Federico Sbalchiero wrote:
> Hi,
> first I want to say thanks to everyone involved in Xenomai for their job.
>=20
> I'm testing Xenomai 3.0.7 and ipipe-arm/4.14 on Freescale/NXP i.MX6q
> sabresd board using Yocto. System boots fine and is stable, but latency
> under load (xeno-test) is higher than in my reference system (Xenomai
> 2.6.5 on Freescale kernel 3.10.17 + ipipe 3.10.18).
> This is after disabling power management, frequency scaling, CMA,
> graphics, tracing, debug.
>=20
> I have found that a simple non-realtime user space process writing a
> buffer in memory (memwrite) is able to trigger such high latencies.
> Latency worsen a lot running a copy of the process on each core.
> There is a correlation between buffer size and cache size suggesting
> an L2 cache issue, like the L2 write allocate discussed in the mailing
> list, but I can confirm L2 WA is disabled (see log).
>=20
> I'm looking for comments or suggestions.
>=20
> Thanks,
> Federico
>=20
>=20
> "memwrite" test case:
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> unsigned char *buffer;
> int main(int argc, char **argv)
> {
> =A0=A0=A0 int i;
> =A0=A0=A0 int count =3D 0;
> =A0=A0=A0 int n;
> =A0=A0=A0 int size =3D 10 * 1024 * 1024;
> =A0=A0=A0 volatile unsigned *pt;
> =A0=A0=A0 printf("load system by writing in memory\n");
> =A0=A0=A0 buffer =3D malloc(size);
> =A0=A0=A0 if (buffer =3D=3D NULL) {
> =A0=A0=A0 =A0=A0=A0 printf("buffer allocation failed\n");
> =A0=A0=A0 =A0=A0=A0 exit(1);
> =A0=A0=A0 }
> =A0=A0=A0 n =3D size / sizeof(unsigned);
> =A0=A0=A0 while (1) {
> =A0=A0=A0 =A0=A0=A0 // write some data to memory buffer
> =A0=A0=A0 =A0=A0=A0 pt =3D (unsigned *) buffer;
> =A0=A0=A0 =A0=A0=A0 for (i =3D 0; i < n; i++)
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 *pt++ =3D i;
> =A0=A0=A0 =A0=A0=A0 count++;
> =A0=A0=A0 }
> =A0=A0=A0 return 0;
> }
>=20
> xeno-test on Xenomai 3.0.7 and ipipe-arm/4.14:
> RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst
> RTD|=A0=A0=A0=A0 18.000|=A0=A0=A0=A0 26.504|=A0=A0=A0=A0 42.667|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
> RTD|=A0=A0=A0=A0 19.000|=A0=A0=A0=A0 25.198|=A0=A0=A0=A0 41.000|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
> RTD|=A0=A0=A0=A0 18.999|=A0=A0=A0=A0 25.494|=A0=A0=A0=A0 40.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
> RTD|=A0=A0=A0=A0 18.666|=A0=A0=A0=A0 25.060|=A0=A0=A0=A0 38.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
> RTD|=A0=A0=A0=A0 18.999|=A0=A0=A0=A0 24.464|=A0=A0=A0=A0 38.332|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
> RTD|=A0=A0=A0=A0 18.332|=A0=A0=A0=A0 24.546|=A0=A0=A0=A0 41.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
> RTD|=A0=A0=A0=A0 13.332|=A0=A0=A0=A0 22.445|=A0=A0=A0=A0 45.665|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.332|=A0=A0=A0=A0 45.665
> RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 21.164|=A0=A0=A0=A0 43.665|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 45.665
> RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 21.930|=A0=A0=A0=A0 43.665|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 45.665
> RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 22.254|=A0=A0=A0=A0 48.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 22.037|=A0=A0=A0=A0 46.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 21.053|=A0=A0=A0=A0 42.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 20.610|=A0=A0=A0=A0 37.330|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 20.520|=A0=A0=A0=A0 34.997|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 20.398|=A0=A0=A0=A0 39.330|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.663|=A0=A0=A0=A0 21.249|=A0=A0=A0=A0 37.996|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.329|=A0=A0=A0=A0 20.983|=A0=A0=A0=A0 35.663|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.329|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 12.996|=A0=A0=A0=A0 20.039|=A0=A0=A0=A0 34.329|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.996|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.329|=A0=A0=A0=A0 20.580|=A0=A0=A0=A0 42.662|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.996|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 12.995|=A0=A0=A0=A0 20.518|=A0=A0=A0=A0 39.329|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.995|=A0=A0=A0=A0 48.664
> RTD|=A0=A0=A0=A0 13.328|=A0=A0=A0=A0 20.168|=A0=A0=A0=A0 35.662|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.995|=A0=A0=A0=A0 48.664
>=20
> xeno-test on Xenomai 2.6.5 and Freescale Linux 3.10.17 + ipipe 3.10.18:
> RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst
> RTD|=A0=A0=A0=A0=A0 4.957|=A0=A0=A0=A0 17.575|=A0=A0=A0=A0 28.088|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.957|=A0=A0=A0=A0 28.088
> RTD|=A0=A0=A0=A0=A0 4.904|=A0=A0=A0=A0 17.560|=A0=A0=A0=A0 26.828|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.904|=A0=A0=A0=A0 28.088
> RTD|=A0=A0=A0=A0=A0 4.479|=A0=A0=A0=A0 13.472|=A0=A0=A0=A0 29.767|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.522|=A0=A0=A0=A0 12.724|=A0=A0=A0=A0 23.275|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.512|=A0=A0=A0=A0 12.904|=A0=A0=A0=A0 25.641|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.542|=A0=A0=A0=A0 12.818|=A0=A0=A0=A0 27.878|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.520|=A0=A0=A0=A0 13.068|=A0=A0=A0=A0 27.926|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.409|=A0=A0=A0=A0 12.770|=A0=A0=A0=A0 26.689|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.568|=A0=A0=A0=A0 12.265|=A0=A0=A0=A0 27.065|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.492|=A0=A0=A0=A0 12.017|=A0=A0=A0=A0 25.898|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.469|=A0=A0=A0=A0 12.303|=A0=A0=A0=A0 24.540|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.489|=A0=A0=A0=A0 12.030|=A0=A0=A0=A0 27.924|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.590|=A0=A0=A0=A0 11.851|=A0=A0=A0=A0 23.651|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.479|=A0=A0=A0=A0 13.371|=A0=A0=A0=A0 24.838|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.396|=A0=A0=A0=A0 13.204|=A0=A0=A0=A0 28.797|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.411|=A0=A0=A0=A0 12.454|=A0=A0=A0=A0 26.002|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.560|=A0=A0=A0=A0 12.234|=A0=A0=A0=A0 27.146|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.593|=A0=A0=A0=A0 12.441|=A0=A0=A0=A0 24.686|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.520|=A0=A0=A0=A0 12.510|=A0=A0=A0=A0 24.275|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.568|=A0=A0=A0=A0 11.797|=A0=A0=A0=A0 24.982|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
> RTD|=A0=A0=A0=A0=A0 4.482|=A0=A0=A0=A0 12.631|=A0=A0=A0=A0 24.972|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
>=20

Worst-case on 2.6.5 + 3.18.20 is 67 us here, after 10 hrs runtime on
imx6q - definitely not 30 us - stressing the latency test with:

- dd loop (zero -> null, 16M bs)
- switchtest -s 200

--=20
Philippe.

