Message-ID: <531ABFA1.60406@xenomai.org>
Date: Sat, 08 Mar 2014 07:58:41 +0100
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

This document is wrong, we have a patch for 3.0.35, which works for SMP.
See ksrc/arch/arm/patches/README in xenomai sources (in addition to
README.INSTALL) for installation instructions. This patch currently
lacks 2 changes to improve latency, a new version will be released soon.

The latency figures in the document are also wrong, currently, with the
2 patches mentioned above, the measured latencies are in the 70us range.

-- 
                                                                Gilles.

