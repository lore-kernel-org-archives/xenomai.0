Message-ID: <548FDC78.5080600@telecom-paristech.fr>
Date: Tue, 16 Dec 2014 08:17:12 +0100
From: pacalet <renaud.pacalet@telecom-paristech.fr>
MIME-Version: 1.0
References: <548F07F1.7010606@telecom-paristech.fr>
 <20141215161839.GO11058@hermes.click-hack.org>
In-Reply-To: <20141215161839.GO11058@hermes.click-hack.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] I-pipe patch broken for Xilinx Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 15/12/14 17:18, Gilles Chanteperdrix wrote:
> On Mon, Dec 15, 2014 at 05:10:25PM +0100, Renaud Pacalet wrote:
>> Dear Xenomai developers,
>> 
>> I ran into troubles when trying to follow the instructions at 
>> http://www.wiki.xilinx.com/Xenomai+for+Zynq: the 
>> xenomai-2.6.3/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-1.patch
>>
>> 
patch mentioned in the instructions is no longer the one distributed
>> in http://download.gna.org/xenomai/stable/xenomai-2.6.3.tar.bz2.
>> It has been replaced by ipipe-core-3.8.13-arm-3.patch patch which
>> is not compatible with the xilinx-v14.5 tag of 
>> git://github.com/Xilinx/linux-xlnx.git. In order to patch and
>> compile the compile Linux kernel I had to download and apply 
>> http://download.gna.org/adeos/patches/v3.x/arm/older/ipipe-core-3.8-arm-1.patch
>>
>> 
instead.
> 
> Bad idea, using the latest I-pipe patch for a kernel is
> recommended, a newer release means some things were fixed. For the
> same reason, using xenomai 2.6.3 is not recommended.

I 100% agree. All I wanted, before investing time and efforts in
Xenomai, was to test it on a Zynq core. And I didn't want to spend
days or weeks on this evaluation. This is the reason why I tried to
follow the apparently simple and straightforward instructions from
http://www.wiki.xilinx.com/Xenomai+for+Zynq. Of course, if my
evaluation is positive, I will try to use the most recent stable
versions. It will perhaps not be that easy, because the kernel
versions released by Xilinx for Zynq do not always match the kernel
versions supported by Xenomai, but at least I will know beforehand
that Xenomai can do the job.

> Maybe you could show us the errors you get?

Of course. The ipipe-core-3.8.13-arm-3.patch is not compatible with
the kernel released by Xilinx under tag xilinx-v14.5:

$ cd $KERNEL
$ git co -b xenomai-test xilinx-v14.5
$ find . -name '*.rej'
$ patch -p1 <
$XENOMAI/ksrc/arch/arm/patches/zynq/ipipe-core-3.8-zynq-pre.patch
$ find . -name '*.rej'
$ patch -p1 < $XENOMAI/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-3.patch
$ find . -name '*.rej'
./arch/arm/mm/context.c.rej
./arch/arm/mach-omap2/io.c.rej
./arch/arm/include/asm/mmu.h.rej
./arch/arm/include/asm/mmu_context.h.rej
./fs/proc/array.c.rej
./include/linux/spinlock_up.h.rej
./include/linux/sched.h.rej

Would you like me to post the rejects files somewhere?

Best regards,
- -- 
Télécom ParisTech - LabSoC
c/o EURECOM, Campus SophiaTech
Les Templiers, 450 route des Chappes 06410 Biot
Tel : +33 (0) 4 9300 8402
Fax : +33 (0) 4 9300 8200
Web : http://www.telecom-paristech.fr/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEAREIAAYFAlSP3HEACgkQ6X2qPZD76M+PXwCaA1UhErSLx32XJyTg8teGMmmt
fLAAnj7B6IJ7J5YeBIMxatVuIV3DSkaH
=4Evz
-----END PGP SIGNATURE-----

