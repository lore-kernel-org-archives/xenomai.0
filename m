Message-ID: <525ED707.2030809@cantastic.org>
Date: Wed, 16 Oct 2013 20:12:23 +0200
From: Ralf Roesch <xenomai@cantastic.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>
	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>
	<525E8A43.5090601@xenomai.org> <525E8BFF.1060201@steinkuehler.net>
	<525EAFFD.3010207@steinkuehler.net> <525EB7A2.1050601@xenomai.org>
In-Reply-To: <525EB7A2.1050601@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Wed Oct 16 2013 17:58:26 GMT+0200 (CEST), Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> If the issue is not a timer issue, and it does not seem to be, the
> most probable explanation is that either the MMC driver or the
> interrupt controller does not like receiving interrupts while they are
> masked. In this case, you will find that the patched kernel does not
> work with CONFIG_IPIPE but works with CONFIG_IPIPE off and
> CONFIG_XENOMAI off.
> Do you know if the interrupt is level or edge triggered?
>
> Regards.
>
>

The mmc interrupts are handled by INTC. I assume they are level triggered:

->  interrupt section of the AM335x technical reference manual (BBB is
based on AM3359):
--
The INTC supports only level-sensitive incoming interrupt detection. A
peripheral asserting an interrupt
maintains it until software has handled the interrupt and instructed the
peripheral to deassert the interrupt.
--


regards
Ralf

