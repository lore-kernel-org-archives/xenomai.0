MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Fri, 31 Jan 2020 14:04:25 +0200
Message-ID: <CAPm8-H4LK2cdVkiK=AmVE1UT8kCOehDxsHafkh7EupOoQRebnA@mail.gmail.com>
Subject: Beaglebone black raw_printk
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello xenomai family

  In this way I was able to use raw_printk on evl.
Maybe works on xenomai too.

CONFIG_DEBUG_RAW_PRINTK=y
CONFIG_DEBUG_LL=y
# under LL menu entry
CONFIG_DEBUG_UART_8250=y
CONFIG_DEBUG_UART_PHYS=0x44e09000
CONFIG_DEBUG_UART_VIRT=0xf9e09000

