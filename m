Message-ID: <5123BCE7.2050609@xenomai.org>
Date: Tue, 19 Feb 2013 18:56:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <224444793.158669.1360843957336.JavaMail.ngmail@webmail16.arcor-online.net>	<511CD5C2.50701@arcor.de>	<511CD673.2030400@xenomai.org>	<511CDF65.1020907@arcor.de>	<511D3A22.40307@xenomai.org>	<511DF30B.6040601@arcor.de>
	<511E26AE.1010203@xenomai.org>	<511E3A5C.4000209@arcor.de>
	<51237586.6030201@arcor.de>
In-Reply-To: <51237586.6030201@arcor.de>
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

On 02/19/2013 01:52 PM, Christopher Hahn wrote:

> Do you have any idea how to solve the problem?
> Even if the system receives interrupts at IRQ 4, the program doesn't 
> receive any message from the serial port with this kernel configuration.


Trying to register the irq handler as level instead of edge?

-- 
                                                                Gilles.

