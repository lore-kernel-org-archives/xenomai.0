Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] PPC posted results (testsuite latency)
Date: Fri, 11 Aug 2006 09:43:15 +0200
Message-ID: <1299EF3181B10F479D85C3280132852422DAF4@domain.hid>
In-Reply-To: <44DB6877.6010702@domain.hid>
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

jan.kiszka wrote:
>=20
> =3D=3D Sampling period: 100 us
>  =3D=3D All results in microseconds
> RTT|  00:00:01
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat =
best|---lat worst
> RTD|       1.859|       3.239|       6.179|       0|       1.859|      =
 6.179
> RTD|       2.159|       3.239|      13.559|       0|       1.859|      =
13.559
> ...

>Looks quite good, maybe too good. Did you load your box? See
>TROUBLESHOOTING for some hints on this. Also let it run for a longer =
period.

What do you mean by "too good"? What could be a cause of these results?

I've tested on a 5-10 minutes basis.
For calculations loads, I tested Linux ones (like =
http://www.tux.org/~mayer/linux/bmark.html) that take 99% of CPU usage.
Then I used the same one compiled for Xenomai. Latency results were =
almost the same.
Only Linux commands seems to disturb Xenomai. I tested some "ps" and =
"top", locally and from a telnet connection.
Results : I reach to 4.x avg latency, and 50 worse.

Any other idea? May be a huge NFS file transfer, or socket transfer, I =
don't know.

Thanks,

S=E9bastien Guardiola Falco.
=20




