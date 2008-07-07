Message-ID: <1215424051.4871e6334fba5@domain.hid>
Date: Mon, 07 Jul 2008 11:47:31 +0200
From: nourry@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] USB device with Hard Real Time
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

Hi All,
i wanted to know if anyone has ever used USB4RT Stack successfully with X=
enomai
?

At last, i think i've found the right DAQ device (cf DAQ system compatibi=
lty
subject), all driver sources and documentation are provided, and technica=
l
specifications meet our requirements.

here is the product : http://www.labjack.com/labjack_ue9.php
(it also works with Ethernet)

Now i have to be sure i can use USB with real time, latest README file in=
 USB4RT
package mention kernel 2.6.17, has anyone used it with more recent kernel
version ?

Can we find Adeos IPIPE patch for 2.6.17 ? I only found 2.6.25 or 24 on
repositories for x86, i also found 2.6.17 or 18 patch in a post by Ph. Ge=
rum but
i would prefer to find the official directory !

To Alex : can i show you the source drivers in order to discuss the porta=
bility
to Comedi over RTMD ?

Thanks to all and see you !
Antoine

