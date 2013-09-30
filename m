Message-ID: <52496200.2010808@xenomai.org>
Date: Mon, 30 Sep 2013 13:35:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8ceffc54095e43d88f6dfa0edd0bb852@DBXPR03MB093.eurprd03.prod.outlook.com>
In-Reply-To: <8ceffc54095e43d88f6dfa0edd0bb852@DBXPR03MB093.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] No GPIO IRQ on imx28(apf28), kernel 3.8.13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine MOREL <A.MOREL@polysoude.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/30/2013 11:47 AM, Antoine MOREL wrote:
> Hi all,
> 
> I'm testing Xenomai on an apf28 board, with imx28 processor.
> I'm using a 3.8.13 kernel with the last Xenomai-head repositorie.
> 
> When I use the kernel without xenomai, my GPIO irq works well. But when I patch my kernel with adeos and Xenomai, my gpio IRQ doesn't work!
> I have the same problem with the kernel 3.4.6.
> 
> I test the gpio IRQ in user space and with RTDM driver.
> Do I forget anything?

The irq line probably needs to be enabled, you should use
rtdm_irq_enable after rtdm_irq_request, if that does not work, try to
request irq at Linux level, then please report your findings to the
mailing list.


-- 
                                                                Gilles.

