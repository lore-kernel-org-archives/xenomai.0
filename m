From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Cleanup after using the vxWorks skin?
Date: Sat, 21 Oct 2006 17:08:10 +0200
References: <200610211628.21249.niklaus.giger@domain.hid>
	<1161442353.5017.23.camel@domain.hid>
In-Reply-To: <1161442353.5017.23.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211708.11045.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Samstag, 21. Oktober 2006 16:52 schrieb Philippe Gerum:
> On Sat, 2006-10-21 at 16:28 +0200, Niklaus Giger wrote:
> > Hi
> >
> > I run a program using the vxworks skin from user space. As did hang, I
> > typed  "Ctrl-C" to end the program.
> >
> > Looking at /proc/xenomai/registry/vxworks/semaphores/ I remarked however,
> > that there were still vxworks semaphores open, which had not been
> > deleted.
> >
> > Is it up to the programmer to clean up at exit? Or is this a bug in the
> > current Xenomai implementation?
>
> It's not a bug, but rather a limitation. We don't currently support
> auto-cleanup of objects in the VxWorks skin.
Though what about applying a small patch like this?

Index: doc/txt/vxworks-skin.txt
===================================================================
--- doc/txt/vxworks-skin.txt    (Revision 1738)
+++ doc/txt/vxworks-skin.txt    (Arbeitskopie)
@@ -104,6 +104,9 @@
   taskDelete() which might need to wait for the deleted task to exit a
   safe section (taskSafe/taskUnsafe) before proceeding.

+- There is currently no support for auto-cleanup of objects in the VxWorks
+  skin.
+
 Module parameters
 =================


Best regards
-- 
Niklaus Giger

