MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18044.10013.180616.301594@domain.hid>
Date: Fri, 22 Jun 2007 21:46:37 +0200
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BC72@domain.hid>
References: <403B28AE6257B548B66BB88414AC78330174BC72@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Adeos-main] New I-pipe patch for ARM
	needs	testing.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

BOUIN Alexandre wrote:
 > Same tests but for AT91SAM9263-EK board :=20
 >  - one under DD load, latency set to 45=B5s
 >  - another one under Calibrator load, latency set to 30=B5s
 >  - and the last under Test_switch load, latency set to 45=B5s
 > Xeno-test traces are available and the end of this mail.
 >=20
 > We used kernel 2.6.20.13, Xenomai snapshot from 08/06/2007, adeos-ipipe-=
2.6.20-arm-1.7-03.patch included plus 2.6.20-at91.patch.
 >=20
 > A little correction on macb and ipipe patch was needed :=20
 >  - macb ethernet controler is not detected on startup
 >  - we added some corrections to make 9263 usable under ipipe
 >  - owing to changes in at91 patch (clk are now registered on startup) we=
 made a little correction for future adeos-ipipe-2.6.21-arm.patch.
 >=20
 > You will find all added patches attached to this mail.
 >  <<adeos-ipipe-2.6.20-arm-AT91.patch>>  <<2.6.20-at91-macb-9263.patch>> =
 <<adeos-ipipe-2.6.20-arm-AT91.patch>>=20
 > Latencies are a little worst than on other boards. We presume that it's =
due to the large number of peripherals.
 >=20
 > Our latency tests on AT91 boards are done ;)

That is great, thanks. Your patch will be merged into future patches
(ipipe for 2.6.21 or 2.6.22), where support for 9263 was merged.

About the latency issue, have you checked that it is not due to the
prioritized interrupt controller ?

--=20


					    Gilles Chanteperdrix.

