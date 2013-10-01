Message-ID: <524B1F6C.7080705@xenomai.org>
Date: Tue, 01 Oct 2013 21:15:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8ceffc54095e43d88f6dfa0edd0bb852@DBXPR03MB093.eurprd03.prod.outlook.com>
	<52496200.2010808@xenomai.org>
	<295e5f6a1e6849079d9fb3e53dcc1827@DBXPR03MB093.eurprd03.prod.outlook.com>
In-Reply-To: <295e5f6a1e6849079d9fb3e53dcc1827@DBXPR03MB093.eurprd03.prod.outlook.com>
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

On 09/30/2013 03:01 PM, Antoine MOREL wrote:
> Hello Gilles,
> 
> I try with the function rtdm_irq_enable after rtdm_irq_request. It doesn't work again.
> I request the irq at linux level (see main.c), but with the adeos path, it doesn't work. I don't know why!

Could you be more precise? Do you mean you do not receive Linux
interrupts when Adeos is enabled? Or do you try to request an irq with
rtdm_irq_request and do not receive interrupt? Did you configure the irq
type (edge, level).

Regards.

-- 
                                                                Gilles.

