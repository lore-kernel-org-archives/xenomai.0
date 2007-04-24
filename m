Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Apr 2007 15:14:24 +0200
Message-ID: <403B28AE6257B548B66BB88414AC78330174BBDF@STEGOSAURE.adetel.com>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BBDE@STEGOSAURE.adetel.com>
From: "BOUIN Alexandre" <abouin@domain.hid>
Subject: Re: [Adeos-main] New patch for AT91SAM9261 adeos support for 2.6.19
	kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


>It is a high.
by default, nucleus latency is set to 9342. I can diminish this value
to 323=B5s only. Is it possible I've done something wrong ? Is there
another way to reduce theses latencies ?

> You should get plenty of negative values.
I've sent you my histogram and I don't see any negative value.
Could you precise what was your thought ?

>What is your kernel configuration, do not you have some
statistics/debug options enabled ?
It is right : I've let some kernel debug options while performing these =
tests.
I change it right now.=20

Test was launched without any kernel debug options, and we got a worst
case of 197=B5s now.
Here is a sum up of our results :=20
[Board] : 			 AT91SAM9261EK
[Kernel version] : 	 2.6.19-at91-xenomai-adeos
[Clocks] : 			 CPU 198 MHz, master 99 MHz, main 18.432 MHz
[Nucleus latency] : 	 323=B5s
[Root] : 			 nfs
[Kernel debug options] : No
[Load Softwares] :	 calibrator + ping host + bonnie++
[Duration] : 		 > 15h
[Best Latency] : 		 45=B5s
[Average Latency] : 	 82.5=B5s
[Worst Latency] : 	 197=B5s

