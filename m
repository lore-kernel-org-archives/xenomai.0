Message-Id: <FF4AEA86-A68E-499B-8F05-D9AA5398C5CC@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
In-Reply-To: <mailman.3.1399716001.21151.xenomai@xenomai.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Sat, 10 May 2014 15:27:59 +0100
References: <mailman.3.1399716001.21151.xenomai@xenomai.org>
Subject: Re: [Xenomai] New Xenomai kernels for testing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Michael,

>
>> Something completely unrelated, do LinuxCNC/MachineKit users use
>> Comedi/Analogy? If yes, we would be interested in users willing to  
>> test
>> ports of Comedi drivers to the Analogy framework.
>
> This has come up every now and then, but these disparate attempts  
> have not found their way into the main codebase; recently there was  
> another stab at the issue: http://c-416.ahl.uni-linz.ac.at:8080/gitweb/?p=linuxcnc/.git;a=commitdiff;h=ffe5844c526ee4762e0cf9f294b660ae9abfdfea
>
> I think data acquisition is very much in scope for machinekit; its  
> HAL 'virtual circuit' subsystem does make such things much more  
> enduser-friendly in use
>
> I'd be happy to give that a try even just to show how it can be  
> done, and others could build on it; I just would have to locate a  
> piece of hardware which I could use for such an experiment; I dont  
> own any of the - seemingly mostly PC - peripherals listed on the  
> comedi site; any suggestion for the 'hello world' type driver with  
> common hardware? is there any non-PC (eg ARM embedded) driver I  
> could start with?

In my recent quest to get to grips with Analogy I found the 'fake'  
driver

http://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/analogy/testing

quite instructive, which also doesn't require any real hardware since  
it emulates 'fake' hardware... this obviously also has the advantage  
that it provides a testbench for the user-space interface on all  
platforms.

A.





