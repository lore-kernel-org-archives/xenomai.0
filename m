MIME-Version: 1.0
Date: Thu, 17 Sep 2015 01:31:46 +1200
Message-ID: <CAFkYNwaqLYu7vAAyAt6Q9qfKL4iBa+N1BuzgJWhN6z4NfA5U=g@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Error code -19
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,
I am a newbie and I believe code -19 has been asked before.

My system is made of

arch = arm
board = PandaBoard ES
Kernel = 3.18.12
Patch  =
xenomai-3/kernel/cobalt/arch/arm/patches/ipipe-core-3.18.12-arm-4.patch

output of dmesg | grep -i xenomai:
[    1.733825] [Xenomai] scheduling class idle registered.
[    1.733856] [Xenomai] scheduling class rt registered.
[    1.734588] [Xenomai] init failed, code -19


I had tried to reconfigure the kernel in accordance with the
http://www.xenomai.org/documentation/xenomai-head/html/TROUBLESHOOTING/#ENODEV
but the same errors produced.

Any comments would be appreciated.

Thank you

SiowLim
