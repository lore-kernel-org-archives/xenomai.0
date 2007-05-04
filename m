From: NZG <ngustavson@domain.hid>
Date: Fri, 4 May 2007 10:27:52 -0500
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705041027.52872.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTDM problems with structures in headers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Background
-------------------------
I'm developing an rtdm for some simple io inside a PLD.
This io is detected by a standard linux driver and used to register kobject 
classes in the main driver.
This in turn results in the registration of a named rtdm driver with the same 
name as the class, which calls down into the classes standard low level 
methods using and RTDM atomic lock around the actual memory mapped 
manipulation.
In this way I hope to create a standard, kernel detected,  interface to 
standard user space and rtdm for simple io devices.

The RTDM device has no "private data" pointer for pointing to outside data 
structures. I would like to avoid modifying it's basic structure to maintain 
compatibility with future releases, and in general to avoid modifying the 
real time core whenever possible.

To get around I have an rtdm device inside the standard class structure, and 
then use the 2.6 "container of" macro from the rtdm driver to get access to 
the original class.  

Problems 
-------------------------
Placing the rtd device inside the standard structure results in the need to 
add extra flags (-Iinclude/xenomai) to every Makefile which contains a device 
including the header file reference to xenomai in it.

Question
------------------------
Essentially, what is the recommended way to:

Pass pointers to a rtdm driver from regular kernel space, which can be 
maintained into the rtdm fops (without resorting to global variables).

Allowing for the assumption that the standard kernel process holding the data 
is responsible for registering the real time driver.

thx,
NZG














