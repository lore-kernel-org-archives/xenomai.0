Message-ID: <4641BFE2.1090108@domain.hid>
Date: Wed, 09 May 2007 14:34:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705090155ma97b0et930b53336849a56f@domain.hid>	<4641951C.4020008@domain.hid>
	<7289437c0705090431x28f68aacxd4f28da514dff60c@domain.hid>
In-Reply-To: <7289437c0705090431x28f68aacxd4f28da514dff60c@domain.hid>
Content-Type: multipart/mixed; boundary="------------090000080404080606030201"
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090000080404080606030201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit

Perrine Martignoni wrote:
> On 5/9/07, *Gilles Chanteperdrix* <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>     Perrine Martignoni wrote:
>     > Hello,
>     >
>     > I've build a xenomai test application with Posix skin wich run on an
>     > ARM9. The application works well one time, and when I want to launch
>     > again my application, I have this error message :
>     >
>     >
>     > Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
>     > unavailable
>     >
>     >
>     >
>     > I think something was bad cancelled but I don't see.
> 
>     Resource temporarily unavailable is EAGAIN, it means that there is not
>     enough memory to create the real-time thread. Could you send us the
>     contents of /proc/xenomai/heap before and after running your
>     application  ?
> 
> I have exactly the same problem with cyclictest.
>  
> And here is the context of /proc/xenomai/heap before :
>  
> size=130560:used=64:pagesz=512
>  
> and after :
>  
> 
> size=130560:used=64:pagesz=512
> 
>  
> 
> It doesn't change.

Ok, I will check this at home, since the ARM I have at work behaves
differently.

If you have some spare time, could you apply the attached patch,
recompile the kernel, and run your application ? This patch prints in
the kernel console which step in pthread_setschedparam returns an error.

-- 
                                                 Gilles Chanteperdrix

--------------090000080404080606030201
Content-Type: text/x-patch;
 name="xeno-syscall-print-error.diff"
Content-Disposition: inline;
 filename="xeno-syscall-print-error.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: ksrc/skins/posix/syscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/syscall.c	(r=C3=A9vision 2429)
+++ ksrc/skins/posix/syscall.c	(copie de travail)
@@ -202,13 +202,19 @@
=20
 	err =3D pthread_create(&k_tid, &attr, NULL, NULL);
=20
-	if (err)
+	if (err) {
+		printk("pthread_create returned %d\n", err);
 		return ERR_PTR(-err);
+	}
=20
 	err =3D xnshadow_map(&k_tid->threadbase, NULL);
+	if (err)
+		printk("xnshadow_map returned %d\n", err);
=20
-	if (!err && !__pthread_hash(hkey, k_tid))
+	if (!err && !__pthread_hash(hkey, k_tid)) {
+		printk("pthread_hash returned NULL\n");
 		err =3D -EAGAIN;
+	}
=20
 	if (err)
 		pse51_thread_abort(k_tid, NULL);
@@ -244,8 +250,10 @@
 		/* If the syscall applies to "current", and the latter is not
 		   a Xenomai thread already, then shadow it. */
 		k_tid =3D __pthread_shadow(curr, &hkey);
-		if (IS_ERR(k_tid))
+		if (IS_ERR(k_tid)) {
+			printk("__pthread_shadow: %d\n", PTR_ERR(k_tid));
 			return PTR_ERR(k_tid);
+		}
=20
 		promoted =3D 1;
 	}

--------------090000080404080606030201--

