From: Tim Niemeyer <tim.niemeyer@corscience.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Dec 2012 16:33:16 +0100
Message-ID: <1355499196.2190.23.camel@herbert.er.corscience.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Question about IPIPE_IRQF_NOSYNC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi

I'm using Xenomai 2.6.1 with linux 3.4.14 (with latest 'for-core-3.4'
Adeos) on an omap3 board.

While hunting a gpio-irq latency i tried to understand the adeos chained
interrupt code. I'm currently stuck at ipipe_handle_demuxed_irq()
because i didn't understand the IPIPE_IRQF_NOSYNC-Flag:

static inline void ipipe_handle_demuxed_irq(unsigned int cascade_irq)
{
..
__ipipe_dispatch_irq(cascade_irq, IPIPE_IRQF_NOSYNC);
..
}

Maybe someone can give me hint or point me to the right documentation,
so that i can better understand the code for __ipipe_dispatch_irq() ?

-- 
Tim Niemeyer

Corscience GmbH & Co. KG
Henkestr. 91
D-91052 Erlangen
Germany

e-mail: tim.niemeyer@corscience.de
Internet: www.corscience.de


