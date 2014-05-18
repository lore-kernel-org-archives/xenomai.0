Message-ID: <53792066.5050909@xenomai.org>
Date: Sun, 18 May 2014 23:04:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <537919DE.50303@zultron.com>
In-Reply-To: <537919DE.50303@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cross-compiling for ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>, xenomai@xenomai.org

On 05/18/2014 10:36 PM, John Morris wrote:
> My Debian kernel packages are just updated to Xenomai 2.6.3 and Linux 
> 3.8.13 (will ask for testing soon), and I'm starting to look at adding 
> armhf packages using Robert C Nelson's and Charles Steinkuehler's patch 
> sets.  However, I'm brand-new at cross-compiling and would appreciate a 
> pointer.
> 
> Right out of the box, pbuilder can build in a QEMU-emulated chroot by 
> setting --arch=armhf and --debootstrap=qemu-debootstrap.  Super easy. 
> Super slow.
> 
> Is there a way to cross-compile in an x86 native environment so that the 
> (x86 native) compiler/assembler/linker/etc. cross-build for ARM 
> architecture?

You need to install a cross compilation toolchain. You can find 
pre-built ones, for instance for armhf, you can use the linaro 
toolchain. Cross-compilation toolchain programs names begin with a 
string identifying the target architecture. For instance, linaro 
toolchain compiler is arm-linux-gnueabihf-gcc. In order to cross-
compile a kernel for this architecture, you whould use

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

For the user-space part you need to pass the prefix without the final 
dash to configure's --host option. As in:
./configure --host=arm-linux-gnueabihf

The installation procedure is described in README.INSTALL, see for
instance:
http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#arm


-- 
                                                                Gilles.

