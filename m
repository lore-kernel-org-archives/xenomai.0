References: <DF4PR84MB0299F84DFCDC76FD7D360B12F7B10@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a22149dd-141c-f148-113e-318f542095ae@xenomai.org>
Date: Tue, 22 Nov 2016 17:30:56 +0100
MIME-Version: 1.0
In-Reply-To: <DF4PR84MB0299F84DFCDC76FD7D360B12F7B10@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help needed regarding compiling/installing Xenomai
 patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Ramakrishnan, Senthil" <senthil.ramakrishnan@hp.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/17/2016 08:14 PM, Ramakrishnan, Senthil wrote:
> Dear All,
> 
> My name is Senthil Ramakrishnan and I work for Hewlett Packard Inc, Boise, Idaho.
> 
> We are currently in the process of doing a feasibility study on enabling Xenomai on our ARM platform. We are using the patch "xenomai-3-3.0.3" which I think is latest.
> The CPU we are targeting is AArch64 architecture(64-bit ARM). Based on that I'm trying to build the "Mercury" core using the below command line.
> 
> configure CFLAGS="-march=armv8-a" LDFLAGS="-march=armv8-a" --build="i686-pc-linux-gnu" --host="aarch64-linux-gnu"  --with-core=mercury  --enable-smp
> 
> But I run into below error during the validation of toolchain when running configure.
> 
> checking for target architecture...
> *******************************************
> Still unsupported target: aarch64-linux-gnu -- Sorry.
> *******************************************
> My question is if "aarch64" is supported and if this error is expected. If it's not supported it would be great if you can let us know if there are plans to enable 64-bit ARM(AArch64) and when it might be available.


Only the Cobalt core is actually requiring arch-specific support,
Mercury can run on whatever arch the host kernel runs. The fact that
configuring for Mercury is checking for arch-specific support is wrong.
Thanks for reporting this.

> 
> As a hack, I currently modified Xenomai "configure" script to get around this error and I'm able to compile the Xenomai Mercury core for Arm64/AArch64 using Linaro AArch64 Gcc toolchain. Do you see any issues with this?

No.

> 
> Other question I have is if RTDM User APIs are available under Mercury core? I don't see User space RTDM library when compiling Mercury core, so I think it's not supported, but it would be great if you can confirm that or if there are future plans to support this.

Since your application runs over a single kernel configuration, you can
just use the regular POSIX interface from the glibc to interface with
native Linux drivers, you don't need RTDM unless you want to create
drivers which you could build and run over a single or dual kernel
configuration seamlessly. But Mercury is lacking an implementation of
RTDM services in kernel space, so this would not be useful at the moment
anyway.

In general, there is no such RTDM user API in 3.x. One should use the
regular POSIX I/O or socket interfaces. The older rt_dev API from 2.x is
obsolete, and only provided as wrappers over the POSIX calls (see
include/trank/rtdm).

> We would also like to know how/where we can find the info on kernel version against each Xenomai/I-pipe patch versions are tested.
> 

There is no document gathering such information; you may assume that any
kernel release for which a patch is available in
kernel/cobalt/arch/*/patches directories has been tested for the given
architecture though.

Please note that the I-pipe is only required in dual kernel mode with
Cobalt, you don't need that for a Mercury set up.

-- 
Philippe.

