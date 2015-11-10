Message-ID: <BLU436-SMTP209CFA8CD84A8B151D863A9F0140@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Mon, 9 Nov 2015 20:56:10 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Fails building xenomai library and tools for ARM.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hi Xenomai team,

I can not build ARM xenomai library and tools to install on RaspberryPie2.

Tested with this branch (also fails with master):
http://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=cb72996a06ae4f29e403e3397324069f1983145e

This is the error:
Making install in testsuite
make[1]: Entering directory `/home/mathieu/temp/xenomai/testsuite'
Making install in latency
make[2]: Entering directory `/home/mathieu/temp/xenomai/testsuite/latency'
   CC       latency-latency.o
   CCLD     latency
../../lib/cobalt/.libs/libcobalt.so: undefined reference to 
`__wrap_sched_yield'
collect2: error: ld returned 1 exit status
make[2]: *** [latency] Error 1
make[2]: Leaving directory `/home/mathieu/temp/xenomai/testsuite/latency'

this is the command I use:
 > mkdir -p $build_root/xenomai && cd $build_root/xenomai
 > $xenomai_root/configure --disable-doc-install CFLAGS="-march=armv7-a 
-mfpu=neon" LDFLAGS="-march=armv7-a -mfpu=neon" 
--build=i686-pc-linux-gnu --host=arm-linux-gnueabihf --with-core=cobalt 
--enable-smp CC=$cross_compiler-gcc LD=$cross_compiler-ld 
AR=$cross_compiler-ar RANLIB=$cross_compiler-ranlib
 > sudo make DESTDIR=/mnt/ext4 install

Cross compiler is linaro: gcc-linaro-arm-linux-gnueabihf-raspbian-x64

This is the fist time I am trying this.
Thanks for your help,
-Mathieu

