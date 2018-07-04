From: Federico Sbalchiero <f.sbalchiero@sferapro.com>
Message-ID: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
Date: Wed, 4 Jul 2018 19:06:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: it
Subject: [Xenomai]  i.MX6q memory write causes high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
first I want to say thanks to everyone involved in Xenomai for their job.

I'm testing Xenomai 3.0.7 and ipipe-arm/4.14 on Freescale/NXP i.MX6q
sabresd board using Yocto. System boots fine and is stable, but latency
under load (xeno-test) is higher than in my reference system (Xenomai
2.6.5 on Freescale kernel 3.10.17 + ipipe 3.10.18).
This is after disabling power management, frequency scaling, CMA,
graphics, tracing, debug.

I have found that a simple non-realtime user space process writing a
buffer in memory (memwrite) is able to trigger such high latencies.
Latency worsen a lot running a copy of the process on each core.
There is a correlation between buffer size and cache size suggesting
an L2 cache issue, like the L2 write allocate discussed in the mailing
list, but I can confirm L2 WA is disabled (see log).

I'm looking for comments or suggestions.

Thanks,
Federico


"memwrite" test case:
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
unsigned char *buffer;
int main(int argc, char **argv)
{
 =A0=A0=A0 int i;
 =A0=A0=A0 int count =3D 0;
 =A0=A0=A0 int n;
 =A0=A0=A0 int size =3D 10 * 1024 * 1024;
 =A0=A0=A0 volatile unsigned *pt;
 =A0=A0=A0 printf("load system by writing in memory\n");
 =A0=A0=A0 buffer =3D malloc(size);
 =A0=A0=A0 if (buffer =3D=3D NULL) {
 =A0=A0=A0 =A0=A0=A0 printf("buffer allocation failed\n");
 =A0=A0=A0 =A0=A0=A0 exit(1);
 =A0=A0=A0 }
 =A0=A0=A0 n =3D size / sizeof(unsigned);
 =A0=A0=A0 while (1) {
 =A0=A0=A0 =A0=A0=A0 // write some data to memory buffer
 =A0=A0=A0 =A0=A0=A0 pt =3D (unsigned *) buffer;
 =A0=A0=A0 =A0=A0=A0 for (i =3D 0; i < n; i++)
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 *pt++ =3D i;
 =A0=A0=A0 =A0=A0=A0 count++;
 =A0=A0=A0 }
 =A0=A0=A0 return 0;
}

xeno-test on Xenomai 3.0.7 and ipipe-arm/4.14:
RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|=A0=A0=A0=A0 18.000|=A0=A0=A0=A0 26.504|=A0=A0=A0=A0 42.667|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
RTD|=A0=A0=A0=A0 19.000|=A0=A0=A0=A0 25.198|=A0=A0=A0=A0 41.000|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
RTD|=A0=A0=A0=A0 18.999|=A0=A0=A0=A0 25.494|=A0=A0=A0=A0 40.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
RTD|=A0=A0=A0=A0 18.666|=A0=A0=A0=A0 25.060|=A0=A0=A0=A0 38.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
RTD|=A0=A0=A0=A0 18.999|=A0=A0=A0=A0 24.464|=A0=A0=A0=A0 38.332|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
RTD|=A0=A0=A0=A0 18.332|=A0=A0=A0=A0 24.546|=A0=A0=A0=A0 41.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 18.000|=A0=A0=A0=A0 42.667
RTD|=A0=A0=A0=A0 13.332|=A0=A0=A0=A0 22.445|=A0=A0=A0=A0 45.665|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.332|=A0=A0=A0=A0 45.665
RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 21.164|=A0=A0=A0=A0 43.665|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 45.665
RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 21.930|=A0=A0=A0=A0 43.665|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 45.665
RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 22.254|=A0=A0=A0=A0 48.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.331|=A0=A0=A0=A0 22.037|=A0=A0=A0=A0 46.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.331|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 21.053|=A0=A0=A0=A0 42.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 20.610|=A0=A0=A0=A0 37.330|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 20.520|=A0=A0=A0=A0 34.997|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.330|=A0=A0=A0=A0 20.398|=A0=A0=A0=A0 39.330|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.663|=A0=A0=A0=A0 21.249|=A0=A0=A0=A0 37.996|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.330|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.329|=A0=A0=A0=A0 20.983|=A0=A0=A0=A0 35.663|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 13.329|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 12.996|=A0=A0=A0=A0 20.039|=A0=A0=A0=A0 34.329|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.996|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.329|=A0=A0=A0=A0 20.580|=A0=A0=A0=A0 42.662|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.996|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 12.995|=A0=A0=A0=A0 20.518|=A0=A0=A0=A0 39.329|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.995|=A0=A0=A0=A0 48.664
RTD|=A0=A0=A0=A0 13.328|=A0=A0=A0=A0 20.168|=A0=A0=A0=A0 35.662|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 12.995|=A0=A0=A0=A0 48.664

