From: Paul <paul_c@domain.hid>
Date: Sat, 3 Feb 2007 13:13:20 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wpIxF5BwqPkNGfd"
Message-Id: <200702031313.20104.paul_c@domain.hid>
Subject: [Xenomai-core] rtdm over x86_64
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_wpIxF5BwqPkNGfd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hi Jan

 Just a small patch to get the ball rolling with an x86_64 support..

The attached resolves a compile time warning of:=20

kernel/xenomai/skins/rtdm/core.c: In function =E2=80=98_rtdm_ioctl=E2=80=99:
kernel/xenomai/skins/rtdm/core.c:408: warning: comparison is always false d=
ue=20
to limited range of data type


Regards, Paul.



--Boundary-00=_wpIxF5BwqPkNGfd
Content-Type: text/x-diff;
  charset="utf-8";
  name="rtdm_skin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtdm_skin.patch"

Index: include/rtdm/rtdm.h
===================================================================
--- include/rtdm/rtdm.h	(revision 2105)
+++ include/rtdm/rtdm.h	(working copy)
@@ -248,7 +248,7 @@ int     _rtdm_open   (rtdm_user_info_t *
 int     _rtdm_socket (rtdm_user_info_t *user_info, int protocol_family,
                       int socket_type, int protocol);
 int     _rtdm_close  (rtdm_user_info_t *user_info, int fd, int forced);
-int     _rtdm_ioctl  (rtdm_user_info_t *user_info, int fd, int request, ...);
+int     _rtdm_ioctl  (rtdm_user_info_t *user_info, int fd, unsigned int request, ...);
 ssize_t _rtdm_read   (rtdm_user_info_t *user_info, int fd, void *buf,
                       size_t nbyte);
 ssize_t _rtdm_write  (rtdm_user_info_t *user_info, int fd, const void *buf,
Index: ksrc/skins/rtdm/core.c
===================================================================
--- ksrc/skins/rtdm/core.c	(revision 2105)
+++ ksrc/skins/rtdm/core.c	(working copy)
@@ -393,7 +393,7 @@ do {                                    
 } while (0)
 
 
-int _rtdm_ioctl(rtdm_user_info_t *user_info, int fd, int request, ...)
+int _rtdm_ioctl(rtdm_user_info_t *user_info, int fd, unsigned int request, ...)
 {
     va_list args;
     void    *arg;

--Boundary-00=_wpIxF5BwqPkNGfd--

