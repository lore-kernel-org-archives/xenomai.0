Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
Date: Tue, 11 Jul 2006 14:50:10 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F936B@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

>=20
> Maybe the task is in fact killed by the OOM killer ? It would=20
> prove that this function is working correctly, since the=20
> killed task is the one that allocates all the memory. Is=20
> there no trace in the logs ?
>=20

Could not find a hint in the /var/log/messages from OOM killer. Nothing
that says : task xyz killed.

/var/log/messages :
Apr 25 09:44:03 arv0043 user.notice kernel: __alloc_pages: 0-order
allocation fa
iled (gfp=3D0x1f2/0)
Apr 25 09:44:11 arv0043 user.notice kernel: __alloc_pages: 0-order
allocation fa
iled (gfp=3D0x1f2/0)



