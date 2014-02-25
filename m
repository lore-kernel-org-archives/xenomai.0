References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
 <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530A862C.1060805@xenomai.org>
 <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
 <530B374B.1080507@xenomai.org>
 <1393298793.43978.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530C6AC6.6030200@xenomai.org>
Message-ID: <1393335358.33826.YahooMailNeo@web140603.mail.bf1.yahoo.com>
Date: Tue, 25 Feb 2014 05:35:58 -0800 (PST)
From: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
In-Reply-To: <530C6AC6.6030200@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] User Space Problems
Reply-To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,=0A=0AI applied this new patch and I got the results below.=0A=0A=
This is the complete boot log: http://pastebin.com/YY5pFyaN=0A=0AI executed=
 latency and xeno-test some times and the results:=0A=0Alinaro@linaro-alip:=
/usr/xenomai/bin$ sudo ./latency=0A=3D=3D Sampling period: 1000 us=0A=3D=3D=
 Test mode: periodic user-mode task=0A=3D=3D All results in microseconds=0A=
warming up...=0ARTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us perio=
d, priority 99)=0ARTH|----lat min|----lat avg|----lat max|-overrun|---msw|-=
--lat best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 4.904|=A0=A0=A0=A0=A0 9.997|=
=A0=A0=A0=A0 26.108|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.9=
04|=A0=A0=A0=A0 26.108=0ARTD|=A0=A0=A0=A0=A0 4.669|=A0=A0=A0=A0=A0 9.931|=
=A0=A0=A0=A0 25.295|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.6=
69|=A0=A0=A0=A0 26.108=0ARTD|=A0=A0=A0=A0=A0 4.709|=A0=A0=A0=A0 10.035|=A0=
=A0=A0=A0 25.694|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.669|=
=A0=A0=A0=A0 26.108=0ARTD|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 10.383|=A0=A0=
=A0=A0 41.742|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=
=A0=A0=A0 41.742=0ARTD|=A0=A0=A0=A0=A0 4.598|=A0=A0=A0=A0=A0 9.618|=A0=A0=
=A0=A0 49.883|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=
=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.823|=A0=A0=A0=A0=A0 9.820|=A0=A0=
=A0=A0 31.297|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=
=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.282|=A0=A0=A0=A0=A0 9.603|=A0=A0=
=A0=A0 23.123|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=
=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.343|=A0=A0=A0=A0=A0 9.583|=A0=A0=
=A0=A0 33.345|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=
=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.267|=A0=A0=A0=A0 11.138|=A0=A0=A0=
=A0 36.436|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=
=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.919|=A0=A0=A0=A0 10.891|=A0=A0=A0=A0 =
22.083|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=
=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.414|=A0=A0=A0=A0=A0 9.752|=A0=A0=A0=A0 3=
4.035|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=
=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.535|=A0=A0=A0=A0=A0 9.765|=A0=A0=A0=A0 3=
5.512|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=
=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.113|=A0=A0=A0=A0=A0 9.851|=A0=A0=A0=A0 3=
9.275|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=
=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 3.944|=A0=A0=A0=A0 10.613|=A0=A0=A0=A0 31.=
088|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 =
49.883=0ARTD|=A0=A0=A0=A0=A0 9.593|=A0=A0=A0=A0 12.545|=A0=A0=A0=A0 37.883|=
=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.8=
83=0ARTD|=A0=A0=A0=A0=A0 9.479|=A0=A0=A0=A0 12.603|=A0=A0=A0=A0 44.626|=A0=
=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=
=0ARTD|=A0=A0=A0=A0=A0 9.060|=A0=A0=A0=A0 12.689|=A0=A0=A0=A0 43.363|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0AR=
TD|=A0=A0=A0=A0=A0 4.494|=A0=A0=A0=A0 10.919|=A0=A0=A0=A0 42.674|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=
=A0=A0=A0=A0=A0 4.709|=A0=A0=A0=A0 10.540|=A0=A0=A0=A0 37.252|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=A0=
=A0=A0=A0=A0 4.191|=A0=A0=A0=A0=A0 9.179|=A0=A0=A0=A0 22.212|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=A0=
=A0=A0=A0=A0 4.969|=A0=A0=A0=A0 11.126|=A0=A0=A0=A0 24.075|=A0=A0=A0=A0=A0=
=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTT|=A0 00=
:00:22=A0 (periodic user-mode task, 1000 us period, priority 99)=0ARTH|----=
lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst=0AR=
TD|=A0=A0=A0=A0=A0 4.494|=A0=A0=A0=A0 12.487|=A0=A0=A0=A0 28.108|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=
=A0=A0=A0=A0=A0 4.156|=A0=A0=A0=A0 11.126|=A0=A0=A0=A0 21.053|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=A0=
=A0=A0=A0=A0 4.462|=A0=A0=A0=A0 11.654|=A0=A0=A0=A0 39.888|=A0=A0=A0=A0=A0=
=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=A0=A0=
=A0=A0=A0 5.510|=A0=A0=A0=A0 12.931|=A0=A0=A0=A0 41.967|=A0=A0=A0=A0=A0=A0 =
0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=
=A0=A0 4.282|=A0=A0=A0=A0 12.989|=A0=A0=A0=A0 43.045|=A0=A0=A0=A0=A0=A0 0|=
=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=
=A0 3.792|=A0=A0=A0=A0 12.520|=A0=A0=A0=A0 37.727|=A0=A0=A0=A0=A0=A0 0|=A0=
=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=A0=
 4.459|=A0=A0=A0=A0 13.199|=A0=A0=A0=A0 36.714|=A0=A0=A0=A0=A0=A0 0|=A0=A0=
