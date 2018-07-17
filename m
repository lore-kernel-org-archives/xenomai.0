Date: Tue, 17 Jul 2018 13:30:39 +0800 (CST)
From: =?GBK?B?0tfUwMP7?= <15084864580@163.com>
MIME-Version: 1.0
Message-ID: <4568407c.661a.164a6b8171f.Coremail.15084864580@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] =?gbk?q?About_interrupt_delivery_issues=A3=BF?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In the old xenomai version, the ipipe_pass_mask flag was used to set the interrupt delivery. Currently I need to trigger an interrupt in the xenomai domain, respond in the xenomai domain, and then pass it to the linux domain and then respond. To verify the interrupt delivery function of ipipe, what should I do? Looking forward to your reply! bless you
