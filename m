From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Mon, 17 Dec 2012 09:45:47 +0100
References: <50CD8E87.2070906@xenomai.org> <50CDAD2C.8050209@antcom.de>
In-Reply-To: <50CDAD2C.8050209@antcom.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201212170945.47992.leo@alaxarxa.net>
Subject: Re: [Xenomai] next xenomai release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

A Diumenge 16 Desembre 2012, Roland Stigge va escriure:
> Hi Gilles,
> 
> On 16/12/12 10:04, Gilles Chanteperdrix wrote:
> > the next release of Xenomai should happen soon. The changes which may
> > impact the Debian packaging are:
> > * changes in the configure script option, actually simplifications;
> > - --enable-smp is no longer needed on x86, powerpc and arm
> > - as a reminder, on the ARM architecture, passing --enable-arm-arch or
> > --enable-arm-eabi is not needed either since 2.6.0, so in fact, no
> > option is needed when running the configure script for the arm
> > architecture. Passing the correct -march to the CFLAGS is recommended to
> > generate optimized code, but starting with the future release, is not
> > even mandatory.
> > - this release support ARM user-space built with the thumb instruction
> > set (-mthumb added to the CFLAGS, or enabled by default in the toolchain
> > configuration)
> > * small changes in the documentation, we introduced some asciidoc (I
> > would have wanted to also move the manual pages to asciidoc, and update
> > them, but it will be for the next release), the visible change is that
> > an HTML version of the README.INSTALL and TROUBLESHOOTING files are now
> > installed by the "make install" command in the html directory.
> 
> Thank you for the note! This really simplified my update in Debian.
> 
> I just tested a snapshot from git.xenomai.org (using xenomai-head.git
> and building a test tarball with ./configure && make dist) - looks good
> so far.

well,

there's a bug, and I must admit that I don't know if it's deliberated (*) or 
not.  This bug comes from some time ago. In the /ksrc/arch/x86/patches 
directory, there's a patch for the 3.2.21 kernel:

ipipe-core-3.2.21-x86-1.patch

this patch, in the build process is not included in the root directory: the 
/scripts/prepare-patch.sh script executes:

find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-*.patch" 

that is incorrect because the ipipe-core* patch is not found. The correct one 
would be:

----------------------------------------------------------------
$ diff -u xenomai-2.6.git/scripts/prepare-patch.sh xenomai-
head/scripts/prepare-patch.sh 
--- xenomai-2.6.git/scripts/prepare-patch.sh	2012-11-06 11:17:56.722698342 
+0100
+++ xenomai-head/scripts/prepare-patch.sh 	2012-12-17 09:23:31.912258850 
+0100
@@ -148,7 +148,7 @@
 
 cd $xenomai_root
 
-find $xenomai_root/ksrc/ -name "*ipipe*$supported_arch-*.patch" |
+find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-*.patch" |
 while read f ; do
 
     file=`basename $f`

----------------------------------------------------------------

so, please could you clarified if you put this patch or not?


(*) Deliberated in the way that maybe it's not sufficient stable yet to 
include it and upstream prefers to not include it by default.

> > I would also like to setup an apt repository to provide pre-compiled
> > kernels, at least for the x86 architecture (say, for instance, i486 UP,
> > i686 SMP, x86_64 SMP), as well as the user-space packages, so, would be
> > interested in documentation URLs.
> 
> For setting up an apt-repository, I recommend using the "reprepro"
> package (from Debian) which helps setting up and maintaining an apt
> repo. You just need to provide individual .deb, .changes, or .dsa files
> on the command line and it adds them automatically to our new repo. Just
> ask if you need assistance here.
> 
> For building the packages for this repo, you ideally just build the
> default Debian packages with dpkg-buildpackage and follow the
> instructions in
> 
> /usr/share/doc/linux-patch-xenomai/README.Debian
> 
> to build kernels.
> 
> There is also
> 
> http://www.xenomai.org/index.php/Building_Debian_packages
> 

I agree. 

Also, I can mirror the repo at my University.

Regards,

Leo


-- 
--
Linux User 152692
Catalonia