=A0=A0 0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 49.883=0ARTD|=A0=A0=A0=A0=A0 4.=
494|=A0=A0=A0=A0 11.055|=A0=A0=A0=A0 51.909|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 51.909=0ARTD|=A0=A0=A0=A0=A0 4.530=
|=A0=A0=A0=A0=A0 9.979|=A0=A0=A0=A0 48.623|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 51.909=0ARTD|=A0=A0=A0=A0=A0 4.224=
|=A0=A0=A0=A0=A0 9.325|=A0=A0=A0=A0 42.828|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 51.909=0ARTD|=A0=A0=A0=A0=A0 3.891=
|=A0=A0=A0=A0=A0 9.176|=A0=A0=A0=A0 54.623|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 4.472=
|=A0=A0=A0=A0 12.499|=A0=A0=A0=A0 33.911|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 =
0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 6.810|=A0=
=A0=A0=A0 13.015|=A0=A0=A0=A0 45.351|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 4.936|=A0=
=A0=A0=A0 13.906|=A0=A0=A0=A0 49.749|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 4.732|=A0=
=A0=A0=A0 15.356|=A0=A0=A0=A0 52.207|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 5.608|=A0=
=A0=A0=A0 12.479|=A0=A0=A0=A0 49.457|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 6.348|=A0=
=A0=A0=A0 13.356|=A0=A0=A0=A0 39.015|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 8.702|=A0=
=A0=A0=A0 13.520|=A0=A0=A0=A0 40.843|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 6.898|=A0=
=A0=A0=A0 12.949|=A0=A0=A0=A0 42.744|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 4.222|=A0=
=A0=A0=A0 12.335|=A0=A0=A0=A0 39.363|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 3.891|=A0=
=A0=A0=A0 12.383|=A0=A0=A0=A0 35.325|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTT|=A0 00:00:43=A0 (periodic u=
ser-mode task, 1000 us period, priority 99)=0ARTH|----lat min|----lat avg|-=
---lat max|-overrun|---msw|---lat best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 8.=
116|=A0=A0=A0=A0 13.333|=A0=A0=A0=A0 38.209|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0ARTD|=A0=A0=A0=A0=A0 8.510=
|=A0=A0=A0=A0 13.126|=A0=A0=A0=A0 40.661|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 =
0|=A0=A0=A0=A0=A0 3.792|=A0=A0=A0=A0 54.623=0A^C---|-----------|-----------=
|-----------|--------|------|-------------------------=0ARTS|=A0=A0=A0=A0=
=A0 3.792|=A0=A0=A0=A0 11.482|=A0=A0=A0=A0 54.623|=A0=A0=A0=A0=A0=A0 0|=A0=
=A0=A0=A0 0|=A0=A0=A0 00:00:45/00:00:45=0A=0A=0A(Xeno-test)=0A=0AStarted ch=
ild 27013: dohell 900=0AStarted child 27015: /usr/xenomai/bin/latency=0A=3D=
=3D Sampling period: 1000 us=0A=3D=3D Test mode: periodic user-mode task=0A=
=3D=3D All results in microseconds=0Awarming up...=0ARTT|=A0 00:00:01=A0 (p=
eriodic user-mode task, 1000 us period, priority 99)=0ARTH|----lat min|----=
lat avg|----lat max|-overrun|---msw|---lat best|--lat worst=0ARTD|=A0=A0=A0=
=A0=A0 4.065|=A0=A0=A0=A0 10.621|=A0=A0=A0=A0 21.959|=A0=A0=A0=A0=A0=A0 0|=
=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.065|=A0=A0=A0=A0 21.959=0ARTD|=A0=A0=A0=A0=
=A0 3.952|=A0=A0=A0=A0 11.335|=A0=A0=A0=A0 46.752|=A0=A0=A0=A0=A0=A0 0|=A0=
=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 46.752=0ARTD|=A0=A0=A0=A0=A0=
 4.050|=A0=A0=A0=A0 11.121|=A0=A0=A0=A0 49.285|=A0=A0=A0=A0=A0=A0 0|=A0=A0=
