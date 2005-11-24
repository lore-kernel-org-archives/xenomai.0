From: Stelian Pop <stelian@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 24 Nov 2005 15:14:10 +0100
Message-Id: <1132841651.27409.1.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] [PATCH 0/2] Adeos ARM/2.6 support
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi all,

I'm pleased to announce preliminary support for I-Pipe on ARM/2.6
kernels. I know quite a few people are waiting for this :)

The patch has been relatively well tested, using a hacked version
of RTAI 3.1 and running kernel space realtime threads only.

The port has been tested on an ARM Integrator/CP board with an
ARM1136 CPU coremodule. Support for other platforms (sa1100, pxa etc)
has not been integrated but it should be quite trivial to do so using
the code from the older 2.4 Adeos patches.

The only thing missing from this patch is complete exception support
(only access trap is catched right now). I'll be adding those while
porting Xenoma=EF over this patch in the next weeks.

While testing this patch on my board, very high latencies have been
observed (RTAI's latency tests shows 23 us min, 30 us avg and go as far
as 300 us under load). It is unclear at this moment if those latencies
are caused by:
	* intrinsic ARM cache problems [*]
	* a problem in the I-Pipe patch
	* hardware issues on my side.

Any idea on those latencies is welcomed, as are tests on other ARM
hardware.

In order to enhance readability I've splitted the generic and the
arch specific parts in two separate patches. The generic parts are
identical to those found in the latest PPC I-Pipe patch.

I'll post the patches as followups to this message. If the mailing list
has a size limit and rejects them, I'll put them as well on
http://www.popies.net/tmp/adeos/.

All feedbacks are welcomed.

Stelian.

[*]: see https://mail.rtai.org/pipermail/rtai/2005-April/011056.html
     and http://linuxdevices.com/articles/AT2598317046.html

--=20
Stelian Pop <stelian@domain.hid>


