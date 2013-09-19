MIME-Version: 1.0
Date: Thu, 19 Sep 2013 13:10:16 +0200
Message-ID: <CAEk6gTC2n0iRT21RocjsChtsmz3u+q3b6hmyNb7c5Orj8Z605Q@mail.gmail.com>
From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Disable documentation generation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,
I am cross-compiling for ARM. How can I disable documentation generation?

I tried adding --disable-dox-doc --disable-dbx to ./configure, but I
can still see doc generating during compilation (log below).

Where can I see the options that should be passed to ./configure?

Best regards,
Drasko




docs="clocktest cyclictest irqbench irqloop klatency latency
rtcanconfig rtcanrecv rtcansend switchbench switchtest xeno
xeno-config"; abs_builddir=$PWD; \
for dir in $docs; do \
   dest=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/image/usr/share/doc/xenomai/html/$dir;
\
   /bin/sh /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/install-sh
-d $dest; \
   abs_dest=`cd $dest && pwd` ; \
   cd ./../generated/html/$dir || exit 1; \
   for f in * ; do \
case $f in \
   *~|CVS|.svn|[mM]akefile*|GNUmakefile*);; \
   *) /usr/bin/install -c -m 644 $f $abs_dest/$f;; \
esac; \
   done; cd $abs_builddir; \
done
docs=""; dest=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/image/usr/share/doc/xenomai/ps;
\
/bin/sh /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/install-sh
-d $dest && \
for f in $docs; do \
   /usr/bin/install -c -m 644 $f $dest; \
done
docs=""; dest=/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/image/usr/share/doc/xenomai/pdf;
\
/bin/sh /home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/config/install-sh
-d $dest && \
for f in $docs; do \
   /usr/bin/install -c -m 644 $f $dest; \
done

 /bin/mkdir -p '/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/image/usr/share/man/man1'

 /usr/bin/install -c -m 644 clocktest.1 cyclictest.1 irqbench.1
irqloop.1 klatency.1 latency.1 rtcanconfig.1 rtcanrecv.1 rtcansend.1
switchbench.1 switchtest.1 xeno.1 xeno-config.1
'/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/image/usr/share/man/man1'

make[3]: Leaving directory
`/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/doc/man'
make[2]: Leaving directory
`/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/doc/man'
Making install in txt

make[2]: Entering directory
`/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/doc/txt'

make[3]: Entering directory
`/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/xenomai-2.6.2.1/doc/txt'
make[3]: Nothing to be done for `install-exec-am'.

 /bin/mkdir -p '/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/image/usr/share/doc/xenomai/txt'

 /usr/bin/install -c -m 644 16550A-driver.txt irqbench.txt
pse51-skin.txt psos-skin.txt uITRON-skin.txt vrtx-skin.txt
comedi-skin.txt vxworks-skin.txt ChangeLog.pre-git
'/home/drasko/yocto/build/tmp/work/armv7ahf-vfp-neon-poky-linux-gnueabi/xenomai-2.6.2.1-r0/image/usr/share/doc/xenomai/txt'

