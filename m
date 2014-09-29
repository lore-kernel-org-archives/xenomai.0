From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Mon, 29 Sep 2014 14:59:55 +0000
Message-ID: <D04EDD17.190CB%shartmann@cnt.canon.com>
References: <5423F8E3.3060006@xenomai.org>
In-Reply-To: <5423F8E3.3060006@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <86930665C790464BBD9977AAD1EE17D7@mex06.mlsrvr.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

Just FYI, When following the directions to build debian packages, the
debian packages are named with 2.6.3 filenames rather than the expected
2.6.4.

Regards,

Steven

On 9/25/14 6:13 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

>Hi,
>
>I have just made available Xenomai 2.6.4 at the usual address:
>http://download.gna.org/xenomai/stable/xenomai-2.6.4.tar.bz2
>
>This release mainly fixes bugs, and do not add many new functionalities,
>I guess because we are busy preparing xenomai 3.0:
>- support for I-pipe patch for 3.14 with a performance improvement on
>ARM Cortex A9, and support for the OMAP L138 processor;
>- disabling of C1E state on recent Intel processors
>- support for powerpc SPE
>- various improvements of the Debian packaging, notably support for the
>armhf architecture and addition of a debug package
>- clarification of the licenses, now every source file should have a
>license header
>- removal of the docbook documentation, as this documentation is now
>available on the website
>
>Thanks for all contributions.
>Regards.
>
>The shotlog follows:
>Alexandre Coffignal (1):
>      rtcan_flexcan: fix devtype_data initialization
>
>Christophe Blaess (1):
>      tests/cyclictest: add histogram option
>
>Erhart Robert (CC-DA/ESR3) (1):
>      analogy: fix fault in proc read callback
>
>Gilles Chanteperdrix (32):
>      doc: fix asciidoc documentation cross-references
>      doc: regenerate
>      license: provide for missing headers
>      licenses: jumbo update
>      hal/arm: avoid using VFP instructions on SOCs without VFP
>      skins/posix: make hardcoded constants configurable
>      arm/hal: fix compilation with old kernels
>      drivers/flexcan: avoid unaligned access
>      debian: add pkg-config files to libxenomai-dev package
>      skins/psos+: align message queues buffers
>      tests: fix typo supress -> suppress
>      nucleus/synch: fix rescnt imbalance on slow mutexes
>      hal/arm: adapt context switch to Linux 3.11+
>      debian: do not remove/regenerate configure file
>      debian: add support for powerpcspe
>      hal/arm: open code xnarch_atomic_clear_mask
>      posix: fix 2.4 config file
>      hal/x86: add C1E state workaround
>      bootstrap
>      README.INSTALL: fix ARM instructions
>      doc/install: ixp4xx has a kuser tsc now
>      ksrc: use curr as name for current thread variable
>      ksrc: fix dereference of dangling pointer
>      analogy: fix undefined referencces
>      arm: fix compilation issue with --enable-debug
>      doc: remove docbook documentation
>      vfile/snapshot: avoid starvation by spinning 1us after every
>iteration
>      xnlock: add missing barriers
>      hal/arm: update Freescale Linux fork patch
>      hal: upgrade I-pipe patches
>      build: bump version number and bootstrap
>      doc: regenerate
>
>Henri Roosen (1):
>      wrappers/arm: map I/O ranges without cache
>
>Jan Kiszka (2):
>      x86: Remove bogus test for x86-32 around xsave assembly
>      posix: Flush print buffer on fclose
>
>Lars Steubesand (1):
>      rtipc/iddp: fix inverted arguments to __iddp_alloc_mbuf()
>
>Paul Corner (6):
>      Use devices target to install udev rules in libxenomai1 package.
>This also installs device nodes in /dev for systems not running udev.
>      debian: Include /dev in the list of directories for libxenomai1
>      debian: add armhf architecture
>      Trivial spelling correction for the word 'implicitly'
>      debian: Add debug packages for library and runtime.
>      build: Minor fix for missing variable reference.
>
>Paul Janzen (1):
>      hal/x86: Export symbol rthal_c1e_disable
>
>Philippe Gerum (19):
>      powerpc: sanitize SPE handling
>      posix, vrtx: catch unexpected sync errors with thread trampoline
>      psos: fix auto-cleanup support
>      psos/rn: fix bad interrupt state during cleanup
>      native: fix interrupt state corruption in auto-cleanup
>      vxworks: fix interrupt state corruption in auto-cleanup
>      asm-generic/wrappers: assume generic hardirq supported for v3.12+
>      nucleus/seqlock: fix seqlock initializer
>      hal/powerpc: fixup fpu save/restore helpers for v3.12+
>      hal/x86: fixup reference to fpu info for v3.13+
>      native/task: silence UMR warning
>      hal/x86: fix wrong conditional
>      asm-generic/wrappers: fix wrong conditional
>      analogy/device: sanitize device release handler
>      nucleus/thread: fix leakage of XNKICKED status
>      rtipc/xddp: fixup XDDP documentation
>      rtdm: fix mapping address translation for MMU-less platforms
>      rtipc: fix address reset in connect()
>      rtipc: fix error code for send through non-connected socket
>
>Romain Naour (2):
>      arm: enable armv5tej support
>      posix: fix build failure when HAVE_OPEN64 is undefined.
>
>Stefan Roese (1):
>      hal/arm: Add Zynq v3.5.7 patches
>
>Wolfgang Grandegger (1):
>      rtcan: add missing license terms
>
>
>
>--=20
>                                                                Gilles.
>
>_______________________________________________
>Xenomai mailing list
>Xenomai@xenomai.org
>http://www.xenomai.org/mailman/listinfo/xenomai


