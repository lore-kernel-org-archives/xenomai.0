Message-ID: <51DBF6B8.1000000@mitrol.it>
Date: Tue, 09 Jul 2013 13:40:40 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Make a block of code atomic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I would like to make a block of kernel code atomic, so that no one (both 
xenomai and Linux) can interrupt it.
I use the following :

#define my_local_irq_save(x)    ((x) = 
ipipe_test_and_stall_pipeline_head() & 1)
#define my_local_irq_restore(x) ipipe_restore_pipeline_head(x)

my_local_irq_save(flags);
< critical section >
my_local_irq_restore(flags);

It works well enough, but rarely an rtdm irq enter into my critical 
section.
The rtdm irq is registered in this way : rtdm_irq_request(&priv->irqHnd, 
ETH_PORT_IRQ_NUM(priv->port), irqHandler, RTDM_IRQTYPE_EDGE, "rtdm_eth", 
priv);

Is it normal ? Are you sure that it cannot happen ?

Thanks,
Paolo

