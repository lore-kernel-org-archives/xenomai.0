Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] PPC posted results (testsuite latency)
Date: Thu, 10 Aug 2006 19:03:42 +0200
Message-ID: <1299EF3181B10F479D85C3280132852422DAF1@domain.hid>
From: "GUARDIOLA-FALCO Sebastien 204282" <Sebastien.GUARDIOLA-FALCO@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Here are the results for a PowerPC MVME2700 267Mhz (32Mo RAM + 1024kb =
L2-cache).
Can someone cross-check them?

The default value for the kernel parameter "scheduling latency" led me =
to negative results, so I changed it to 4500ns. Can I improve those =
results with another walue, or with other parameters?
For the klatency test, I get more or less the half time I get in =
latency.

=3D=3D Sampling period: 100 us
 =3D=3D All results in microseconds
RTT|  00:00:01
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
RTD|       1.859|       3.239|       6.179|       0|       1.859|       =
6.179
RTD|       2.159|       3.239|      13.559|       0|       1.859|      =
13.559
RTD|       1.979|       3.239|       8.879|       0|       1.859|      =
13.559
RTD|       2.279|       3.239|      10.259|       0|       1.859|      =
13.559
RTD|       1.979|       3.239|      10.319|       0|       1.859|      =
13.559
RTD|       2.219|       3.239|       8.939|       0|       1.859|      =
13.559
RTD|       2.099|       3.239|      12.419|       0|       1.859|      =
13.559
RTD|       2.339|       3.239|       9.479|       0|       1.859|      =
13.559
RTD|       2.219|       3.239|      11.759|       0|       1.859|      =
13.559
RTD|       1.979|       3.239|       9.479|       0|       1.859|      =
13.559
RTD|       2.099|       3.239|      10.439|       0|       1.859|      =
13.559
RTD|       1.919|       3.239|       9.899|       0|       1.859|      =
13.559
RTD|       2.219|       3.239|       8.999|       0|       1.859|      =
13.559
RTD|       2.039|       3.239|       9.779|       0|       1.859|      =
13.559
RTD|       1.859|       3.239|       9.659|       0|       1.859|      =
13.559
RTD|       1.979|       3.239|      10.919|       0|       1.859|      =
13.559
RTD|       2.339|       3.239|       9.779|       0|       1.859|      =
13.559
RTD|       2.099|       3.239|      13.499|       0|       1.859|      =
13.559
RTD|       1.979|       3.239|       8.999|       0|       1.859|      =
13.559
RTD|       2.219|       3.239|      10.919|       0|       1.859|      =
13.559
RTD|       1.919|       3.239|      10.259|       0|       1.859|      =
13.559

S=E9bastien Guardiola Falco.


