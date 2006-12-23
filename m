From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Patches: README.install & examples/common for
	cross-compiling
Date: Sat, 23 Dec 2006 22:19:20 +0100
References: <200612212259.06016.niklaus.giger@domain.hid>
	<458B8D26.4030407@domain.hid>
In-Reply-To: <458B8D26.4030407@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y1ZjF/btVFIYmIk"
Message-Id: <200612232219.20729.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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
Cc: xenomai@xenomai.org

--Boundary-00=_Y1ZjF/btVFIYmIk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Freitag, 22. Dezember 2006 08:45 schrieb Wolfgang Grandegger:
> Hi Niklaus,
>
> Niklaus Giger wrote:
> > Hi
> >
> > After switching my development environment to a MacMini and using the
> > ELDK 4.0 I discovered that my examples for building using a
> > cross-compiler for my PPC405 target were not correct. (Maybe a few of my
> > previous problems were caused by not correctly specifying the target
> > ARCH.)
> >
> > Also I would like to adapt and document the examples/common/Makefile to
> > the needs for cross-compiling (KSRC/XENOCONFIG/DESTDIR useage). Also I
> > added a target "install" to copy the generated application to
> > $(DESTDIR)/usr/xenomai.
>
> Hm, I don't have examples/common/Makefile in my SVN Xenomai tree. And
Added by revision 1970 only. Makefile came from Jan for my example 
hw_direct_io.
> /usr/xenomai should be the configurable.
Does the attached patch look better for you (using EXEC_PREFIX) ?

Best regards

-- 
Niklaus Giger

--Boundary-00=_Y1ZjF/btVFIYmIk
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="make.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="make.patch"

Index: examples/common/Makefile
===================================================================
--- examples/common/Makefile	(Revision 1980)
+++ examples/common/Makefile	(Arbeitskopie)
@@ -3,9 +3,9 @@
 ### List of applications to be build
 APPLICATIONS = hw_direct_io
 
-### Note: to override the search path for the xeno-config script, use "make XENO=..."
+### Note: to override the search path for the xeno-config script, use "make XENOCONFIG=..."
+### Note: if you installed it into a non standard place add DESTDIR=/path/to/installed/xenomai"
 
-
 ### List of modules to be build
 MODULES =
 
@@ -14,6 +14,8 @@
 
 ### Note: to override the kernel source path, use "make KSRC=..."
 
+# default place to install the resulting binaries
+EXEC_PREFIX := $(DESTDIR)/usr/xenomai/bin
 
 
 ###### USER SPACE BUILD (no change required normally) ######
@@ -24,7 +26,9 @@
 ### Sanity check
 ifeq ($(XENOCONFIG),)
 all::
-	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
+	@echo ">>> Invoke make like this: \"make XENOCONFIG=/path/to/xeno-config\" <<<"
+	@echo ">>> add KSRC=.. to override the default kernel source at /lib/modules/$(shell uname -r)/build <<<"
+	@echo ">>> add DESTDIR=/path/to/installed/xenomai if you installed it into a non standard place <<<"
 	@echo
 endif
 
@@ -40,6 +44,9 @@
 clean::
 	$(RM) $(APPLICATIONS) *.o
 
+install::   $(APPLICATIONS)
+	cp $(APPLICATIONS) $(EXEC_PREFIX)/
+
 endif
 
 
@@ -80,3 +87,4 @@
 	$(RM) -R .tmp*
 
 endif
+

--Boundary-00=_Y1ZjF/btVFIYmIk--

