Message-ID: <625190704.2392951429616861917.JavaMail.httpd@webmail-27.iol.local>
Date: Tue, 21 Apr 2015 13:47:41 +0200 (CEST)
From: "claudio.lorini@libero.it" <claudio.lorini@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  CAN with more than 4 SJA1000 (memory mapped)
Reply-To: "claudio.lorini@libero.it" <claudio.lorini@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
recently i managed to setup the CAN bus communication using a Zedboard with 
eight CAN cores (SJA1000 compatible, memory mapped in FPGA), wirh 
kernel 3.14.17, xenomai v2.6.4.
4 rtcan_rtt are running in parallel moving data @300usec from 0->1, 2->3, 4->5 
and 6->7
everything works (up to now) like charm and I'd like to thank you all for 
developing 
and maintaining such an amazing piece of code!

the only thing i had to change is 1 line in 
xenomai-2.6/ksrc/drivers/can/sja1000/rtcan_mem.c

the RTCAN_MEM_MAX_DEV was fixed to 4 instead of dropping down from the
kernel config, simply changing the line like this:

#define RTCAN_MEM_MAX_DEV (CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES)

had worked the magic.

C.

