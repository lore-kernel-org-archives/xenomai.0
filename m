Message-ID: <5490C06F.4080901@nta-inc.net>
Date: Tue, 16 Dec 2014 17:29:51 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I am testing the rtnet functionality in the 'next' branch of xenomai-3.git.  (I now also have Xenomai-2.6.4/rtnet.git running on the same machine for comparison.)  I am able to bring up the real-time interface (rt_e1000e) and use rtping as expected. As mentioned before, I have a primary non-rt ethernet interface running simultaneously (using the e1000e driver).   When I try to remove all the rtnet modules, I am unable to remove rtnet and rtipv4:

$ rmmod rtipv4 rtnet
rmmod: ERROR: Module rtipv4 is in use
rmmod: ERROR: Module rtnet is in use by: rtipv4

The messages are the same if I try to remove them individually.  This behavior does not occur with Xenomai-2.6.4/rtnet.git.

I also have issues when I try to load the rtudp and/or rtpacket modules:

$ sudo modprobe rtnet
$  sudo modprobe rtipv4
$ sudo modprobe rtpacket
modprobe: ERROR: could not insert 'rtpacket': Invalid argument
$ sudo modprobe rtudp
modprobe: ERROR: could not insert 'rtudp': Invalid argument

I thought that this triggered an I-pipe trace in the past, but I can't reproduce that at the moment.  The 'Invalid argument' error code is coming from rtdm_dev_register, right?

A superficial test of the "latency" program seems to run fine on this hardware/software configuration.

Here are some more details:

Hardware: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz
Linux: release 3.14.17

   $ cat /proc/cmdline
   BOOT_IMAGE=/boot/vmlinuz-3.14.17-xenomai-3.git.2014.11.27 root=UUID=3ec85b09-cb5d-42fe-bec7-106935ecf29d ro biosdevname=0

Xenomai: from git://git.xenomai.org/xenomai-3.git next

   $ version
   Xenomai/cobalt v3.0-rc2 -- #7a81ea8 (2014-11-27 22:02:32 +0100)

   $ xeno-config --info|grep -i build
   Build args: --prefix=/usr --includedir=/usr/include/xenomai --mandir=/usr/share/man --with-testdir=/usr/lib/xenomai/testsuite --build x86_64-linux-gnu build_alias=x86_64-linux-gnu

OS: Ubuntu 14.04

Any help resolving these issues would be appreciated.

Thanks,

-Jeff

