Message-ID: <486693E8.2030904@domain.hid>
Date: Sat, 28 Jun 2008 21:41:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1KCdDN-0007XY-Dw@domain.hid> <48667CE8.60305@domain.hid>
In-Reply-To: <48667CE8.60305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-commits] r3998 - in /trunk: ./
 doc/doxygen/ doc/txt/ include/ include/asm-generic/ include/comedi/
 include/compat/linux/ ksrc/drivers/ ksrc/drivers/comedi/ ksrc/skins/
 ksrc/skins/comedi/ src/skins/ src/skins/comedi/ src/utils/
 src/utils/comedi/
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Author: rpm
>> Date: Sat Jun 28 18:23:51 2008
>> New Revision: 3998
>>
>> URL: http://svn.gna.org/viewcvs/xenomai?rev=3998&view=rev
>> Log:
>> Merge COMEDI over RTDM framework
>>
>> Added:
> ...
>>     trunk/ksrc/skins/comedi/
>>     trunk/ksrc/skins/comedi/Config.h
>>     trunk/ksrc/skins/comedi/Config.in
>>     trunk/ksrc/skins/comedi/Kconfig
>>     trunk/ksrc/skins/comedi/Makefile
>>     trunk/ksrc/skins/comedi/buffer.c
>>     trunk/ksrc/skins/comedi/command.c
>>     trunk/ksrc/skins/comedi/device.c
>>     trunk/ksrc/skins/comedi/driver.c
>>     trunk/ksrc/skins/comedi/driver_facilities.c
>>     trunk/ksrc/skins/comedi/instruction.c
>>     trunk/ksrc/skins/comedi/interface.c
>>     trunk/ksrc/skins/comedi/os_facili. ties.c
>>     trunk/ksrc/skins/comedi/subdevice.c
>>     trunk/ksrc/skins/comedi/transfer.c
>>     trunk/src/skins/comedi/
>>     trunk/src/skins/comedi/Makefile.am
>>     trunk/src/skins/comedi/Makefile.in
>>     trunk/src/skins/comedi/async.c
>>     trunk/src/skins/comedi/descriptor.c
>>     trunk/src/skins/comedi/info.c
>>     trunk/src/skins/comedi/range.c
>>     trunk/src/skins/comedi/sync.c
>>     trunk/src/skins/comedi/sys.c
> 
> Why did these parts went in as a skin? As far as I can see, comedi4rtdm
> is a pure driver stack, _using_ the RTDM skin. I didn't find any Xenomai
> nucleus reference on first glance,

Actually, I never meant skins to be defined by their relation to the nucleus
interface, but only because they would provide a particular interface to the
applications; the way they implement their services internally has no incidence
here.

Btw, the assertion that a skin should be based on the nucleus interface will
become false in 3.x, where some of the 2.x emulators will move to userland, on
top of an emulation layer that will be interface-compatible between SOLO and the
co-kernel world (no, this will _not_ be the UVM resurrected).

 so the whole thing should, in theory,
> be directly portable over Native-RTDM - another sign that it isn't a
> skin.

That is in fact the reason why ksrc/skins/comedi should indeed move to
ksrc/drivers, and specific data acquisition drivers should be subdirs of that
toplevel, the same way the can stack is implemented, i.e. as a driver stack. So
yes, my mistake (Alex was surprised too when I decided to make this a skin on
its own). I'll make this a driver stack instead.

 IMHO, it should rather populate only ksrc/drivers and, e.g.,
> src/drvlibs/comedi.
> 

-- 
Philippe.