=A0=A0 0|=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 49.285=0ARTD|=A0=A0=A0=A0=A0 4.=
088|=A0=A0=A0=A0 11.131|=A0=A0=A0=A0 41.467|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 49.285=0ARTD|=A0=A0=A0=A0=A0 4.065=
|=A0=A0=A0=A0 10.851|=A0=A0=A0=A0 58.446|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 =
0|=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.027|=A0=
=A0=A0=A0 10.949|=A0=A0=A0=A0 43.684|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.027|=A0=
=A0=A0=A0 10.366|=A0=A0=A0=A0 35.911|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.982|=A0=
=A0=A0=A0 10.292|=A0=A0=A0=A0 32.992|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.012|=A0=
=A0=A0=A0 10.126|=A0=A0=A0=A0 43.656|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.952|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.795|=A0=
=A0=A0=A0=A0 9.898|=A0=A0=A0=A0 35.883|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.795|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.300|=A0=
=A0=A0=A0 10.257|=A0=A0=A0=A0 25.505|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.795|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.520|=A0=
=A0=A0=A0 10.345|=A0=A0=A0=A0 30.060|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.795|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.436|=A0=
=A0=A0=A0 10.449|=A0=A0=A0=A0 29.542|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.795|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.696|=A0=
=A0=A0=A0 10.416|=A0=A0=A0=A0 31.156|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.795|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.717|=A0=
=A0=A0=A0=A0 9.555|=A0=A0=A0=A0 28.782|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.717|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.699|=A0=
=A0=A0=A0=A0 8.686|=A0=A0=A0=A0 26.416|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.709|=A0=
=A0=A0=A0=A0 9.133|=A0=A0=A0=A0 28.300|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.770|=A0=
=A0=A0=A0=A0 8.661|=A0=A0=A0=A0 21.747|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.070|=A0=
=A0=A0=A0=A0 8.702|=A0=A0=A0=A0 24.411|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.999|=A0=
=A0=A0=A0=A0 9.570|=A0=A0=A0=A0 26.651|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.012|=A0=
=A0=A0=A0=A0 9.762|=A0=A0=A0=A0 23.934|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTT|=A0 00:00:22=A0 (periodic u=
ser-mode task, 1000 us period, priority 99)=0ARTH|----lat min|----lat avg|-=
---lat max|-overrun|---msw|---lat best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 4.=
045|=A0=A0=A0=A0 10.755|=A0=A0=A0=A0 25.207|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.881=
|=A0=A0=A0=A0 10.616|=A0=A0=A0=A0 35.510|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 =
0|=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.957|=A0=
=A0=A0=A0 10.166|=A0=A0=A0=A0 33.967|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.098|=A0=
=A0=A0=A0=A0 8.474|=A0=A0=A0=A0 31.830|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.893|=A0=
=A0=A0=A0 10.047|=A0=A0=A0=A0 40.204|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.123|=A0=
=A0=A0=A0 10.962|=A0=A0=A0=A0 28.047|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.063|=A0=
=A0=A0=A0 10.568|=A0=A0=A0=A0 30.244|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.972|=A0=
=A0=A0=A0 10.252|=A0=A0=A0=A0 32.785|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.012|=A0=
=A0=A0=A0=A0 8.707|=A0=A0=A0=A0 24.633|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.085|=A0=
=A0=A0=A0 10.229|=A0=A0=A0=A0 25.648|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.957|=A0=
=A0=A0=A0 10.179|=A0=A0=A0=A0 25.866|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.042|=A0=
=A0=A0=A0 10.191|=A0=A0=A0=A0 25.489|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.093|=A0=
=A0=A0=A0 10.560|=A0=A0=A0=A0 25.578|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.053|=A0=
=A0=A0=A0 10.838|=A0=A0=A0=A0 34.282|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.959|=A0=
=A0=A0=A0 10.409|=A0=A0=A0=A0 26.353|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.050|=A0=
=A0=A0=A0 10.396|=A0=A0=A0=A0 30.277|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.065|=A0=
=A0=A0=A0=A0 9.603|=A0=A0=A0=A0 27.381|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.949|=A0=
=A0=A0=A0 10.090|=A0=A0=A0=A0 31.560|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.073|=A0=
=A0=A0=A0 10.242|=A0=A0=A0=A0 24.941|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.083|=A0=
=A0=A0=A0=A0 9.204|=A0=A0=A0=A0 25.424|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 4.103|=A0=
=A0=A0=A0=A0 9.017|=A0=A0=A0=A0 38.196|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTT|=A0 00:00:43=A0 (periodic u=
ser-mode task, 1000 us period, priority 99)=0ARTH|----lat min|----lat avg|-=
---lat max|-overrun|---msw|---lat best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 4.=
068|=A0=A0=A0=A0=A0 9.702|=A0=A0=A0=A0 29.547|=A0=A0=A0=A0=A0=A0 0|=A0=A0=
=A0=A0 0|=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0ARTD|=A0=A0=A0=A0=A0 3.=
979|=A0=A0=A0=A0 10.494|=A0=A0=A0=A0 25.823|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.699|=A0=A0=A0=A0 58.446=0A^C---|-----------|-------=
----|-----------|--------|------|-------------------------=0ARTS|=A0=A0=A0=
=A0=A0 3.699|=A0=A0=A0=A0 10.088|=A0=A0=A0=A0 58.446|=A0=A0=A0=A0=A0=A0 0|=
=A0=A0=A0=A0 0|=A0=A0=A0 00:00:44/00:00:44=0A=0AThanks,=0ABruno=0A=0A=0A=0A=
=0A=0AEm Ter=E7a-feira, 25 de Fevereiro de 2014 7:04, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> escreveu:=0A =0AOn 02/25/2014 04:26 AM, =
Bruno Tunes de Mello wrote:=0A> Hi Gilles,=0A> The kernel is booting and I =
executed latency and xeno-test commands. The results are below.=0A=0AYou al=
so need this patch.=0A=0Adiff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/m=
m/cache-l2x0.c=0Aindex d9cb476..1e2c52d 100644=0A--- a/arch/arm/mm/cache-l2=
x0.c=0A+++ b/arch/arm/mm/cache-l2x0.c=0A@@ -41,7 +41,7 @@ static inline voi=
d cache_wait_way(void __iomem *reg, unsigned long mask)=0A{=0A=A0=A0=A0 /* =
wait for cache operation by line or way to complete */=0A=A0=A0=A0 while (r=
eadl_relaxed(reg) & mask)=0A-=A0=A0=A0 =A0=A0=A0 ;=0A+=A0=A0=A0 =A0=A0=A0 c=
pu_relax();=0A}=0A=0A#ifdef CONFIG_CACHE_PL310=0A@@ -136,6 +136,7 @@ static=
 void __l2x0_flush_all(void)=0A=A0=A0=A0 debug_writel(0x00);=0A}=0A=0A+#ifn=
