From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Wed, 26 Nov 2014 15:09:04 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC9123428F6675@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] ipipe-arm for kernel 3.12 on ls1021
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi

I need a ipipe-arm patch for kernel-3.12.0.

I have the layerscape ls1021atwr from freescale here that comes with yocto =
sdk and a 3.12.0 freescale git kernel.
Bitbake the kernel /rootfs is worked already.

So the next step is: make xenomai on it!
I found the ipipe-raw/ipipe-3.12.0 tree on your git server, make a diff to =
vanilla 3.12.0 kernel and get my ipipe-3.12.0.patch.

Now I patched the freescale git kernel  with my ipipe-3.12.0 patch with onl=
y three errors:

arch/powerpc/include/asm/qe_ic.h -> file not found
arch/powerpc/sysdev/qe_lib/qe_ic.c -> file not found
arch/powerpc/include/asm/qe_ic.h -> file not found

Powerpc is not layerscap, so I comment out these 3 patches.

During the compilation i get an error:
undefined reference to `__ipipe_pin_range_globally'

I found an email (22 Aug 2014) that gives me the solution:
In arch/arm/mm/fault.c  i moved the #endif at bottom of the file to above t=
he #ifdef CONFIG_IPIPE

And finally I can compile the kernel and dtb.

But after u-boot load the kernel I see only
Starting kernel...

And nothing is happened.

My question:
What can I do to see why the kernel isn't starting and make the patch to wo=
rk?

I attached my created ipipe-3.12.0 patch and the kernelconfig.


Best regards
Alex

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-3.12.0.patch
Type: application/octet-stream
Size: 609671 bytes
Desc: ipipe-3.12.0.patch
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141126/479f146=
2/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 78673 bytes
Desc: config
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141126/479f146=
2/attachment-0001.obj>
