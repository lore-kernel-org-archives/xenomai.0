From: Jack Lee <jacklee11@foxmail.com>
Message-ID: <1120067a-828f-6a38-399f-aec04c566c99@foxmail.com>+0518319AAC4E5101
Date: Thu, 30 Nov 2017 09:13:46 +0800
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] something wrong with drivers/xenomai/net/driver/r8169.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

When I build Linux 4.9.51 with the latest 
xenomai-3-7a038dfad8d1e48b065542c8cc2e39f6b5ee4f82.tar.bz2 
<http://git.xenomai.org/xenomai-3.git/snapshot/xenomai-3-7a038dfad8d1e48b065542c8cc2e39f6b5ee4f82.tar.bz2>

there get an error.


   CC [M]  drivers/xenomai/net/drivers/r8169.o
drivers/xenomai/net/drivers/r8169.c:131:12: error: ‘debug’ redeclared as 
different kind of symbol
  static int debug = -1;
             ^
In file included from arch/x86/xenomai/include/asm/xenomai/thread.h:25:0,
                  from include/xenomai/cobalt/kernel/thread.h:35,
                  from include/xenomai/cobalt/kernel/sched.h:24,
                  from include/xenomai/rtdm/driver.h:37,
                  from drivers/xenomai/net/stack/include/rtnet.h:99,
                  from drivers/xenomai/net/stack/include/rtskb.h:32,
                  from drivers/xenomai/net/stack/include/rtdev.h:37,
                  from drivers/xenomai/net/stack/include/rtnet_port.h:32,
                  from drivers/xenomai/net/drivers/r8169.c:82:
./arch/x86/include/asm/traps.h:13:17: note: previous declaration of 
‘debug’ was here
  asmlinkage void debug(void);

