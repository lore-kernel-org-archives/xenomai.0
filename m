Date: Wed, 31 Oct 2007 15:41:06 +0100
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20071031154106.29f66afc@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] rt_task_inquire and NULL 2nd arg
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

Hello all,

I am testing some former programs with xenomai-2.4-rc4/kernel-2.6.23.1/pent=
iumM;

Calling rt_task_inquire(Id, NULL) with a null second argument now
freezes or reboots the pc...

I had no problem with this call with a former (2.3.1) xenomai version. Is i=
t a
known behaviour?

	Daniel
--=20

        Daniel SIMON   Projet NeCS  INRIA Rh=F4ne-Alpes
        Inovall=E9e, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
	 http://necs.inrialpes.fr/people/simon/

