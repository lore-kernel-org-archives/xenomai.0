From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 18 Sep 2014 09:53:46 -0400
Message-ID: <20140918135346.GN17690@csclub.uwaterloo.ca>
References: <20140905184346.GN17690@csclub.uwaterloo.ca>
 <201409052226.00161.paul_c@tuxcnc.org>
 <540B091C.8060604@xenomai.org>
 <201409061616.46205.paul_c@tuxcnc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201409061616.46205.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] How to get debug symbols in xenomai libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

On Sat, Sep 06, 2014 at 04:16:45PM +0100, Paul wrote:
> On Saturday 06 September 2014, Gilles Chanteperdrix wrote:
> > On 09/05/2014 11:25 PM, Paul wrote:
> > > On Friday 05 September 2014, Gilles Chanteperdrix wrote:
> > >> On 09/05/2014 11:15 PM, Lennart Sorensen wrote:
> > >>> On Fri, Sep 05, 2014 at 11:04:35PM +0200, Gilles Chanteperdrix
> > >
> > > wrote:
> > >>>> On 09/05/2014 11:03 PM, Lennart Sorensen wrote:
> > >>>>> On Fri, Sep 05, 2014 at 10:57:10PM +0200, Gilles Chanteperdrix
> > >
> > > wrote:
> > >>>>>> On 09/05/2014 10:54 PM, Lennart Sorensen wrote:
> > >>>>>>> On Fri, Sep 05, 2014 at 10:31:35PM +0200, Gilles
> > >>>>>>> Chanteperdrix
> > >
> > > wrote:
> > >>>>>>>> Just tried a fresh build with minimal flags, simply:
> > >>>>>>>>
> > >>>>>>>> configure --enable-debug CFLAGS="-fomit-frame-pointer"
> > >>>>>>>> --host=arm-linux-gnueabihf
> > >>>>>>>> make
> > >>>>>>>> arm-linux-gnueabihf-gdb
> > >>>>>>>> src/skins/common/.libs/libxenomai.so.0.0.0
> > >>>>>>>>
> > >>>>>>>> and gdb says it can find symbols. (-fomit-frame-pointer is
> > >>>>>>>> needed with the toolchain I use, otherwise gcc complains
> > >>>>>>>> that it can not use the r7 register).
> > >>>>>>>
> > >>>>>>> I tried adding that option, and still gdb says no symbols.
> > >>>>>>>
> > >>>>>>> Toolchain is debian wheezy's gcc 4.6, and everything is
> > >>>>>>> natively compiled.
> > >>>>>>
> > >>>>>> Do you build the package manually, like I just did? Or do you
> > >>>>>> use the debian/rules stuff?
> > >>>>>
> > >>>>> I use the debian/rules, but I set
> > >>>>> DEB_CFLAGS_APPEND=-fomit-frame-pointer and I added
> > >>>>> --enable-debug to the configure line in debian/rules and I set
> > >>>>> DEB_BUILD_OPTIONS=nostrip
> > >>>>
> > >>>> Could you try a manual build?
> > >>>
> > >>> That makes installing such a pain and the gcc lines had all the
> > >>> right arguments (-g -fomit-frame-pointer etc).  And we did want
> > >>> to debug with as close to the normal runtime build as possible.
> > >>
> > >> You do not need to run "make install"
> > >> Just run configure --enable-debug
> > >> Then make
> > >> Then try gdb on the compiled libxenomai.so.0.0.0
> > >>
> > >> There are two layers of Makefileries, thee aim is to find where
> > >> the problem is coming from, not to use this as a solution.
> > >
> > > dh_strip in debian/rules is the guilty party here - It is
> > > responsible for stripping debug symbols from binary executables and
> > > libraries.
> >
> > I am not sure this is the issue, since Lennart passes the "nostrip"
> > directive, and says that the file utility says that the libraries are
> > not stripped.
> 
> Apologies - Missed the bit about passing nostrip via DEB_BUILD_OPTIONS.
> 
> > Anyway, packages like libc6 have debug symbols in a separate package
> > from the main binary package. Is this complicated to achieve?
> 
> Very simple to achieve. The bulk of it is a cut'n'paste job in 
> debian/control plus a couple of lines in debian/rules. Please see 
> attached patch.
> 
> 
> Regards, Paul.
> 

