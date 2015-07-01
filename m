Date: Wed, 1 Jul 2015 18:02:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150701160220.GF13256@hermes.click-hack.org>
References: <CAOL1OyMAYBfKQp0W1W+B_=438upRo-M-LepAh9biKXt=AqHZHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOL1OyMAYBfKQp0W1W+B_=438upRo-M-LepAh9biKXt=AqHZHg@mail.gmail.com>
Subject: Re: [Xenomai] RTDM PCI drivers IRQ line conflict
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Durand <wanipof@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Jul 01, 2015 at 05:56:25PM +0200, Antoine Durand wrote:
> Hi,
> 
> I've two PCI devices for which I'm making RTDM drivers.
> 
> I can load the first without any problem.
> 
> but when the second driver call rtdm_irq_request (passing the struct
> pci_dev->irq field and flag RTDM_IRQTYPE_SHARED), it failed with
> EBUSY :

That is a Xenomai configuration issue, you need to enable
CONFIG_XENO_OPT_SHIRQ if you want your RTDM drivers to share IRQs.

-- 
					    Gilles.
https://click-hack.org

