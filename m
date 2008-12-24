From: Paul <paul_c@domain.hid>
Date: Wed, 24 Dec 2008 01:19:33 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_l4YUJg3npfuCFzr"
Message-Id: <200812240119.33232.paul_c@domain.hid>
Subject: [Xenomai-core] [PATCH] Minor correction to debian/control
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

--Boundary-00=_l4YUJg3npfuCFzr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


 Reviewing and updating one of my systems here, I noticed a copy/paste error 
in the debian/control - The short description is the same for both lib and 
dev packages. The $trivial patch attached addresses this. Both the 2.4.x 
branch and trunk suffer from the same error.


Regards, Paul.





--Boundary-00=_l4YUJg3npfuCFzr
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="debian_control.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian_control.diff"

Index: debian/control
===================================================================
--- debian/control	(revision 4493)
+++ debian/control	(working copy)
@@ -52,7 +52,7 @@ Depends: ${shlibs:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
-Description: Headers and static libs for Xenomai
+Description: Shared libraries for Xenomai
  Xenomai is a real-time development framework cooperating with the Linux
  kernel in order to provide a pervasive, interface-agnostic, hard real-time
  support to user-space applications, seamlessly integrated into the GNU/Linux

--Boundary-00=_l4YUJg3npfuCFzr--

