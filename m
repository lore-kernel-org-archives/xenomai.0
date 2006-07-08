From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Yc1Af38wpC"
Content-Transfer-Encoding: 7bit
Message-ID: <17583.53208.1924.754643@domain.hid>
Date: Sat, 8 Jul 2006 17:31:36 +0200
Subject: [Xenomai-core] [patch] add documentation for configure
	--enable-linux-build option.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--Yc1Af38wpC
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi,

configure script --enable-linux-build option is not yet documented, here
is, for reviewn, a patch which attempts to fill this gap:

-- 


					    Gilles Chanteperdrix.

--Yc1Af38wpC
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-readme-enable-linux-build.diff"
Content-Transfer-Encoding: 7bit

Index: README.INSTALL
===================================================================
--- README.INSTALL	(revision 1315)
+++ README.INSTALL	(working copy)
@@ -18,13 +18,20 @@
 target kernel, or as loadable modules as with earlier versions.
 therefore, the usual Linux kernel configuration process will be
 normally used to define the various settings for the Xenomai kernel
-components.
+components. Sections 1.1 and 1.2 document the installation process 
+of this kernel space support.
 
 The src/ sub-tree contains the various user-space libraries and
 commands provided by the Xenomai framework. This tree can be built
 separately from the kernel support, even if the latter is absent from
-the build system.
+the build system. Section 1.3 subsections document the installation
+process of this user-space support.
 
+Finally, Xenomai build system also allow building a Xenomai patched 
+kernel as part of the user space support compilation process. Section 
+1.4 document this possibility.
+
+
 1. Installation steps
 ---------------------
 
@@ -189,6 +196,51 @@
 
 See sections 2.2, 2.3 and 2.4 for examples.
 
+1.4 Building the Linux kernel in the user-space support build tree
+------------------------------------------------------------------
+
+Having two build trees, one for the user space support and one for the
+kernel space support may be error prone, because some modifications
+require rebuilding both trees and one easily forget to rebuild the
+kernel space support. In order to cope with this issue, Xenomai allow 
+to build the kernel space support in a subdirectory of the user space 
+support build tree.
+
+In order to enable this functionality, pass to the user space support 
+configure script the option:
+--enable-linux-build=$linux_tree 
+where $linux_tree is the path to a Linux kernel source tree to be 
+copied.
+
+The configure script then create a Linux kernel source tree in the 
+"linux" sub-directory of the build directory, where all files are 
+symbolic links to the files of the $linux_tree source tree. The 
+prepare-kernel script is then called with the correct --linux, --arch 
+and --adeos parameters.
+
+Then, "make xconfig", "make menuconfig", "make oldconfig" allow to 
+configure the Linux kernel; each time "make" is run at the build tree 
+top, the Linux kernel and modules are rebuilt if needed, and when
+"make install" is run, the Linux kernel and modules are installed. If
+a DESTDIR variable is passed with "make install", the Linux kernel and 
+modules are installed under the directory $DESTDIR. Other targets of 
+the Linux build system are accessible by prefixing them with linux/, 
+for example running make linux/help run "make help" in the Linux tree.
+
+See section 2.5 for an example.
+
+When re-running configure in the build tree with a different parameter
+passed to --enable-linux-build, or if the Adeos patch version changed
+in the source tree (for example, as the result of running svn update),
+configure will display the following message:
+*** Warning: built version of linux and requested versions are
+*** different. If you want to build the requested version of
+*** linux, remove the file: linux/.xenomai-prepared.
+
+Removing the linux/.xenomai-prepared file and running make again 
+should be enough to compile the new Linux kernel version with the
+same configuration.
+
 2. Typical installation procedures
 ----------------------------------
 
@@ -279,3 +331,17 @@
 You may also want to have a look at this hands-on description about
 configuring and building a Xenomai system for the Blackfin
 architecture: http://docs.blackfin.uclinux.org/doku.php?id=adeos
+
+2.5 Building for x86 with the --enable-linux-build option
+---------------------------------------------------------
+
+Build the Linux kernel as part of the user space support build process:
+
+$ mkdir $build_root && cd $build_root
+$ $xenomai_root/configure --enable-linux-build=$linux_tree --enable-x86-sep
+$ make xconfig/gconfig/menuconfig # select the kernel and Xenomai options
+$ make install
+
+When "make install" is finished, you should find the patched kernel installed
+in /boot, its module under /lib/modules, and Xenomai user-space libraries
+and tools under /usr/xenomai.

--Yc1Af38wpC--

