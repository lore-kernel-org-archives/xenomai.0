Message-ID: <45D338C2.9030203@domain.hid>
Date: Wed, 14 Feb 2007 17:28:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD09C3BC4A96A0CE9B805203C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Extended CAN frame filtering
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD09C3BC4A96A0CE9B805203C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

unless I messed something up, the first patch aligns the implementation o=
f
Socket-CAN filters in Xenomai with their current specification. Right now=
, if you
set a filter on a standard frame ID, you will also receive extended frame=
s with
the same ID. In contrast, when the extended bit is set, only extended fra=
mes are
received, not standard frames with the same ID (that's again spec-conform=
ing).

--- ksrc/drivers/can/rtcan_raw_filter.c	(Revision 2178)
+++ ksrc/drivers/can/rtcan_raw_filter.c	(Arbeitskopie)
@@ -55,11 +55,11 @@ void rtcan_raw_print_filter(struct rtcan
 static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,
 					  can_filter_t *filter)
 {
-   if (filter->can_id & CAN_EFF_FLAG)
-	recv_filter->can_mask =3D ((filter->can_mask & CAN_EFF_MASK) |
-				 CAN_EFF_FLAG);
+    if (filter->can_id & CAN_EFF_FLAG)
+	recv_filter->can_mask =3D filter->can_mask & CAN_EFF_MASK;
     else
-	recv_filter->can_mask =3D (filter->can_mask & CAN_SFF_MASK);
+	recv_filter->can_mask =3D filter->can_mask & CAN_SFF_MASK;
+    recv_filter->can_mask |=3D CAN_EFF_FLAG;
=20
     recv_filter->can_id =3D filter->can_id & recv_filter->can_mask;
 }=20


However, I wonder if this behaviour is useful. You can now either set a f=
ilter
for extended frames or standard frame, not for both frame type, just vary=
ing on
the ID length. If we consider EFF just as another bit of the CAN ID, we c=
ould
take this into account for the mask:

--- ksrc/drivers/can/rtcan_raw_filter.c	(Revision 2178)
+++ ksrc/drivers/can/rtcan_raw_filter.c	(Arbeitskopie)
@@ -55,11 +55,12 @@ void rtcan_raw_print_filter(struct rtcan
 static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,
 					  can_filter_t *filter)
 {
-   if (filter->can_id & CAN_EFF_FLAG)
-	recv_filter->can_mask =3D ((filter->can_mask & CAN_EFF_MASK) |
-				 CAN_EFF_FLAG);
+    if (filter->can_id & CAN_EFF_FLAG)
+	recv_filter->can_mask =3D filter->can_mask &
+				(CAN_EFF_MASK | CAN_EFF_FLAG);
     else
-	recv_filter->can_mask =3D (filter->can_mask & CAN_SFF_MASK);
+	recv_filter->can_mask =3D filter->can_mask &
+				(CAN_SFF_MASK | CAN_EFF_FLAG);
=20
     recv_filter->can_id =3D filter->can_id & recv_filter->can_mask;
 }


Note: this alternative patch would also require a patch to rtdm/rtcan.h.

Actually, the second variant was what I intuitively expected. What is the=

behaviour of non-RT Socket-CAN here?

Jan


PS: A few lines above those hunks is still a "#if 0" code block. Either m=
ake
this configurable or please clean it up.



--------------enigD09C3BC4A96A0CE9B805203C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0zjCniDOoMHTA+kRAog2AKCDiA9lR3x/YTGxYDq9shKXVsZ+aACZAX3w
gJyfI2cTyDC5LGsZmstXmWU=
=CZPH
-----END PGP SIGNATURE-----

--------------enigD09C3BC4A96A0CE9B805203C--

