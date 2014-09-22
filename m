From: bob <kobebry48@gmail.com>
Date: Mon, 22 Sep 2014 21:11:43 +0000 (UTC)
Message-ID: <loom.20140922T230305-367@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] main : can't open rtser0 (write) for ./cross-link
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
so I've been searching google for a while now and the results haven't been
helping.

i tried setserial /dev/ttyS0 , i get the typical io=0x3f8, IRQ=4

i set uart to none, and my normal serial programs with my device don't read
anything as expected

i did /sbin/modprobe xeno_16550A \
               io=0x3f8 \
               irq=4 \
               baud_base=115200

and modprobe xeno_16......

and sudo and all the permutations possible

i dont get nay mesasge back, but when i run cross-link it still gives me the
same error, main : can't open rtser0 (write) 

im not sure if im loading the xenomai driver right, is there something im
missing?

my lsmod DOES NOT show any of these
# lsmod
Module                  Size  Used by
xeno_16550A            12392  0
xeno_rtdm              23460  1 xeno_16550A
xeno_native           114384  0
xeno_nucleus           82696  3 xeno_16550A,xeno_rtdm,xeno_native
xeno_hal               23616  4

http://www.acadis.org/pages/captain.at/serial-port-example 
makefile does not work for me

http://www.acadis.org/pages/captain.at/xeno-16550A
i don't have a directory in /usr/realtime/

anyone have any ideas or suggesitons or recommendation of alcohol?


