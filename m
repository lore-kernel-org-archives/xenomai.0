Message-ID: <531ADD8C.6090802@xenomai.org>
Date: Sat, 08 Mar 2014 10:06:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADoY7i-=m7VYrr8VqihSOS9LNPpQGCkXE5ttR6wo+rTevQEymg@mail.gmail.com>
In-Reply-To: <CADoY7i-=m7VYrr8VqihSOS9LNPpQGCkXE5ttR6wo+rTevQEymg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] imx6dl -- setup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Newell Jensen <newell.jensen@gmail.com>
Cc: xenomai@xenomai.org

On 03/08/2014 03:24 AM, Newell Jensen wrote:
> All,
> 
> First off I want to say hello.  I am new to this list and I am hoping that
> someone might be able to point me in the direction to many of the questions
> that I have.
> 
> Background on my situation:
> 
> 1. Target machine: imx6dl-sabresd (not imx6q) development board from
> Freescale.
> 2. Host machine: Linux debian 3.2.0-4-amd64 #1 SMP Debian 3.2.54-2 x86_64
> GNU/Linux
> 3.
> CROSS_COMPILE=/opt/freescale/usr/local/gcc-4.6.2-glibc-2.13-linaro-multilib-2011.12/fsl-linaro-toolchain/bin/arm-none-linux-gnueabi-
> 4. I would like to install Xenomai on Linux for hard real time requirements
> with SMP.
> 
> The link below makes mention that Xenomai doesn't work with 3.0.35 because
> it doesn't have support for SMP.
> 
> https://community.freescale.com/docs/DOC-97974
> 
> Because of this I have been thinking that I would need to get a higher
> version kernel since we need SMP to work on our system.  However, since I
> have an imx6dl-sabresd board I need at least the 3.10 kernel instead of a
> 3.8 kernel because u-boot wants the device tree blob file
> imx6dl-sabresd.dtb, which from what I can tell isn't possible until
> imx6dl-sabresd.dts makes its way into the kernel.
> 
> I have hope though, as I read that 3.10 patches are not included in Xenomai
> 2.6.3 but that they can *work* with 3.10 kernels.
> 
> Questions:
> 
> 1. Are there any specific kernel and patch set combinations that I could
> use to get Xenomai installed on an imx6dl-sabresd board?
> 2. If so, which specific kernel, patches, and other versions of the tools
> should I use?
> 
> I feel that I have the know-how to get this working but trying every
> possible combination with only slightly educated guesses wastes time and I
> hate doing that.
> 
> I appreciate any help that I receive.

Xenomai 2.6.3 should work with all the I-pipe patches up to the ones for 
the 3.10 kernel, including those for the Freescale kernel 3.0.35. So, 
you have the choice between using the freescale 3.0.35 kernel, or mainline 
linux 3.10.

In order to use xenomai with fsl 3.0.35, see README.INSTALL and 
ksrc/arch/arm/patches/READDME in xenomai 2.6.3 sources. You will need
two further patches which were posted on this list:
http://git.xenomai.org/ipipe-gch.git/commit/?h=ipipe-3.0-imx6q&id=d5205385b8966d49eac6c9bda491654fd8943a2e
http://git.xenomai.org/ipipe-gch.git/commit/?h=ipipe-3.0-imx6q&id=e13355f2cd5b8fab65c9f6c20e7eeafc52347d20

In order to use xenomai with linux 3.10, the patches are not yet 
available in xenomai 2.6 repository, but the patched kernel is 
available through git with:

git clone -b ipipe-3.10 git://git.xenomai.org/ipipe.git

Simply run prepare-kernel.sh using this kernel, and follow the 
normal installation procedure.

-- 
                                                                Gilles.

