MIME-Version: 1.0
Date: Fri, 23 May 2014 12:08:03 -0700
Message-ID: <CAE2JnQzDaSfwwuuq+voM+ZqPLHoqmjitsa4XzRpqcoukNJGrsg@mail.gmail.com>
From: Alexandre Donisete Bensi <adbensi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai on linux-3.8.13 core ARM Cortex A9 - ARMv7 (v7l)
 SoC Samsung Exynos 4412
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

 I am trying to install xenomai on ARM Cortex A9 - ARMv7 (v7l) SoC
Samsung Exynos 4412 on linux-3.8.13.23 board OdroidU2/U3. To port
xenomai to this board I need to add some functions to hardware timer
and interrupt handler according
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

 But mach-exynos directory is different and I cannot find the files
referenced :(

root@odroid:/usr/src/linux-3.8.13.23/arch/arm/mach-exynos#
clock-exynos4210.c  clock-exynos4212.c  clock-exynos4.c
mach-hkdk4412.c  mach-smdk4x12.c  mach-exynos4-dt.c

I confess that I am with many doubts. All attempts I made on this
platform end as:
checking file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 3.8.13.23 with
ipipe-core-3.8.13-arm-3.patch.

 Is there any documentation that is closest to my case?

 Thanks,
 Best Regards

