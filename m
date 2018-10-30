Message-ID: <1540883612.2354.2.camel@smigroup.net>
Subject: [PATCH] copperplate/clockobj: prevent warning with -Wconversion
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Tue, 30 Oct 2018 08:13:32 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

make cast=C2=A0explicit to avoid warning when user code is compiled with
-Wconversion
---
=C2=A0include/copperplate/clockobj.h | 2 +-
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/copperplate/clockobj.h
b/include/copperplate/clockobj.h
index 8568794d9..063bcce90 100644
--- a/include/copperplate/clockobj.h
+++ b/include/copperplate/clockobj.h
@@ -136,7 +136,7 @@ void clockobj_ns_to_timespec(ticks_t ns, struct
timespec *ts)
=C2=A0{
=C2=A0	unsigned long rem;
=C2=A0
-	ts->tv_sec =3D cobalt_divrem_billion(ns, &rem);
+	ts->tv_sec =3D (__kernel_time_t)cobalt_divrem_billion(ns, &rem);
=C2=A0	ts->tv_nsec =3D rem;
=C2=A0}
=C2=A0
--=C2=A0
2.11.0

