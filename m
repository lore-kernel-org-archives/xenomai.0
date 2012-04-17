MIME-Version: 1.0
Date: Tue, 17 Apr 2012 18:18:21 +0200
Message-ID: <CAPQp7XwEmGDXw1hWQOosshfqHB-dXM1cy0SuVrK4F_CYbi2zSg@domain.hid>
From: Flavio Siotto <flavio.siotto@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8ff25142965cbd04bde24995
Subject: [Xenomai-core] [PATCH] a4l_init_time fix
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--e89a8ff25142965cbd04bde24995
Content-Type: text/plain; charset=ISO-8859-1

looking into the code of analogy I believe I have found a mistake,
am I wrong?

---
 ksrc/drivers/analogy/os_facilities.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/drivers/analogy/os_facilities.c
b/ksrc/drivers/analogy/os_facilities.c
index 791f524..f4d223a 100644
--- a/ksrc/drivers/analogy/os_facilities.c
+++ b/ksrc/drivers/analogy/os_facilities.c
@@ -40,7 +40,7 @@ void a4l_init_time(void)
     t1 = a4l_get_rawtime();
     do_gettimeofday(&tv);
     t2 = 1000000000 * ((nanosecs_abs_t)tv.tv_sec) +
-        1000000 * ((nanosecs_abs_t)tv.tv_usec);
+        1000 * ((nanosecs_abs_t)tv.tv_usec);
     a4l_clkofs = t2 - t1;
 }

-- 
1.7.1

--e89a8ff25142965cbd04bde24995
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span lang=3D"en"><span>looking into</span> <span>the code</span> <span>of<=
/span> <span>analogy</span> <span>I</span> <span>believe I have</span> <spa=
n>found</span> <span>a mistake</span><span>,</span><br>
 <span></span><span>am I</span> <span>wrong</span><span>?<br><br>---<br>=A0=
ksrc/drivers/analogy/os_facilities.c |=A0=A0=A0 2 +-<br>=A01 files changed,=
 1 insertions(+), 1 deletions(-)<br>
<br>diff --git a/ksrc/drivers/analogy/os_facilities.c b/ksrc/drivers/analog=
y/os_facilities.c<br>index 791f524..f4d223a 100644<br>--- a/ksrc/drivers/an=
alogy/os_facilities.c<br>+++ b/ksrc/drivers/analogy/os_facilities.c<br>

@@ -40,7 +40,7 @@ void a4l_init_time(void)<br>=A0=A0=A0=A0 t1 =3D a4l_get_r=
awtime();<br>=A0=A0=A0=A0 do_gettimeofday(&amp;tv);<br>=A0=A0=A0=A0 t2 =3D =
1000000000 * ((nanosecs_abs_t)tv.tv_sec) +<br>-=A0=A0=A0 =A0=A0=A0 1000000 =
* ((nanosecs_abs_t)tv.tv_usec);<br>
+=A0=A0=A0 =A0=A0=A0 1000 * ((nanosecs_abs_t)tv.tv_usec);<br>
=A0=A0=A0=A0 a4l_clkofs =3D t2 - t1;<br>=A0}<br>=A0<br>-- <br>1.7.1<br><br>=
</span></span>

--e89a8ff25142965cbd04bde24995--