def CONFIG_IPIPE=0Astatic void l2x0_flush_all(void)=0A{=0A=A0=A0=A0 unsigne=
d long flags;=0A@@ -157,6 +158,81 @@ static void l2x0_clean_all(void)=0A=A0=
=A0=A0 cache_sync();=0A=A0=A0=A0 spin_unlock_irqrestore(&l2x0_lock, flags);=
=0A}=0A+#else=0A+static void l2x0_clean_inv_line_idx(unsigned line, unsigne=
d way)=0A+{=0A+=A0=A0=A0 void __iomem *base =3D l2x0_base;=0A+=0A+=A0=A0=A0=
 writel_relaxed((way << 28) | (line << 5), =0A+=A0=A0=A0 =A0=A0=A0 base + L=
2X0_CLEAN_INV_LINE_IDX);=0A+=A0=A0=A0 cache_wait(base + L2X0_CLEAN_INV_LINE=
_IDX, 1);=0A+}=0A+=0A+static void l2x0_flush_way(unsigned way, unsigned len=
, unsigned lines)=0A+{=0A+=A0=A0=A0 unsigned long flags;=0A+=A0=A0=A0 unsig=
ned line, i;=0A+=A0=A0=A0 =0A+=A0=A0=A0 for (line =3D 0; line < lines; line=
 +=3D len ) {=0A+=A0=A0=A0 =A0=A0=A0 spin_lock_irqsave(&l2x0_lock, flags);=
=0A+=A0=A0=A0 =A0=A0=A0 debug_writel(0x03);=0A+=A0=A0=A0 =A0=A0=A0 for (i =
=3D 0; i < len && line + i < lines; i++)=0A+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 l=
2x0_clean_inv_line_idx(line + i, way);=0A+=A0=A0=A0 =A0=A0=A0 cache_sync();=
=0A+=A0=A0=A0 =A0=A0=A0 debug_writel(0x00);=0A+=A0=A0=A0 =A0=A0=A0 spin_unl=
ock_irqrestore(&l2x0_lock, flags);=0A+=A0=A0=A0 }=0A+}=0A+=0A+static void l=
2x0_flush_all(void)=0A+{=0A+=A0=A0=A0 unsigned lines, len, way, ways;=0A+=
=0A+=A0=A0=A0 ways =3D fls(l2x0_way_mask);=0A+=A0=A0=A0 lines =3D l2x0_size=
 / (ways * CACHE_LINE_SIZE);=0A+=A0=A0=A0 len =3D L2X0_SPINLOCK_LEN / CACHE=
_LINE_SIZE;=0A+=0A+=A0=A0=A0 for (way =3D 0; way < ways; way++)=0A+=A0=A0=
=A0 =A0=A0=A0 l2x0_flush_way(way, len, lines);=0A+}=0A+=0A+static void l2x0=
_clean_line_idx(unsigned line, unsigned way)=0A+{=0A+=A0=A0=A0 void __iomem=
 *base =3D l2x0_base;=0A+=0A+=A0=A0=A0 writel_relaxed((way << 28) | (line <=
< 5), =0A+=A0=A0=A0 =A0=A0=A0 base + L2X0_CLEAN_LINE_IDX);=0A+=A0=A0=A0 cac=
he_wait(base + L2X0_CLEAN_LINE_IDX, 1);=0A+}=0A+=0A+static void l2x0_clean_=
way(unsigned way, unsigned len, unsigned lines)=0A+{=0A+=A0=A0=A0 unsigned =
long flags;=0A+=A0=A0=A0 unsigned line, i;=0A+=A0=A0=A0 =0A+=A0=A0=A0 for (=
line =3D 0; line < lines; line +=3D len ) {=0A+=A0=A0=A0 =A0=A0=A0 spin_loc=
k_irqsave(&l2x0_lock, flags);=0A+=A0=A0=A0 =A0=A0=A0 debug_writel(0x03);=0A=
+=A0=A0=A0 =A0=A0=A0 for (i =3D 0; i < len && line + i < lines; i++)=0A+=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 l2x0_clean_line_idx(line + i, way);=0A+=A0=A0=A0=
 =A0=A0=A0 cache_sync();=0A+=A0=A0=A0 =A0=A0=A0 debug_writel(0x00);=0A+=A0=
=A0=A0 =A0=A0=A0 spin_unlock_irqrestore(&l2x0_lock, flags);=0A+=A0=A0=A0 }=
=0A+}=0A+=0A+static void l2x0_clean_all(void)=0A+{=0A+=A0=A0=A0 unsigned li=
nes, len, way, ways;=0A+=0A+=A0=A0=A0 ways =3D fls(l2x0_way_mask);=0A+=A0=
=A0=A0 lines =3D l2x0_size / (ways * CACHE_LINE_SIZE);=0A+=A0=A0=A0 len =3D=
 L2X0_SPINLOCK_LEN / CACHE_LINE_SIZE;=0A+=0A+=A0=A0=A0 for (way =3D 0; way =
< ways; way++)=0A+=A0=A0=A0 =A0=A0=A0 l2x0_clean_way(way, len, lines);=0A+}=
=0A+#endif=0A=0Astatic void l2x0_inv_all(void)=0A=0A{=0A=0A-- =0A=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
