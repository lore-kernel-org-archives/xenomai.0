From: "Ramakrishnan, Senthil" <senthil.ramakrishnan@hp.com>
Date: Thu, 17 Nov 2016 19:14:09 +0000
Message-ID: <DF4PR84MB0299F84DFCDC76FD7D360B12F7B10@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Help needed regarding compiling/installing Xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear All,

My name is Senthil Ramakrishnan and I work for Hewlett Packard Inc, Boise, =
Idaho.

We are currently in the process of doing a feasibility study on enabling Xe=
nomai on our ARM platform. We are using the patch "xenomai-3-3.0.3" which I=
 think is latest.
The CPU we are targeting is AArch64 architecture(64-bit ARM). Based on that=
 I'm trying to build the "Mercury" core using the below command line.

configure CFLAGS=3D"-march=3Darmv8-a" LDFLAGS=3D"-march=3Darmv8-a" --build=
=3D"i686-pc-linux-gnu" --host=3D"aarch64-linux-gnu"  --with-core=3Dmercury =
 --enable-smp

But I run into below error during the validation of toolchain when running =
configure.

checking for target architecture...
*******************************************
Still unsupported target: aarch64-linux-gnu -- Sorry.
*******************************************
My question is if "aarch64" is supported and if this error is expected. If =
it's not supported it would be great if you can let us know if there are pl=
ans to enable 64-bit ARM(AArch64) and when it might be available.

As a hack, I currently modified Xenomai "configure" script to get around th=
is error and I'm able to compile the Xenomai Mercury core for Arm64/AArch64=
 using Linaro AArch64 Gcc toolchain. Do you see any issues with this?

Other question I have is if RTDM User APIs are available under Mercury core=
? I don't see User space RTDM library when compiling Mercury core, so I thi=
nk it's not supported, but it would be great if you can confirm that or if =
there are future plans to support this.
We would also like to know how/where we can find the info on kernel version=
 against each Xenomai/I-pipe patch versions are tested.

Any help answering above questions would be appreciated.

Best Regards,
Senthil
