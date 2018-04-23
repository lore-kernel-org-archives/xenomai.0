From: Lange Norbert <norbert.lange@andritz.com>
Date: Mon, 23 Apr 2018 09:02:43 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0F9C2@GRZSMS582.andritz.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [PATCH] add missing headers and casts,
	prefer POSIX definitions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Fix a few missing headers and casts

see http://man7.org/linux/man-pages/man2/bind.2.html
and http://man7.org/linux/man-pages/man2/open.2.html
and http://man7.org/linux/man-pages/man7/sigevent.7.html

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
demo/posix/cobalt/gpiopwm.c                  | 4 ++--
testsuite/smokey/posix-select/posix-select.c | 3 +++
2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/demo/posix/cobalt/gpiopwm.c b/demo/posix/cobalt/gpiopwm.c
index b34cbf1e1..eddd5cce5 100644
--- a/demo/posix/cobalt/gpiopwm.c
+++ b/demo/posix/cobalt/gpiopwm.c
@@ -219,7 +219,7 @@ static void *gpiopwm_udp_ctrl_thread(void *cookie)
           saddr.sin_port =3D htons(port);
           saddr.sin_family =3D AF_INET;
-           if (bind(sockfd, &saddr, sizeof(saddr)) < 0)
+          if (bind(sockfd, (struct sockaddr *)&saddr, sizeof(saddr)) < 0)
                       perror("bind");
            clen =3D sizeof(caddr);
@@ -230,7 +230,7 @@ static void *gpiopwm_udp_ctrl_thread(void *cookie)
                       print_config("UDP Server\n");
                        memset(buf,'\0', blen);
-                       ret =3D recvfrom(sockfd, buf, blen - 1, 0, &caddr, =
&clen);
+                      ret =3D recvfrom(sockfd, buf, blen - 1, 0, (struct s=
ockaddr *)&caddr, &clen);
                       if (ret < 0)
                                   perror("recvfrom");
diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smoke=
y/posix-select/posix-select.c
index 6bd88ddb5..e9bf938b3 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -30,6 +30,9 @@
#include <pthread.h>
#include <boilerplate/atomic.h>
#include <sys/select.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
#include <smokey/smokey.h>
 smokey_test_plugin(posix_select,
--
2.17.0

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
