Message-ID: <4D7E829F.4060106@domain.hid>
Date: Mon, 14 Mar 2011 22:03:27 +0100
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] event from rt to nrt
Reply-To: johann.obermayr@domain.hid
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

Hello,

is there a way to pulse a event from a high prio task to
a event_wait in a rt-task (prio=3D0) without domain switch ?
rt_event_wait only work in primary domain. is there a other way ?

Thanks

   Xenomai 2.5.6, linux kernel 2.6.32.15. gcc 4.3.3

--=20
Mit freundlichen Gr=FC=DFen, best regards
     Johann Obermayr

Software Entwicklung
________________________________________________
SIGMATEK GmbH&  Co KG
Sigmatekstra=DFe 1
5112 Lamprechtshausen
=D6sterreich / Austria

Tel.  :  +43 / 6274/ 43 21-0   (Durchwahl leider nicht m=F6glich)
Fax   :  +43 / 6274/ 43 21-18  (bzw 300 im Werk 2 )
E-Mail: johann.obermayr@domain.hid
http://www.sigmatek-automation.com
****************************Please note:********************************
  This email and all attachments are confidential and intended solely for
  the person or entity to whom it is addressed. If you are not the named
  addressee you must not make this email and all attachments accessible
  to any other person. If you have received this email in error please
  delete it together with all attachments.
************************************************************************


