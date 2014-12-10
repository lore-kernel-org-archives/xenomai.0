MIME-Version: 1.0
Date: Wed, 10 Dec 2014 15:57:44 +0530
Message-ID: <CALe7ZU07e_Pi4=jbV9y1zuVd4RAKZGRsuUdQrVqWCjPcmjTkgg@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] /asm/ipipe.h not found
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello,
    I am porting linux-3.2.21(xenomai-2.6.2 patched to it) on
BeagleBoard-XM. zImage is successfully made. But when I am building
the modules with following command

 $make -j 8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi modules

 It shows error:
  make CONFIG_DEBUG_SECTION_MISMATCH=y

After this I ran
 $make CONFIG_DEBUG_SECTION_MISMATCH=y

This lets to another error
include/linux/ipipe.h :33:23: fatal error:asm/ipipe.h: No such file or
directory.
compilation terminated.

      Actually ipipe.h is there in /asm/ipipe.h:I tried to set CFLAG
and export it but it is not working.Help would be appreciated.


Jay Kothari

