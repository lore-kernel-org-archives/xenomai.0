Message-ID: <50EA9B9A.6000804@zultron.com>
Date: Mon, 07 Jan 2013 03:55:38 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Debian package build problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi list,

I encountered a couple of problems building packages for 2.6.2 when
following the instructions to build from git in this link:

http://www.xenomai.org/index.php/Building_Debian_packages

First, the autoconf-generated 'configure' script is checked into git.
When git-buildpackage cleans up, it removes the configure script, and
then bombs out when it finds uncommitted changes (i.e. the configure
script removed) in the git tree.  I hacked around it by committing a
'git rm configure' in my own tree, but don't have a more sophisticated
fix (is the configure script committed in git for a reason?).

Second, the kernel patch copying code in debian/rules is out of date.
It expects to find "adeos-ipipe-*.patch" in the top-level directory.
Here's a patch to copy the ipipe-core patch files from the
ksrc/arch/<arch>/patches/ directory instead.

One more problem when building the 3.2.21 kernel (I'm building 3.5.3
now, but since I have the fix, may as well report it).  The ipipe-core
patch introduces a syntax error in arch/x86/kernel/apic/io_apic.c,
breaking compile.  Here's a second patch to fix that.

Thanks-

	John
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xenomai-2.6.2-debian_rules_copy_kernel_patches.patch
Type: text/x-patch
Size: 1850 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130107/dff1e42=
e/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xenomai-2.6.2-ipipe_core_3.2.21_io_apic.c_compile.patch
Type: text/x-patch
Size: 632 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130107/dff1e42=
e/attachment-0001.bin>
