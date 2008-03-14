From: "Frederik Bayart" <frederik.bayart@domain.hid>
Date: Fri, 14 Mar 2008 18:46:12 +0100
Message-ID: <000001c885fb$4b60cde0$e22269a0$@bayart@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: nl-be
Subject: [Xenomai-help] building xenomai kernel with debian packages
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hallo,

I try to build a xenomai kernel  using linux-source-2.6.22 and
linux-patch-xenomai on debian.
The adeos-ipipe-2.6.22-i386-1.10-12.patch.gz was not available in this
package but I downloaded it from gna.org, put it in the correct directory
and updated /usr/src/kernel-patches/i386/apply/xenomai.

The script /usr/src/kernel-patches/i386/apply/xenomai installs the patch
correctly but when I call make menuconfig I don't see the Real-time
sub-system menu.

I look into the apply/xenomai script, I see it's just applying patch -p1.
If you are checking out the source from svn and run the prepare-kernel
script, patch -p1 is executed but also additional things are done
(patch_append and patch_link calls).

These are not done in the apply/xenomai script, so I think this is the
reason that I don't see the Real-time sub-system menu. If I build the
patched kernel, the latency utility is not working (I installed also
xenomai-runtime and libxenomai1)

I like to use the debian packages. So what should I do to see the Real-time
sub-system menu in my kernel config using the debian packages ?

Frederik


