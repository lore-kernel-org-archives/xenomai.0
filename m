Message-ID: <536E1157.1020205@xenomai.org>
Date: Sat, 10 May 2014 13:45:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <536D0CB1.3010604@zultron.com> <536D15D0.7090604@xenomai.org>
 <F0C01DEF-AA0B-4495-BA79-7AEB5DE5A961@mah.priv.at>
In-Reply-To: <F0C01DEF-AA0B-4495-BA79-7AEB5DE5A961@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] New Xenomai kernels for testing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>, xenomai@xenomai.org

On 05/10/2014 07:10 AM, Michael Haberler wrote:
> Gilles,
> 
> 
> Am 09.05.2014 um 19:52 schrieb Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org>:
> 
>> Something completely unrelated, do LinuxCNC/MachineKit users use 
>> Comedi/Analogy? If yes, we would be interested in users willing to
>> test ports of Comedi drivers to the Analogy framework.
> 
> This has come up every now and then, but these disparate attempts
> have not found their way into the main codebase; recently there was
> another stab at the issue:
> http://c-416.ahl.uni-linz.ac.at:8080/gitweb/?p=linuxcnc/.git;a=commitdiff;h=ffe5844c526ee4762e0cf9f294b660ae9abfdfea
> 
> 
> I think data acquisition is very much in scope for machinekit; its
> HAL 'virtual circuit' subsystem does make such things much more
> enduser-friendly in use
> 
> I'd be happy to give that a try even just to show how it can be done,
> and others could build on it; I just would have to locate a piece of
> hardware which I could use for such an experiment; I dont own any of
> the - seemingly mostly PC - peripherals listed on the comedi site;
> any suggestion for the 'hello world' type driver with common
> hardware? is there any non-PC (eg ARM embedded) driver I could start
> with?

There is one driver for the PC parallel port, which should be
universally available... on PCs. I do not believe we have any driver for
ARM.

> 
> is
> http://git.xenomai.org/xenomai-forge.git/tree/kernel/drivers/analogy?h=next
> the place to start looking?

Analogy is also present in xenomai 2.6, since you are using 2.6, for a
first attempt, it would make sense to start from there.

Thanks.

-- 
                                                                Gilles.

