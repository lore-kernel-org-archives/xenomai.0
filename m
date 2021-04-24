Date: Sun, 25 Apr 2021 07:07:39 +0800
From: Jamie Huang <jamienstar@163.com>
Subject: Can printk in the root domain cause the system to hung ?
Message-ID: <20210425070739.6c992d61@jamie-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, all:
	We are now porting ipipe on mips architecture. There is a
problem, after local_irq_enable() is called in start_kernel(), system
looks hung. We found that this may be related to printk in root domain,
if we use early_printk instead of printk, the system looks normal and
can continue the kernel boot process. Can someone tell me the possible
reason, thanks!

--
Jamie


