Message-ID: <449A3AAE.7090403@domain.hid>
Date: Thu, 22 Jun 2006 08:37:34 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTDM driver add-on infrastructure
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hello,

I'm currently implementing a RTDM real-time CAN driver, which raises the 
the problem of adding the driver to the Xenomai source tree. My first 
idea was to provide RTCAN as a patch for Xenomai:

   $ cd xenomai
   $ patch -p1 < xenomai-rtcan-add-on.patch
   $ scripts/prepare_kernel ...
   ...
   $ <configure and make kernel>
   $ <configure, make and install Xenomai user space stuff>

This does not work because of autoconf files needed to copy header files 
to the installation path. Is this really necessary?
Another issue is where to put utility and test programs. Making them 
without autoconf and friends works by using xeno-config. But they should 
be installed with make install as well. Likely there are other issues.

Any ideas or comments on how to provide a generic RTDM driver add-on 
infrastructure?

Wolfgang.


