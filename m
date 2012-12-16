Message-ID: <50CD8E87.2070906@xenomai.org>
Date: Sun, 16 Dec 2012 10:04:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] next xenomai release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: Xenomai <xenomai@xenomai.org>


Hi Roland,

the next release of Xenomai should happen soon. The changes which may
impact the Debian packaging are:
* changes in the configure script option, actually simplifications;
- --enable-smp is no longer needed on x86, powerpc and arm
- as a reminder, on the ARM architecture, passing --enable-arm-arch or
--enable-arm-eabi is not needed either since 2.6.0, so in fact, no
option is needed when running the configure script for the arm
architecture. Passing the correct -march to the CFLAGS is recommended to
generate optimized code, but starting with the future release, is not
even mandatory.
- this release support ARM user-space built with the thumb instruction
set (-mthumb added to the CFLAGS, or enabled by default in the toolchain
configuration)
* small changes in the documentation, we introduced some asciidoc (I
would have wanted to also move the manual pages to asciidoc, and update
them, but it will be for the next release), the visible change is that
an HTML version of the README.INSTALL and TROUBLESHOOTING files are now
installed by the "make install" command in the html directory.

I would also like to setup an apt repository to provide pre-compiled
kernels, at least for the x86 architecture (say, for instance, i486 UP,
i686 SMP, x86_64 SMP), as well as the user-space packages, so, would be
interested in documentation URLs.

Regards.

-- 
                                                                Gilles.

