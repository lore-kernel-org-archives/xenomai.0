Date: Mon, 28 Sep 2020 00:29:20 +0300
From: Vitaly Chikunov <vt@altlinux.org>
Subject: FYI: How I multy-library packaged Xenomai for ALT Linux
Message-ID: <20200927212920.hicjiffy323e4lo4@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

Maybe to review, maybe just FYI, there is how I packaged Xenomai for
ALT Linux in a multy-library way.

List of commits
    http://git.altlinux.org/people/vt/packages/?p=xenomai.git;a=shortlog;h=5aa47a414f
  including these 4 additional commits:
    `libs: Add linking dependencies to libcopperplate and libsmokey`
    `Multi-library support with core suffix in soname`
    `libs: Add linking dependency for libmodechk`
    `Fix building eth_p_all demo with Mercury core`
  (which I sent before here).

Full (RPM) spec:
    http://git.altlinux.org/people/vt/packages/?p=xenomai.git;a=blob;f=.gear/xenomai.spec;h=ce4cdc6c1a20b53;hb=5aa47a414f

Packages description:

1. xenomai - just top level wrapper `xeno` and `xeno-config` which will
call appropriate `xeno` and `xeno-config` from Xenomai depending on
which library is installed. If appropriate packages are installed it
will transparently use xeno or xeno-config from there, if not installed
or installed both versions it will suggest user what to do.

2. xenomai-cobalt - Cobalt runtime tools in /usr/lib/xenomai/cobalt/{bin,
     sbin,demo,testsuite}, rtnet, tdma configs in /etc, init.d service,
     udev rules, and appropriate man pages. This package adds xenomai
     group on install.
   xenomai-mercury - just a few Mercury tools in
     /usr/lib/xenomai/mercury/{bin/xeno,demo,sbin,testsuite}.

3. xenomai-devel-common - common part of headers in
  /usr/include/xenomai, plus dynlist.ld, bootstrap-pic.o, and bootstrap.o,
  because they need for both versions of cores.

4. libcobalt - just the libs (they are not suffixed, like Jan suggested);
   libcobalt-devel - Cobalt part of headers which include
                     /usr/include/xenomai/cobalt/xeno_config.h, also
		     /usr/lib/xenomai/cobalt/bin/wrap-link.sh and
		     /usr/lib/xenomai/cobalt/bin/xeno-config
		     libs symlinks and cobalt.wrappers, modechk.wrappers.
   libcobalt-devel-static - just the static libs.

5. libmercury - Mercury dynamic libs with "mercury" suffix.
   libmercury-devel - Mercury (boilerplate) headers with 
                      /usr/include/xenomai/mercury/xeno_config.h, and
		      /usr/lib/xenomai/mercury/bin/xeno-config
		      libs symlinks.
   libmercury-devel-static - just the static libs.

6. xenomai-doc - pdf, html, and demos. Demos are used for CI-like testing
    at build time (in %pre checkinstall).
    
7. libcobalt provides 'libxenomai1' name,
   xenomai-cobalt provides 'xenomai-runtime', and
   libcobalt-devel provides 'libxenomai-dev' - this is similar to Debian
     packaging. 

I also noticed some discrepancies:

  - there is `version` binary, but it cannot be run via `xeno` wrapper,
    because it's in sbin/.
  - PDFs are rebuilt again on `make install`, even though they are
    already built on `make`.
  - `doc/gitdoc` target doing strange things (looks like it wants to
    update documentation from git from the same repo (which is already
    checked out), but not actually doing any transfer). I just disabled
    that target.
  - wrap-link.sh is installed for Mercury but it does not needed.
  - there is only sysv init script, but in 2020 we also have systemd.
  - cobalt/testsuite/*.a libs are installed, but somehow conflict with
    dlopen tests (I forgot particular details, this was old change).
  - As said before, extended kernel-headers are needed to build some
    Cobalt examples, and user needs to figure out how on her own.

Thanks,



