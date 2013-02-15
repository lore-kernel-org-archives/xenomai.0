Message-ID: <511E26AE.1010203@xenomai.org>
Date: Fri, 15 Feb 2013 13:14:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <224444793.158669.1360843957336.JavaMail.ngmail@webmail16.arcor-online.net>	<511CD5C2.50701@arcor.de>	<511CD673.2030400@xenomai.org>
	<511CDF65.1020907@arcor.de>	<511D3A22.40307@xenomai.org>
	<511DF30B.6040601@arcor.de>
In-Reply-To: <511DF30B.6040601@arcor.de>
Content-Type: text/plain; charset=UTF-8
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
To: Christopher Hahn <hahnchristopher@arcor.de>
Cc: xenomai@xenomai.org

On 02/15/2013 09:34 AM, Christopher Hahn wrote:

> after running the application which accesses the serial device
> "Xenomai: xnintr_edge_shirq_handler: IRQ4 not handled. Disabling IRQ
> line." was printed to dmesg and the next two outputs of
> /proc/interrupts and /proc/xenomai/irq


If xnintr_edge_shirq_handler is called, an RTDM driver registered a
handler for this irq. So, please keep the application running with all
the file descriptors opened, and run cat /proc/xenomai/irq while the
application is still running.

The most logical result would be that irq 4 is claimed by the 16550A driver.


-- 
                                                                Gilles.