> From 2680ee4171ef29770a6aa275aa2576c20cc7bd79 Mon Sep 17 00:00:00 2001
> From: Paul Corner <paul_c@tuxcnc.org>
> Date: Sat, 6 Sep 2014 16:08:39 +0100
> Subject: [PATCH] Add debug packages to debian for library and runtime
>  packages.
> 
> ---
>  debian/control | 29 +++++++++++++++++++++++++++++
>  debian/rules   |  6 ++++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/debian/control b/debian/control
> index 56fe0b1..a15adbe 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -24,6 +24,21 @@ Description: Xenomai runtime utilities
>   This package contains the runtime programs and the testsuite for the Xenomai
>   realtime system.
>  
> +Package: xenomai-runtime-dbg
> +Section: debug
> +Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
> +Depends: xenomai-runtime (=${binary:Version}), ${misc:Depends}
> +Description: debugging symbols for Xenomai runtime utilities
> + Xenomai is a real-time development framework cooperating with the Linux
> + kernel in order to provide a pervasive, interface-agnostic, hard real-time
> + support to user-space applications, seamlessly integrated into the GNU/Linux
> + environment. Xenomai provides its own API and emulation layers ("skins") to
> + make migration from other RTOS easier. Examples are: pSOS+, VxWorks, VRTX,
> + uiTRON, RTAI, POSIX.
> + .
> + This package contains the debug symbols for the runtime programs and testsuite
> + for Xenomai realtime system.
> +
>  Package: xenomai-kernel-source
>  Section: kernel
>  Architecture: all
> @@ -62,6 +77,20 @@ Description: Shared libraries for Xenomai
>   .
>   This package contains the shared libraries.
>  
> +Package: libxenomai1-dbg
> +Section: debug
> +Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
> +Depends: libxenomai1 (=${binary:Version}), ${misc:Depends}
> +Description: Debugging symbols for libxenomai1
> + Xenomai is a real-time development framework cooperating with the Linux
> + kernel in order to provide a pervasive, interface-agnostic, hard real-time
> + support to user-space applications, seamlessly integrated into the GNU/Linux
> + environment. Xenomai provides its own API and emulation layers ("skins") to
> + make migration from other RTOS easier. Examples are: pSOS+, VxWorks, VRTX,
> + uiTRON, RTAI, POSIX.
> + .
> + This package contains the debug symbols for libxenomai1.
> +
>  Package: libxenomai-dev
>  Section: libdevel
>  Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
> diff --git a/debian/rules b/debian/rules
> index a91958f..edcd265 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -16,7 +16,8 @@ DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
>  CONFIG_OPTS = --prefix=/usr \
>              --includedir=/usr/include/xenomai \
>              --mandir=/usr/share/man \
> -	    --with-testdir=/usr/lib/xenomai/testsuite
> +	    --with-testdir=/usr/lib/xenomai/testsuite \
> +	    --enable-debug
>  
>  ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
>  	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
> @@ -99,7 +100,8 @@ binary-arch: build install
>  	dh_installdocs -s -A CREDITS README.INSTALL TROUBLESHOOTING
>  	dh_link -s
>  	dh_installchangelogs -s
> -	dh_strip -s
> +	dh_strip -pxenomai-runtime --dbg-package=xenomai-runtime-dbg
> +	dh_strip -plibxenomai1 --dbg-package=libxenomai1-dbg
>  	dh_compress -s
>  	dh_fixperms -s
>  	dh_makeshlibs -s

That seems to work great.  Thanks.

-- 
Len Sorensen

