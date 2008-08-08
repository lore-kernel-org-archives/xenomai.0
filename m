Message-ID: <489CAECD.6080703@domain.hid>
Date: Fri, 08 Aug 2008 22:38:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <489C96FA.7050400@domain.hid>
In-Reply-To: <489C96FA.7050400@domain.hid>
Content-Type: multipart/mixed; boundary="------------010205070303040101050009"
Subject: Re: [Xenomai-help] Xenomai kernel user-space problem running
	testsuite
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Galea <michaelgalea@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010205070303040101050009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michael Galea wrote:
> I'm just starting with xenomai and am having troubles getting xenomai 
> user space to talk to my kernel.
> 
> I build the kernel and user-space xenomai code and try to run `latency` 
> from the test suite and get
> mpc8360mds:# /usr/local/xenomai/bin/latency
> Xenomai: incompatible feature set
> (required="fastsem", present="nofastsem", missing="fastsem").
> 
> 
> I have built xenomai from svn into my 2.6.26 powerpc kernel and it looks 
>   good on the next boot, i.e. `dmesg |grep xeno -i` returns:
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> 
> The user-space builds and installs over NFS just fine:
> 
> ./configure --host=ppc-unknown-linux-gnu --prefix=/usr/local/xenomai \
>    CC=ppc_6xx-gcc CXX=ppc_6xx-g++ LD=ppc_6xx-ld
> make
> make DESTDIR=/opt/ppcrootmds/ install
> 
> 
> I can't see any fastsem options in the kernel.  Does anyone have any 
> advice?

It is supposed to be set by the Kconfig, but it looks like I forgot to
add it, so, you may try the attached patch.

-- 


					    Gilles.

--------------010205070303040101050009
Content-Type: text/x-diff;
 name="xeno-powerpc-enable-kernel-fastsem.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-powerpc-enable-kernel-fastsem.diff"

Index: ksrc/arch/powerpc/Kconfig
===================================================================
--- ksrc/arch/powerpc/Kconfig	(revision 4080)
+++ ksrc/arch/powerpc/Kconfig	(working copy)
@@ -2,6 +2,10 @@ config XENO_GENERIC_STACKPOOL
 	bool
 	default y
 
+config XENO_FASTSEM
+	bool
+	default y
+
 source "kernel/xenomai/nucleus/Kconfig"
 
 menu "Machine"

--------------010205070303040101050009--

