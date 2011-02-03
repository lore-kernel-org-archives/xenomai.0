MIME-Version: 1.0
Date: Thu, 3 Feb 2011 10:57:04 +0200
Message-ID: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
From: Rudolf Meijering <rudolf@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba53a4ae1764d8049b5cf38a
Subject: [Xenomai-help] RT OS Selection advice for parallel processing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--90e6ba53a4ae1764d8049b5cf38a
Content-Type: text/plain; charset=ISO-8859-1

Hi,

We are in the process of developing a non-tracking safety Radar and would
really appreciate some guidance in selecting a real-time operating system
especially with the aim of offloading processing to a GPU. Can anyone share
their experience with real-time GPU offloading on either Xenomai or Realtime
Linux (PREEMPT_RT patch)? I have read reports on 900us delays with Nvidia
graphics drivers, has this been resolved?

Background:
The application basically requires the radar to output a disable
signal, within 100ms, when an object is detected. Radar data is received
every 1 ms and processed.

Platform: x86_64, most likely Intel i7 CPU
Total processing latency: 100ms
Interrupt frequency: 1KHz

>From what I can read both Xenomai and Realtime Linux should easily meet
these requirements, but what about RT GPU support?

Thanks a lot,
--
Rudolf Meijering

--90e6ba53a4ae1764d8049b5cf38a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>We are in the process of developing a non-tracking s=
afety Radar and would really appreciate some guidance in selecting a real-t=
ime operating system especially with the aim of offloading processing to a =
GPU.=A0Can anyone share their experience with real-time GPU offloading on e=
ither Xenomai or Realtime Linux (PREEMPT_RT patch)? I have read reports on =
900us delays with Nvidia graphics drivers, has this been resolved?</div>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><d=
iv><br></div><div>Background:</div><div>The application basically requires =
the radar to=A0output a disable signal,=A0within 100ms,=A0when an object is=
 detected. Radar data is received every 1 ms and processed.</div>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><d=
iv><br></div><div>Platform: x86_64, most likely Intel i7 CPU</div><div>Tota=
l processing latency: 100ms</div><div>Interrupt frequency: 1KHz</div><div><=
br>
</div><div>From what I can read both Xenomai and Realtime Linux should easi=
ly meet these requirements, but what about RT GPU support?</div><div><br></=
div><div>Thanks a lot,</div><div>--</div><div>Rudolf Meijering</div>

--90e6ba53a4ae1764d8049b5cf38a--

