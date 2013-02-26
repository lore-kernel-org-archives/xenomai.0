Date: Tue, 26 Feb 2013 11:01:39 +0100 (CET)
From: hahnchristopher@arcor.de
Message-ID: <963432115.61822.1361872899385.JavaMail.ngmail@webmail10.arcor-online.net>
In-Reply-To: <5123BCE7.2050609@xenomai.org>
References: <5123BCE7.2050609@xenomai.org>
	<224444793.158669.1360843957336.JavaMail.ngmail@webmail16.arcor-online.net>	<511CD5C2.50701@arcor.de>	<511CD673.2030400@xenomai.org>	<511CDF65.1020907@arcor.de>	<511D3A22.40307@xenomai.org>	<511DF30B.6040601@arcor.de>
	<511E26AE.1010203@xenomai.org>	<511E3A5C.4000209@arcor.de>
	<51237586.6030201@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel configuration problems with ACPI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 02/19/2013 6:56 PM,  Gilles Chanteperdrix wrote:
> On 02/19/2013 01:52 PM, Christopher Hahn wrote:
> 
> > Do you have any idea how to solve the problem?
> > Even if the system receives interrupts at IRQ 4, the program doesn't 
> > receive any message from the serial port with this kernel configuration.
> 
> 
> Trying to register the irq handler as level instead of edge?
> 
> -- 
>                                                                 Gilles.
> 

I removed the 'RTDM_IRQTYPE_EDGE' from ksrc/drivers/serial/16550A.c at line 123.

Now I get 'Xenomai: xnintr_shirq_handler: IRQ4 not handled. Disabling IRQ line.'











