From: Marco <cormabara@yandex.com>
Message-Id: <10829881481323326@web27g.yandex.ru>
Date: Fri, 09 Dec 2016 23:42:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [Xenomai] Long time system slow down on imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Content-Transfer-Encoding: 8bit
To: xenomai@xenomai.org

   We are notice a very strange problem on a imx6 with kernel
   Linux3.0.35-4.1.0 + xenomai_2.6.4. After machine runs for 8 - 10 hours
   we found the system blocked in may different ways (user interface
   tcp/ip interface ecc..)

   Â

   We check into /proc/timer_list and we found the next event was
   scheduled in the past.

   Â

   We found some items about timer blocked but all the patches indicated
   was already applied.

   Â

   Maybe someone have seen a similar problem ?
