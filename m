MIME-Version: 1.0
Date: Tue, 21 Apr 2015 16:02:07 +0530
Message-ID: <CAGeOLJfw93peFkdX0mZOVEAUzN9GUe_ukTrfPrXkMbTK1QGb9A@mail.gmail.com>
From: Santosh Vivek <vivek.ece477@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] regarding xeno_16650A
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In xeno_16650A RTDM it loaded successfully, requesting for the interrupt
with API rtdm_irq_request it is working well it not giving any error, but
irq number is not registered in cat proc/xenomai/irq i am passing irq
number through command line as insmod xeno_16550A.ko io=0x2f8,0x3f8
irq=3,4.my configuration as xenomai 2.6.2 and linux3.2.21.In user level
while using cross link example ioctl read_task: error on
RTSER_RTIOC_WAIT_EVENT, Connection timed out.please suggest me regarding
this.