xeno-test on Xenomai 2.6.5 and Freescale Linux 3.10.17 + ipipe 3.10.18:
RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|=A0=A0=A0=A0=A0 4.957|=A0=A0=A0=A0 17.575|=A0=A0=A0=A0 28.088|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.957|=A0=A0=A0=A0 28.088
RTD|=A0=A0=A0=A0=A0 4.904|=A0=A0=A0=A0 17.560|=A0=A0=A0=A0 26.828|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.904|=A0=A0=A0=A0 28.088
RTD|=A0=A0=A0=A0=A0 4.479|=A0=A0=A0=A0 13.472|=A0=A0=A0=A0 29.767|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.522|=A0=A0=A0=A0 12.724|=A0=A0=A0=A0 23.275|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.512|=A0=A0=A0=A0 12.904|=A0=A0=A0=A0 25.641|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.542|=A0=A0=A0=A0 12.818|=A0=A0=A0=A0 27.878|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.520|=A0=A0=A0=A0 13.068|=A0=A0=A0=A0 27.926|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.479|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.409|=A0=A0=A0=A0 12.770|=A0=A0=A0=A0 26.689|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.568|=A0=A0=A0=A0 12.265|=A0=A0=A0=A0 27.065|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.492|=A0=A0=A0=A0 12.017|=A0=A0=A0=A0 25.898|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.469|=A0=A0=A0=A0 12.303|=A0=A0=A0=A0 24.540|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.489|=A0=A0=A0=A0 12.030|=A0=A0=A0=A0 27.924|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.590|=A0=A0=A0=A0 11.851|=A0=A0=A0=A0 23.651|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.479|=A0=A0=A0=A0 13.371|=A0=A0=A0=A0 24.838|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.409|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.396|=A0=A0=A0=A0 13.204|=A0=A0=A0=A0 28.797|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.411|=A0=A0=A0=A0 12.454|=A0=A0=A0=A0 26.002|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.560|=A0=A0=A0=A0 12.234|=A0=A0=A0=A0 27.146|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.593|=A0=A0=A0=A0 12.441|=A0=A0=A0=A0 24.686|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.520|=A0=A0=A0=A0 12.510|=A0=A0=A0=A0 24.275|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.568|=A0=A0=A0=A0 11.797|=A0=A0=A0=A0 24.982|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767
RTD|=A0=A0=A0=A0=A0 4.482|=A0=A0=A0=A0 12.631|=A0=A0=A0=A0 24.972|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 4.396|=A0=A0=A0=A0 29.767

