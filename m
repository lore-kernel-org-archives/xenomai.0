Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] xenomai return code numbers
Date: Wed, 20 Dec 2006 16:48:47 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB017A9426@domain.hid>
In-Reply-To: <490156.86642.qm@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

Well these are standard errno numbers, so you have to search them inside
standard header locations. Take a look into /usr/include/asm/errno.h
which will be included by /usr/include/errno.h


Best regards,

Daniel.
=09
=20
=20
=20

________________________________

From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
On Behalf Of mani bhatti
Sent: 20. desember 2006 16:34
To: xenomai@xenomai.org
Subject: [Xenomai-help] xenomai return code numbers


Hi=20
I need to know where i can find the values of xenomai return codes i,e
how can see what is the integer value for code -EBUSY or -EEXIST i dont
find them in documentation.Thanks.


__________________________________________________
Do You Yahoo!?
Tired of spam? Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


