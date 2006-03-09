Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Anybody Has Sample Code of Message Queue
	Performance Measurement in User Space for Xenomai Native Mode?
Date: Thu, 9 Mar 2006 10:56:52 -0800
Message-ID: <FA9961D07FD27B4EB6058C0F35F3D0D17CD9A3@domain.hid>
From: "Wu, John" <John.Wu@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Chau, Ngaiman" <Ngaiman.Chau@domain.hid>, xenomai@xenomai.org

Hi Philippe,

Thanks for the information.  Does the message queue API can only be used
between kernel sapce and user space only?  How about from user space
task to another user space task?=20

Regards,

John

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: Thursday, March 09, 2006 5:06 AM
To: Wu, John
Cc: xenomai@xenomai.org; Chau, Ngaiman
Subject: Re: [Xenomai-core] Anybody Has Sample Code of Message Queue
Performance Measurement in User Space for Xenomai Native Mode?

Wu, John wrote:
> We are in the process of calibrating Xenomai native API message queue=20
> performance  in user space application.  Does anybody has sample code=20
> to share with us?
>=20
>=20

Have a look at ksrc/skins/native/snippets/msg_queue.c.

> ----------------------------------------------------------------------
> --
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20

Philippe.