latency (no xeno-test!) with four memwrite instances on Xenomai 3.0.7=20
and ipipe-arm/4.14:
RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|=A0=A0=A0=A0 41.999|=A0=A0=A0=A0 60.200|=A0=A0=A0 101.333|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 41.999|=A0=A0=A0 101.333
RTD|=A0=A0=A0=A0 42.666|=A0=A0=A0=A0 60.471|=A0=A0=A0 103.666|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 41.999|=A0=A0=A0 103.666
RTD|=A0=A0=A0=A0 36.999|=A0=A0=A0=A0 60.568|=A0=A0=A0=A0 96.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 36.999|=A0=A0=A0 103.666
RTD|=A0=A0=A0=A0 38.998|=A0=A0=A0=A0 60.535|=A0=A0=A0=A0 95.332|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 36.999|=A0=A0=A0 103.666
RTD|=A0=A0=A0=A0 35.332|=A0=A0=A0=A0 60.359|=A0=A0=A0 105.998|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 105.998
RTD|=A0=A0=A0=A0 41.998|=A0=A0=A0=A0 60.762|=A0=A0=A0 116.665|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 40.664|=A0=A0=A0=A0 60.419|=A0=A0=A0=A0 96.331|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 41.331|=A0=A0=A0=A0 60.678|=A0=A0=A0=A0 91.331|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 38.997|=A0=A0=A0=A0 60.923|=A0=A0=A0=A0 94.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 42.664|=A0=A0=A0=A0 60.505|=A0=A0=A0=A0 95.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 40.330|=A0=A0=A0=A0 60.175|=A0=A0=A0=A0 95.664|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 40.663|=A0=A0=A0=A0 60.368|=A0=A0=A0=A0 96.663|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 42.330|=A0=A0=A0=A0 60.286|=A0=A0=A0=A0 95.330|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 36.996|=A0=A0=A0=A0 60.304|=A0=A0=A0 100.663|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 41.996|=A0=A0=A0=A0 61.100|=A0=A0=A0 103.663|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 40.996|=A0=A0=A0=A0 60.792|=A0=A0=A0 102.996|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 38.662|=A0=A0=A0=A0 60.205|=A0=A0=A0 104.329|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 39.995|=A0=A0=A0=A0 60.645|=A0=A0=A0=A0 98.995|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 37.328|=A0=A0=A0=A0 60.300|=A0=A0=A0=A0 99.662|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 40.995|=A0=A0=A0=A0 60.206|=A0=A0=A0=A0 98.328|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665
RTD|=A0=A0=A0=A0 36.994|=A0=A0=A0=A0 60.444|=A0=A0=A0=A0 95.661|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 35.332|=A0=A0=A0 116.665

Linux 4.14 menuconfig:
 =A0 CPU Power Management\CPU Frequency scaling -> NO
 =A0 CPU Power Management\CPU Idle PM support -> NO
 =A0 Power management options\Suspend to RAM and standby -> no
 =A0 Power management options\Device power management core functionality ->=
 no
 =A0 Device Drivers\Graphics support\DRM Support for Freescale i.MX -> no
 =A0 Device Drivers\Graphics support\ETNAVIV (DRM support for Vivante GPU=20
IP cores) -> no
 =A0 Kernel Features\Timer frequency -> 200 Hz
 =A0 Kernel Features\Allow for memory compaction -> no
 =A0 Kernel Features\Contiguous Memory Allocator -> no
 =A0 Kernel hacking\Tracers -> no
 =A0 Kernel hacking\Lock Debugging (spinlocks, mutexes, etc...) -> all no
 =A0 Kernel hacking\Stack backtrace support -> no
 =A0 Bus support\PCI support-> no

