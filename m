MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2017 19:27:12 -0500
From: andrija@stupar.com
Message-ID: <07fe7fa20faed6e818d33b54db9001b6@stupar.com>
Sender: andrija@stupar.com
Subject: [Xenomai] RTDM driver init: interrupts and context objects
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am using Xenomai 2.6.3 and I'm porting a Linux driver for an Acromag 
PCI DAQ board to RTDM.

Since RTDM in Xenomai 2.6.3 does not support minor device numbers, and 
there are possibly multiple PCI boards which must be accessed by this 
driver, I am following the example given for the 16550 UART driver in 
the Xenomai 2.6.3 source repository. There, we have a rtdm_device 
template with a blank name and inside the init_module() function the 
driver searches for multiple devices, and then assigns them names and 
registers each of them separately (i.e. rtserial0, rtserial1, rtserial2, 
etc.) so that each can be accessed as a separate device via the RTDM 
device table. This driver maintains a static array of rtdm_device, 
keeping there an instance of each detected device. So far so good. I am 
following the same approach in my driver.

However, I see some differences with which I am stuck.

The driver I am porting to RTDM scans for PCI devices in the 
init_module() method, and then, for each device found, performs some 
set-up stuff including - this is the most important thing - setting up 
an IRQ line.

The RTDM UART driver I am using as an example does not do this - it 
performs the IRQ line request (via rtdm_irq_request) in the open() 
method, NOT in the init_module() method. Is there any particular reason 
for this? Would it be incorrect to call rtdm_irq_request for each device 
in init_module() instead of in open(...)?

In order to call rtdm_irq_request, I require the irq handle, which is a 
field of the driver-specific context structure (e.g. in the UART driver 
case, rt_16550_context). I also have such a struct which stores some 
information about my device. Notwithstanding the IRQ setup, some of the 
information I would like to store in my context struct is arrived at 
during the operations in init_module(). However, I cannot see how to 
pass a context struct which I would create in init_module() properly 
when registering a device...? So far, it seems that any data that I 
obtain during init_module() I would have to save in e.g. static arrays, 
and then copy that into the context struct in open(...) where I can 
access the context struct for that particular device. Or do I have 
something wrong?

Any help is greatly appreciated!

Thanks,

Andrija Stupar
Univ. of Toronto

