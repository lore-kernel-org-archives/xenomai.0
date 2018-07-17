References: <4568407c.661a.164a6b8171f.Coremail.15084864580@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a29150bc-11e7-8099-7cca-e900d86fedd1@xenomai.org>
Date: Tue, 17 Jul 2018 10:54:33 +0200
MIME-Version: 1.0
In-Reply-To: <4568407c.661a.164a6b8171f.Coremail.15084864580@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] =?utf-8?q?About_interrupt_delivery_issues=EF=BC=9F?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5piT5bKz5ZCN?= <15084864580@163.com>, xenomai@xenomai.org

On 07/17/2018 07:30 AM, 易岳名 wrote:
> In the old xenomai version, the ipipe_pass_mask flag was used to set the interrupt delivery. Currently I need to trigger an interrupt in the xenomai domain, respond in the xenomai domain, and then pass it to the linux domain and then respond. To verify the interrupt delivery function of ipipe, what should I do? Looking forward to your reply! bless you

root:ipipe_raise_irq(irq) -> head:ipipe_post_irq_root(irq) ->
root:verify(irq)

ipipe_post_irq_root() must be called with hard IRQs off, which is the
case when called from a head stage IRQ handler.

-- 
Philippe.

