From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Sat, 03 Jun 2006 00:41:19 +0200
Sender: wd@domain.hid
Message-Id: <20060602224119.9F22D353A57@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] Trivial patch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Please consider applying the following trivial patch:

Index: scripts/prepare-kernel.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/prepare-kernel.sh	(revision 585)
+++ scripts/prepare-kernel.sh	(working copy)
@@ -1,6 +1,8 @@
 #! /bin/bash
 set -e
=20
+unset CDPATH
+
 do_links() {
     ( if test -x $2; then
       cd $2 &&


This fixes a problem when you have CDPATH set in your  shell  -  then
bash  will  (under certain conditions) print the absolute pathname of
the new working directory on standard  output.  This  will  seriously
confuse constructs like   xenomai_root=3D`cd $xenomai_root && pwd`


Thanks.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Of course there's no reason for it, it's just our policy.

