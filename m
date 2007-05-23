Message-ID: <46543598.8030909@domain.hid>
Date: Wed, 23 May 2007 14:37:44 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Porting driver to RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hello,

I am working on porting a Linux VME driver to Xenomai. I am having some 
ideas on how to do this, but I would like to have some feedback on this.

There are 2 ways to communicate to devices on the VME bus: memory mapped 
and using interrupts. At this moment I setup the memory mapping when the 
system starts, and then use these mapped areas to read and write from 
the devices. The interrupts are processed using a standard interrupt 
handler, and a "Wait for interrupt" IOCTL-call is available to wait for 
a specific interrupt. The driver defines several VME devices: some 
control devices and some data devices.

My plans for the new driver are to have an RTDM driver next to the 
standard Linux driver. I will be using the standard driver for the setup 
of the system, like setting up the memory mapping. The RTDM driver will 
define a RT-control device to perform the interrupt handling and an RTDM 
IOCTL will be used to wait for the interrupts. This way I can have a 
RT-thread to process the interrupts.

The reason for this setup are:

    * I do not want to rewrite the current driver, as this driver
      already has all the functionality needed, except for the
      RT-performance.
    * The interface to VME devices is done using memory access and no
      other SW is needed for this. This means that during operational
      use no driver functions will be accessed.
    * The memory mapping is not as straight forward in RTDM as it is in
      standard Linux: for example there is no mmap function in the
      device structure.
    * I can still use drivers for VME devices that depend on the current
      driver.


Is this the right way to do this, or are there other ways to implement a 
driver like this one?

Kind regards,
    Johan Borkhuis

