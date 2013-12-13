Message-ID: <52AACF17.3030007@xenomai.org>
Date: Fri, 13 Dec 2013 10:10:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <8B7A6B1DF7564DEE89CE7EEEDA46D421@itd274>
In-Reply-To: <8B7A6B1DF7564DEE89CE7EEEDA46D421@itd274>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] PCI-MSI interrupt handling Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Rajeshkumar R <rajesh.ramasamy@industeqsite.com>, xenomai@xenomai.org

On 12/13/2013 04:56 AM, Rajeshkumar R wrote:
> Hi,
>
> We are using MPC8641D processor (arch - powerpc) in our module. Our issue is MSI interrupt didn't handled in xenomai.
> We have the XMC module, this is the source of the MSI interrupt. This XMC MSI interrupt directly given to Processor.
> We are using the linux kernel (2.6.30) with xenomai patched (adeos-ipipe-2.6.70).

This patch does not exist. 2.6.30-2.7-xx maybe?

>
> For XMC module, we have the separate device driver implemented in xenomai.
> We are registering the ISR using 'rtdm_irq_request'. The ISR is not
> invoked when interrupt occurs, but in kernel '__ipipe_grab_irq' function is
> invoked.
>
> If the XMC module device driver is linux ('request_irq' is used to register
> the ISR), then the interrupt is coming, the ISR is invoked.
>
> Please clarify.
>

Adeos support for the 2.6.30 series dates back to 2009, and may not 
channel cascaded MSI interrupts to the pipeline. You are left with a 
choice: upgrading to kernel 3.5+ using the appropriate patch, or fixing 
up the PIC code in the old kernel (likely fsl_msi in your case).

This said, support for handling cascaded interrupts in the Adeos 
pipeline was broken until somewhere in the kernel 3.2 timeline, and 
fixing up that part in legacy patches would require significant surgery, 
so I would seriously consider upgrading anyway.

PS: please note that using MSI interrupts with Xenomai comes with a few 
restrictions: make sure to check this mailing list archive for more on this.

-- 
Philippe.

