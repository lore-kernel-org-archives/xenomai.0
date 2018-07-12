MIME-Version: 1.0
In-Reply-To: <CAOtTmjVdQc9RW4P-0PS_L8Hg587CgJTc4-=atTBPMtzD1S-3tQ@mail.gmail.com>
References: <e0a47fd9-7ea7-63af-8834-55cd72f086eb@gmail.com>
 <CAOtTmjVdQc9RW4P-0PS_L8Hg587CgJTc4-=atTBPMtzD1S-3tQ@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 12 Jul 2018 11:32:29 -0400
Message-ID: <CALLqZ8Tc=LvV+1baXYF_vJ=CRS3eW0nfz0_T26zXyx-GoOdwNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai on VAR-SOM-MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jake Burris <jakeburris7@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Can you confirm that you are building the Xenomai libs and utils?
There should be a make install step after you do the configure step

-Greg

On Wed, Jul 11, 2018 at 5:34 PM, Jake Burris <jakeburris7@gmail.com> wrote:
> The following are the steps that I have taken. Am I missing something? :
>
> 1) git clone https://github.com/varigit/debian-var.git -b
> debian_stretch_mx6_var01 folder_name
>
> 2) cd folder_name
>
> 3) ./make_var_som_mx6_debian -c deploy
>
> 4) cd src/kernel
>
> 5) copy patch-4.9.11, patch-4.9.38, ipipe-core-4.9.38-arm-3.patch to
> src/kernel
>
> 6) patch -p1 -R < patch-4.9.11
>
> 7) patch -p1 < patch-4.9.38
>
> a) When it asks Assume -R? Just hit enter and let it do the default
>
> 8) patch -p1 < ipipe-core-4.9.38
>
> 9) ~/xenomai-3/scripts/prepare-kernel.sh =E2=80=93arch=3Darm
>
> 10) mkdir -p home/linux
>
> 11) export
> PATH=3D$PATH:~/colonel_x/toolchain/gcc-linaro-6.3.1-2017.05-x86_64_arm-li=
nux-gnueabihf/bin/
>
> 12) make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- O=3Dhome/linux
> imx_v7_var_defconfig
>
> 13) make -j5 ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- O=3Dhome/lin=
ux
> bzImage modules
>
> a) You will likely have to vim arch/arm/mach-imx/gpc.c the first time
>
> i) Comment out: static DEFINE_SPINLOCK(gpc_lock);
>
> ii) Add: static IPIPE_DEFINE_RAW_SPINLOCK(gpc_lock);
>
> 14) Menuconfig
>
> a) sudo make ARCH=3Darm mrproper
>
> b) sudo make ARCH=3Darm imx_v7_var_defconfig
>
> c) sudo make ARCH=3Darm menuconfig
>
> d) sudo make ARCH=3Darm savedefconfig
>
> e) sudo cp defconfig arch/arm/configs/imx_v7_var_defconfig
>
> 15) cd home/linux
>
> 16) ~/xenomai-3/configure CFLAGS=3D=E2=80=9D-march=3Darmv7-a -mfpu=3Dvfp3=
=E2=80=9D
> LDFLAGS=3D=E2=80=9D-march=3Darmv7-a=E2=80=9D --host=3Darm-linux-gnueabihf=
 =E2=80=93enable-smp
> =E2=80=93with-core=3Dcobalt =E2=80=93enable-tls CC=3Darm-linux-gnueabihf-=
gcc
> LD=3Darm-linux-gnueabihf-ld
>
> 17) cd folder_name
>
> 18) ./make_var_som_mx6_debian -c bootloader
>
> 19) ./make_var_som_mx6_debian -c kernel
>
> a) You will have to vim 4 folders here:
>
> i) src/kernel/arch/arm/mach-imx/mach-imx6q.c
>
> -Comment out: //imx_busfreq_map_io();
>
> ii) src/kernel/arch/arm/mach-imx/mach-imx6ul.c
>
> -Comment out: //imx_busfreq_map_io();
>
> iii) src/kernel/arch/arm/mach-imx/mach-imx7d.c
>
> -Comment out: //imx_busfreq_map_io();
>
> iiii) src/kernel/arch/arm/mach-imx/Makefile
>
> -Comment out: #obj-y +=3D busfreq_lpddr2.o busfreq-imx.o busfreq_ddr3.o
>
> 20) ./make_var_som_mx6_debian -c modules
>
> 21) ./make_var_som_mx6_debian -c rootfs
>
> a) PREPARE YOURSELF THIS WILL TAKE AN HOUR OR SO
>
> 22) ./make_var_som_mx6_debian -c rtar
>
> 23) ./make_var_som_mx6_debian -c sdcard -d /dev/sdb
>
>
> On Wed, Jul 11, 2018 at 3:07 PM, Jake Burris <jakeburris7@gmail.com> wrot=
e:
>
>> Hi,
>>
>> I am trying to get the Xenomai Cobalt kernel onto a Variscite VAR-SOM-MX=
6
>> Test Board featuring a NXP i.MX6 quad-core processor. I am having issues
>> with the user space(a xenomai folder is not showing up in /usr). We are
>> using a Debian Stretch OS kernel 4.9.38 with the same IPIPE patch and
>> Xenomai 3. I am having issues finding the latency test as well as
>> xeno-tests. Is there a specific option that we have to select in menucon=
fig
>> in order for these to show up. When I type dmesg | grep -i "Xenomai" aft=
er
>> booting the three Xenomai messages are there.
>>
>> Please advise,
>>
>> Jake
>>
>>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