Boot log:
[=A0=A0=A0 0.000000] Booting Linux on physical CPU 0x0
[=A0=A0=A0 0.000000] Linux version 4.14.36-fslc+gc664b053e5ce=20
(oe-user@oe-host) (gcc version 7.3.0 (GCC)) #1 SMP Tue Jun 26 08:49:22=20
UTC 2018
[=A0=A0=A0 0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),=20
cr=3D10c5387d
[=A0=A0=A0 0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing=
=20
instruction cache
[=A0=A0=A0 0.000000] OF: fdt: Machine model: Freescale i.MX6 Quad SABRE Sma=
rt=20
Device Board
[=A0=A0=A0 0.000000] Memory policy: Data cache writealloc
[=A0=A0=A0 0.000000] On node 0 totalpages: 262144
[=A0=A0=A0 0.000000] free_area_init_node: node 0, pgdat c0d62900, node_mem_=
map=20
ef7f8000
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 1536 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 0 pages reserved
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 196608 pages, LIFO batch:31
[=A0=A0=A0 0.000000]=A0=A0 HighMem zone: 65536 pages, LIFO batch:15
[=A0=A0=A0 0.000000] percpu: Embedded 19 pages/cpu @ef78a000 s46924 r8192=20
d22708 u77824
[=A0=A0=A0 0.000000] pcpu-alloc: s46924 r8192 d22708 u77824 alloc=3D19*4096
[=A0=A0=A0 0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[=A0=A0=A0 0.000000] Built 1 zonelists, mobility grouping on.=A0 Total page=
s: 260608
[=A0=A0=A0 0.000000] Kernel command line: console=3Dttymxc0,115200=20
root=3DPARTUUID=3D1bfc1072-02 rootwait rw[=A0=A0=A0 0.000000] PID hash tabl=
e=20
entries: 4096 (order: 2, 16384 bytes)
[=A0=A0=A0 0.000000] Dentry cache hash table entries: 131072 (order: 7, 524=
288=20
bytes)
[=A0=A0=A0 0.000000] Inode-cache hash table entries: 65536 (order: 6, 26214=
4=20
bytes)
[=A0=A0=A0 0.000000] Memory: 1025492K/1048576K available (8192K kernel code=
,=20
397K rwdata, 2220K rodata, 1024K init, 885K bss, 23084K reserved, 0K=20
cma-reserved, 262144K highmem)
[=A0=A0=A0 0.000000] Virtual kernel memory layout:
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 vector=A0 : 0xffff0000 - 0xffff1000=A0=A0 =
(=A0=A0 4 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 fixmap=A0 : 0xffc00000 - 0xfff00000=A0=A0 =
(3072 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 vmalloc : 0xf0800000 - 0xff800000=A0=A0 ( =
240 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 lowmem=A0 : 0xc0000000 - 0xf0000000=A0=A0 =
( 768 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 pkmap=A0=A0 : 0xbfe00000 - 0xc0000000=A0=
=A0 (=A0=A0 2 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 modules : 0xbf000000 - 0xbfe00000=A0=A0 (=
=A0 14 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .text : 0xc0008000 - 0xc0900000=A0=
=A0 (9184 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .init : 0xc0c00000 - 0xc0d00000=A0=
=A0 (1024 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .data : 0xc0d00000 - 0xc0d63700=A0=
=A0 ( 398 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0=A0 .bss : 0xc0d65000 - 0xc0e4255c=A0=
=A0 ( 886 kB)
[=A0=A0=A0 0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=
=3D4, Nodes=3D1
[=A0=A0=A0 0.000000] Hierarchical RCU implementation.
[=A0=A0=A0 0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[=A0=A0=A0 0.000000] L2C: I-pipe: l2x0_write_allocate=3D not specified, def=
aults=20
to 0 (disabled).
[=A0=A0=A0 0.000000] L2C: DT/platform modifies aux control register:=20
0x32470000 -> 0x32c70000
[=A0=A0=A0 0.000000] L2C-310 errata 752271 769419 enabled
[=A0=A0=A0 0.000000] L2C-310 enabling early BRESP for Cortex-A9
[=A0=A0=A0 0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[=A0=A0=A0 0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[=A0=A0=A0 0.000000] L2C-310 dynamic clock gating enabled, standby mode ena=
bled
[=A0=A0=A0 0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[=A0=A0=A0 0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76c70001
[=A0=A0=A0 0.000000] I-pipe, 396.000 MHz timer
[=A0=A0=A0 0.000000] Switching to timer-based delay loop, resolution 333ns
[=A0=A0=A0 0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wra=
ps=20
every 715827882841ns
[=A0=A0=A0 0.000027] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: =

0xffffffff, max_idle_ns: 637086815595 ns
[=A0=A0=A0 0.000042] I-pipe, 3.000 MHz clocksource, wrap in 1431655 ms
[=A0=A0=A0 0.000059] clocksource: ipipe_tsc: mask: 0xffffffffffffffff=20
max_cycles: 0x1623fa770, max_idle_ns: 881590404476 ns
[=A0=A0=A0 0.001630] Interrupt pipeline (release #1)
[=A0=A0=A0 0.001784] Console: colour dummy device 80x30
[=A0=A0=A0 0.001816] Calibrating delay loop (skipped), value calculated usi=
ng=20
timer frequency.. 6.00 BogoMIPS (lpj=3D15000)
[=A0=A0=A0 0.001833] pid_max: default: 32768 minimum: 301
[=A0=A0=A0 0.001978] Mount-cache hash table entries: 2048 (order: 1, 8192 b=
ytes)
[=A0=A0=A0 0.002002] Mountpoint-cache hash table entries: 2048 (order: 1, 8=
192=20
bytes)
[=A0=A0=A0 0.002545] CPU: Testing write buffer coherency: ok
[=A0=A0=A0 0.002902] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[=A0=A0=A0 0.003310] Setting up static identity map for 0x10100000 - 0x1010=
0078
[=A0=A0=A0 0.003453] Hierarchical SRCU implementation.
[=A0=A0=A0 0.004120] smp: Bringing up secondary CPUs ...
[=A0=A0=A0 0.004748] I-pipe, 396.000 MHz timer
[=A0=A0=A0 0.004770] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[=A0=A0=A0 0.005491] I-pipe, 396.000 MHz timer
[=A0=A0=A0 0.005512] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[=A0=A0=A0 0.006237] I-pipe, 396.000 MHz timer
[=A0=A0=A0 0.006257] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[=A0=A0=A0 0.006373] smp: Brought up 1 node, 4 CPUs
[=A0=A0=A0 0.006405] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[=A0=A0=A0 0.006415] CPU: All CPU(s) started in SVC mode.
[=A0=A0=A0 0.007527] devtmpfs: initialized
[=A0=A0=A0 0.016773] random: get_random_u32 called from=20
bucket_table_alloc+0x100/0x230 with crng_init=3D0
[=A0=A0=A0 0.016890] VFP support v0.3: implementor 41 architecture 3 part 3=
0=20
variant 9 rev 4
[=A0=A0=A0 0.017029] clocksource: jiffies: mask: 0xffffffff max_cycles:=20
0xffffffff, max_idle_ns: 9556302231375000 ns
[=A0=A0=A0 0.017054] futex hash table entries: 1024 (order: 4, 65536 bytes)
[=A0=A0=A0 0.017282] pinctrl core: initialized pinctrl subsystem
[=A0=A0=A0 0.018032] NET: Registered protocol family 16
[=A0=A0=A0 0.019872] DMA: preallocated 256 KiB pool for atomic coherent=20
allocations
[=A0=A0=A0 0.020697] CPU identified as i.MX6Q, silicon rev 1.1
[=A0=A0=A0 0.026849] vdd1p1: supplied by regulator-dummy
[=A0=A0=A0 0.027291] vdd3p0: supplied by regulator-dummy
[=A0=A0=A0 0.027687] vdd2p5: supplied by regulator-dummy
[=A0=A0=A0 0.037718] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 =

watchpoint registers.
[=A0=A0=A0 0.037731] hw-breakpoint: maximum watchpoint size is 4 bytes.
[=A0=A0=A0 0.039110] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl =
driver
[=A0=A0=A0 0.060477] mxs-dma 110000.dma-apbh: initialized
[=A0=A0=A0 0.063177] SCSI subsystem initialized
[=A0=A0=A0 0.063409] libata version 3.00 loaded.
[=A0=A0=A0 0.063601] usbcore: registered new interface driver usbfs
[=A0=A0=A0 0.063658] usbcore: registered new interface driver hub
[=A0=A0=A0 0.063755] usbcore: registered new device driver usb
[=A0=A0=A0 0.064922] i2c i2c-0: IMX I2C adapter registered
[=A0=A0=A0 0.064941] i2c i2c-0: can't use DMA, using PIO instead.
[=A0=A0=A0 0.065483] i2c i2c-1: IMX I2C adapter registered
[=A0=A0=A0 0.065501] i2c i2c-1: can't use DMA, using PIO instead.
[=A0=A0=A0 0.065939] i2c i2c-2: IMX I2C adapter registered
[=A0=A0=A0 0.065955] i2c i2c-2: can't use DMA, using PIO instead.
[=A0=A0=A0 0.066077] media: Linux media interface: v0.10
[=A0=A0=A0 0.066129] Linux video capture interface: v2.00
[=A0=A0=A0 0.066188] pps_core: LinuxPPS API ver. 1 registered
[=A0=A0=A0 0.066197] pps_core: Software ver. 5.3.6 - Copyright 2005-2007=20
Rodolfo Giometti <giometti@linux.it>
[=A0=A0=A0 0.066219] PTP clock support registered
[=A0=A0=A0 0.066476] Advanced Linux Sound Architecture Driver Initialized.
[=A0=A0=A0 0.067494] Bluetooth: Core ver 2.22
[=A0=A0=A0 0.067538] NET: Registered protocol family 31
[=A0=A0=A0 0.067548] Bluetooth: HCI device and connection manager initializ=
ed
[=A0=A0=A0 0.067565] Bluetooth: HCI socket layer initialized
[=A0=A0=A0 0.067579] Bluetooth: L2CAP socket layer initialized
[=A0=A0=A0 0.067615] Bluetooth: SCO socket layer initialized
[=A0=A0=A0 0.068490] clocksource: Switched to clocksource ipipe_tsc
[=A0=A0=A0 0.068592] VFS: Disk quotas dquot_6.6.0
[=A0=A0=A0 0.068662] VFS: Dquot-cache hash table entries: 1024 (order 0, 40=
96=20
bytes)
[=A0=A0=A0 0.076791] NET: Registered protocol family 2
[=A0=A0=A0 0.077372] TCP established hash table entries: 8192 (order: 3, 32=
768=20
bytes)
[=A0=A0=A0 0.077461] TCP bind hash table entries: 8192 (order: 4, 65536 byt=
es)
[=A0=A0=A0 0.077605] TCP: Hash tables configured (established 8192 bind 819=
2)
[=A0=A0=A0 0.077815] UDP hash table entries: 512 (order: 2, 16384 bytes)
[=A0=A0=A0 0.077862] UDP-Lite hash table entries: 512 (order: 2, 16384 byte=
s)
[=A0=A0=A0 0.078054] NET: Registered protocol family 1
[=A0=A0=A0 0.078552] RPC: Registered named UNIX socket transport module.
[=A0=A0=A0 0.078564] RPC: Registered udp transport module.
[=A0=A0=A0 0.078574] RPC: Registered tcp transport module.
[=A0=A0=A0 0.078583] RPC: Registered tcp NFSv4.1 backchannel transport modu=
le.
[=A0=A0=A0 0.079359] hw perfevents: no interrupt-affinity property for=20
/soc/pmu, guessing.
[=A0=A0=A0 0.079613] hw perfevents: enabled with armv7_cortex_a9 PMU driver=
, 7=20
counters available
[=A0=A0=A0 0.080925] [Xenomai] scheduling class idle registered.
[=A0=A0=A0 0.080936] [Xenomai] scheduling class rt registered.
[=A0=A0=A0 0.081181] I-pipe: head domain Xenomai registered.
[=A0=A0=A0 0.083885] [Xenomai] Cobalt v3.0.7 (Lingering Dawn)
[=A0=A0=A0 0.083987] workingset: timestamp_bits=3D30 max_order=3D18 bucket_=
order=3D0
[=A0=A0=A0 0.088810] NFS: Registering the id_resolver key type
[=A0=A0=A0 0.088850] Key type id_resolver registered
[=A0=A0=A0 0.088860] Key type id_legacy registered
[=A0=A0=A0 0.088905] jffs2: version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
[=A0=A0=A0 0.089328] fuse init (API version 7.26)
[=A0=A0=A0 0.094536] bounce: pool size: 64 pages
[=A0=A0=A0 0.094558] io scheduler noop registered
[=A0=A0=A0 0.094568] io scheduler deadline registered
[=A0=A0=A0 0.094785] io scheduler cfq registered (default)
[=A0=A0=A0 0.094798] io scheduler mq-deadline registered
[=A0=A0=A0 0.094807] io scheduler kyber registered
[=A0=A0=A0 0.097088] pwm-backlight backlight-lvds: backlight-lvds supply po=
wer=20
not found, using dummy regulator
[=A0=A0=A0 0.098906] imx-sdma 20ec000.sdma: Direct firmware load for=20
imx/sdma/sdma-imx6q.bin failed with error -2
[=A0=A0=A0 0.098924] imx-sdma 20ec000.sdma: external firmware not found, us=
ing=20
ROM firmware
...




