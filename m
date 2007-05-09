Message-ID: <4641CD8B.8050309@domain.hid>
Date: Wed, 09 May 2007 15:32:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
In-Reply-To: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
Content-Type: multipart/mixed; boundary="------------010609030702050508020304"
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
To: "Noren, Andrew" <Andrew.Noren@domain.hid>, Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010609030702050508020304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit

Noren, Andrew wrote:
> Hi Gilles,
> 
> I too have encountered this issue with the POSIX skin.
> I think it may have to do with the order in which the posix skin hooks
> are run on thread deletion.
> 
> In ksrc/skins/posix/syscall.c
> xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);
> 
> and ksrc/skins/posix/thread.c
> xnpod_add_hook(XNHOOK_THREAD_DELETE, thread_delete_hook);
> 
> The thread_delete_hook seems to run first causing the thread data to be
> destroyed before __shadow_delete_hook has a chance to run.
> 
> This results in __shadow_delete_hook failing in various cases.
> 
> An example of an error case linked with this would be the failure to
> remove the thread key from the hash bucket after application exit.  The
> next run of an application can then result in pthread_setschedparam
> failing to create a shadow since it likely finds an id in the hash
> bucket already.

Hi,

thanks for pointing this out, I see other skins use xnfreesafe in their
thread deletion hook instead of xnfree. The attached patch fixes this.

Perrine, could you apply this patch and check that it solves your issue ?

-- 
                                                 Gilles Chanteperdrix

--------------010609030702050508020304
Content-Type: text/x-patch;
 name="xeno-posix-use-xnfreesafe.diff"
Content-Disposition: inline;
 filename="xeno-posix-use-xnfreesafe.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/thread.c	(r=C3=A9vision 2429)
+++ ksrc/skins/posix/thread.c	(copie de travail)
@@ -45,7 +45,7 @@
 	   called from pse51_thread_pkg_cleanup, hence the absence of
 	   xnpod_schedule(). */
 	xnsynch_destroy(&thread->join_synch);
-	xnfree(thread);
+	xnfreesafe(&thread->threadbase, thread, &thread->link);
 }
=20
 static void thread_trampoline(void *cookie)

--------------010609030702050508020304--

