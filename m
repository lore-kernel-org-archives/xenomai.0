Message-ID: <5169643D.9020207@xenomai.org>
Date: Sat, 13 Apr 2013 15:57:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Debian: reworking kernel package generation.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

currently, the kernel packages for the Debian distribution are generated
the following way:

during compilation of the xenomai source package, static patches with
both Xenomai and I-pipe are generated for all the I-pipe patches in
Xenomai sources, using the "prepare-patch.sh" script, then put into the
"linux-patch-xenomai" package.

In the past, in order to compile a kernel with Xenomai enabled, this
package needed to be installed in addition to a kernel source package,
the DKMS system would then probably automate the patching and the user
would have to run "make-kpkg" to have a kernel automagically generated.

The drawback of this approach is the double maintenance issue caused by
having a "prepare-patch" script which does almost the same thing, but
not really, as the "prepare-kernel" script, and breaks regularly when
preper-kernel is modified, but the advantage was the simplicity and
maybe outweighted the drawback.

Today, DKMS is no longer in use, so after installing the
"linux-patch-xenomai" package,  patches have to be applied by hand, so
this whole approach brings little value compared to running directly the
"prepare-kernel.sh" script, and limits the compilation of Debian
packages to only those I-pipe patches that were provided at package
compilation time.

So, I propose to:
- remove the generation of the linux-patch-xenomai kernel
- remove the prepare-patch script
- require people who want to compile xenomai kernels to install the
xenomai source package and run prepare-kernel.sh script, and change the
installation instructions in accordance with this new approach.

If nobody is opposed to this approach, I will make the modifications in
the next few weeks for the 2.6.3 release.

Regards.

-- 
                                                                Gilles.

