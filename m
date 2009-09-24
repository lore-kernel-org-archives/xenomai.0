MIME-Version: 1.0
Date: Thu, 24 Sep 2009 17:12:41 -0400
Message-ID: <9b3e2dc20909241412n7567401bpd768a6678a5c9158@domain.hid>
From: Stephen Sinclair <radarsat1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] rtdm, where to initialize pci private data?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm trying to port a PCI driver to Xenomai/RTDM.  I'm a bit confused
about how to handle private data.  The open/close/ioctl functions
receive a context pointer, which is a struct + the context_size
length.  So this is where I guess you are supposed to put private
data, initialized in the open() function.

However, the driver I'm porting does initialization (i.e,. gets base
addresses, etc) in the probe() function.  It gets base addresses from
the pci_dev struct which is passed to it.  In the probe function I
have no rtdm_dev_context, so I can't initialize the private data
there.  In the open function I have no pci_dev so I can't do it there
either.  I could allocate some memory and store it in
rtdm_device.device_data, but this isn't available to the
open/close/ioctl functions.

So I presume rtdm_context is created sometime during
rtdm_dev_register() (called in probe), but how do I access it for
writing?

thanks,
Steve

