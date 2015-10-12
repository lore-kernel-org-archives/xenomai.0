MIME-Version: 1.0
Date: Mon, 12 Oct 2015 12:12:37 -0700
Message-ID: <CAMcKmiHxu63HkbO9niHD07mpkvzo+7n1AW1xrSGc8_-GJ54OJw@mail.gmail.com>
From: George Broz <brozgeo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] undefined reference to __cobalt_rt_dev_ioctl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm trying to build a 3rd party application (IgH EtherCAT Master)
for Xenomai 3.0 for an Altera ARM (socfpga) board. Linux and Xenomai,
built with tools on the target, are working normally.

The IgH ECM uses autotools and makes use of xeno-config to set
CFLAGS and LDFLAGS. It builds a user-space shared library that
makes use of rt_dev_open(), rt_dev_close(), and rt_dev_iodev().
Applications using the IgH ECM then link against this library.

For Xenomai 2.6.4, it was sufficient to use:
xeno-config --rtdm --cflags/--ldflags to build this shared library.

For Xenomai 3.0 this results in:
.libs/libethercat_rtdm.so: undefined reference to `rt_dev_ioctl'
.libs/libethercat_rtdm.so: undefined reference to `rt_dev_open'
.libs/libethercat_rtdm.so: undefined reference to `rt_dev_close'

Using:
xeno-config --rtdm --compat --cflags/--ldflags

Eliminates those undefined references but results in a new one:
.libs/libethercat_rtdm.so: undefined reference to `__cobalt_rt_dev_ioctl'

I could not find __cobalt_rt_dev_ioctl anywhere...

What is the best way to migrate an application making use of these calls
to Xenomai 3.0? Is --compat supposed to make this work? If so, where
could I find __cobalt_rt_dev_ioctl?


Here is my target information:

#./xeno-config --info

Xenomai version:
Xenomai/cobalt v3.0-rc6 -- Linux cyclone5 3.18.20-ipipe #1
SMP Thu Oct 8 12:25:33 PDT 2015 armv7l GNU/Linux

Kernel parameters:
console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait

I-pipe release #6 detected
Cobalt core 3.0-rc6 detected

Compiler:
gcc version 4.9.1 (GCC)

Build args:
CFLAGS=-march=armv7-a -mthumb-interwork -mfloat-abi=hard
-mfpu=neon -mtune=cortex-a9  LDFLAGS=-march=armv7-a -mthumb-interwork
-mfloat-abi=hard -mfpu=neon -mtune=cortex-a9  --build=x86_64-linux-gnu
--host=arm-poky-linux-gnueabi --with-core=cobalt --enable-smp
--enable-dlopen-libs --enable-shared --with-pic
build_alias=x86_64-linux-gnu host_alias=arm-poky-linux-gnueabi




Thanks for any help!
--George Broz

Moog Industrial Group

