Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 7 Mar 2008 17:26:08 +0100
Message-ID: <4E70056F9205354583FBC4273D5430FFF1AA2A@svr-exc-01.intern.wipotec.de>
From: "Laux Karsten-Olaf" <karsten-olaf.laux@domain.hid>
Subject: [Adeos-main] AT91SAM9263 and ipipe
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

I'm trying to get Linux with ipipe running on the AT91SAM9263EK board.

As basis, I am using the patched kernel-sources from TimeSys/Linuxlink =
contained in the free BSP-package. This in fact is a linux 2.6.20.11 =
kernel with added AT91SAM9263 support.

After applying the adeos-ipipe-2.6.20-arm-1.8-03.patch and after adding =
ipipe timer-support for the SAM9263 (alike the existing SAM9261 =
implementation), I can compile and run the kernel.

Everything looks fine so far: kernel starts, the device-drivers get =
initialized, root-fs gets mounted, init gets started ...
but then STOP.=20
No login appears on the serial console. USB disconnect events still get =
shown, but nothing else. Ethernet negotiation starts, but no =
success-message appears.


Has someone an idea, what is wrong here?


regards,
Karsten.






_____________________________________________________________________

Karsten-Olaf Laux=20
Electronic and Software Engineering OEM

Wipotec GmbH
Adam-Hoffmann-Str. 26=20
67657 Kaiserslautern

T +49.631.34146-0
F +49.631.34146-8640
http://www.wipotec.com

Legal information:
Wipotec Wiege- und Positioniersysteme GmbH
HRB 2317 Kaiserslautern, Management: T. D=C3=BCppre, U. Wagner

This e-mail may contain confidential and/or privileged information.=20
If you are not the intended recipient (or have received this e-mail in =
error)
please notify the sender immediately and delete this e-mail. Any =
unauthorized=20
copying, disclosure or distribution of the material in this e-mail is =
strictly=20
forbidden.


