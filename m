Message-ID: <537919DE.50303@zultron.com>
Date: Sun, 18 May 2014 15:36:46 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Cross-compiling for ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

My Debian kernel packages are just updated to Xenomai 2.6.3 and Linux 
3.8.13 (will ask for testing soon), and I'm starting to look at adding 
armhf packages using Robert C Nelson's and Charles Steinkuehler's patch 
sets.  However, I'm brand-new at cross-compiling and would appreciate a 
pointer.

Right out of the box, pbuilder can build in a QEMU-emulated chroot by 
setting --arch=armhf and --debootstrap=qemu-debootstrap.  Super easy. 
Super slow.

Is there a way to cross-compile in an x86 native environment so that the 
(x86 native) compiler/assembler/linker/etc. cross-build for ARM 
architecture?

	John

