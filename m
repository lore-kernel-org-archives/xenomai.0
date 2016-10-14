From: Jack Lee <jacklee11@foxmail.com>
Message-ID: <5683b7e7-8dd5-5036-99f6-e86f8ad97bd8@foxmail.com>
Date: Fri, 14 Oct 2016 17:09:23 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Something interesting about advantech board that may
 influence real-time performance
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I recently want to access GPIO of the advantech MIO-5251 board.

I found that the GPIO was attached to iManager which was connect

to the CPU by LPC. The iManager is an advantech device to manage

the whole system, including temperature and fan .... "embedded

controller ..." item was found in the BIOS. It has an interrupt, sleep

mode setting and watchdog... This is really interesting that it 
implements a standalone

device that completes some functions of the SMI. The influence made

to the real-time performance by this device needs to be assessed.

If I get something valuable later, I will come back.


Have a nice day!




