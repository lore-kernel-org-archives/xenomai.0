From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1281538723.2246.120.camel@domain.hid>
References: <1278943817.7023.18.camel@domain.hid>  <4C3EF6D6.6040907@domain.hid>
	<1279210298.1995.38.camel@domain.hid>
	<1279623645.2187.35.camel@domain.hid>  <4C469259.3000708@domain.hid>
	<1281538723.2246.120.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Aug 2010 17:28:07 +0200
Message-ID: <1281540487.1730.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Marvell sheeva support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tim Cussins <timcussins@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-08-11 at 15:58 +0100, Tim Cussins wrote:
> Hi guys,
> 
> Managed to get started on the Sheevaplug/xenomai stuff:
>   Used mkrootfs. Cool.
>   Massaged the mv88fxxxx patch so that it builds with 2.6.33.
>   Can't log into the device to run tests. Augh.
> 
> Details below! :P
> 
> On Wed, 2010-07-21 at 08:23 +0200, Gilles Chanteperdrix wrote:
> > Tim Cussins wrote:
> > >>> We can also provide you with a root filesystem for validating this platform.
> > > 
> > > That would be brilliant. I imagine I'll be iterating though uImages on
> > > an SD card loaded with your rootfs. Sound ok? Let me know how to obtain
> > > the rootfs (or better, show me how you prefer to do it, so I learn
> > > something! Ta.)
> > 
> > You will find the rootfs for orion SOCs, here:
> > http://www.xenomai.org/~gch/pub/rootfs-orion.tar.bz2
> > 
> > Edit etc/inittab to modify the serial console it needs (if it is not
> > /dev/ttyS0 running at 115200 bauds). The rootfs is meant to be booted by
> > NFS with the kernel IP auto-configuration, so, if you want to boot it on
> > an SD card, you will have to connect to the serial console once the
> > board is booted, and run "udhcpc" to configure the network by DHCP, or
> > use ifconfig to configure it by hand, then launch "telnetd" to be able
> > to connect to that board through telnet (if the kernel booted by NFS,
> > the telnet server will have been launched automatically)
> > 
> > In a first telnet session, run:
> > latency
> > In a second telnet session, if you have FCSE disabled, run:
> > dohell
> > if you have FCSE enabled, run:
> > noltp_hell 14400
> > (14400 means that you will generate some load during 14400s, that is 4
> > hours).
> > When either noltp_hell or dohell displays the line:
> > Listening on any address 5566
> > On the host, run:
> > netcat <target-ip> 5566 > /dev/null
> > 
> > Now you can return to the telnet session running latency. When the test
> > is finished the latency program should stop.
> > 
> > As for generating the root filesystem, it is not that it is really hard,
> > but it is a bit tedious. So, we made a tool to build a root filesystem
> > which suits our needs, that is testing Xenomai under load. I have just
> > finished working on a version of this tool (called mkrootfs, but I think
> > we should find a better name, as this one already exists) user-friendly
> > enough to be published. Currently, it is still lacking a documentation.
> > You will find it here:
> > 
> > http://www.xenomai.org/~gch/pub/mkrootfs.tar.bz2
> > 
> > However, to use it, you will need a few explanations. It is based on
> > Kbuild, the Linux kernel build system, so, it will build the same way.
> > Create a build directory, cd to it, then run:
> > 
> > make -C /path/to/mkrootfs O=`pwd` xconfig
> > 
> > Tweak the configuration. Then run:
> > make
> > 
> > It should build everything.
> > 
> > It does not download and patch the sources of the packages it uses, you
> > have to do this yourself, then pass the path where to look for them to
> > the configuration system. We use standard versions of the packages,
> > except for LTP, which we modified a bit to run on low-end platforms, and
> > which you can find here:
> > 
> > http://www.xenomai.org/~gch/ltp-20081130-patched.tar.bz2
> 
> 
> I've had a good play with mkrootfs - nice. I had to make a couple of
> changes to meet my needs (and system, ubuntu 10.04). Is there a git repo
> for mkrootfs that I can base my patches on? They're very small btw. More
> on that off-list if you want.
> 
> > 
> > >> You can also use the patch below as a starting point for your port:
> > >> http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.29-mv88f6290.patch
> > > 
> > > I've tried applying this to vanilla 2.6.29 and 2.6.29.6 - it doesn't
> > > apply cleanly (well, fails :P). Am I approaching this the wrong way?
> > > Also tried chucking the patch into the xenomai tree and getting
> > > prepare_kernel.sh to try: still no joy.
> > 
> > It probably does not apply to vanilla because vanilla has no support for
> > the Sheevaplug board. Or am I missing something?
> 
> Well, I don't think so. Some hunks are expecting lines of context that
> simply don't exist in 2.6.29 == fail.
> 
> I took the mv88f6290 patch and bullied it into applying to vanilla
> 2.6.29. Built ok, but was at home and no way to test, so I just got on
> with migrating it to 2.6.33. That seems to be done - check the 2.6.33
> boot output:
>   
>    ...
>   I-pipe: Domain Xenomai registered.
>   Xenomai: hal/arm started.
>   Xenomai: scheduling class idle registered.
>   Xenomai: scheduling class rt registered.
>   Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
>   Xenomai: starting native API services.
>   Xenomai: starting POSIX services.
>   Xenomai: starting RTDM services.
>    ...
> 
> Full boot output is attached FYI.
> 
> However, I've got a problem with busybox/getty and /dev/ttyS0 so I can't
> log in via console OR telnet. Once that's solved, I'll be able to run
> the xenomai tests. (In case you've seen it before - /var/log/messages is
> slowly filling with:
> 
> Aug 11 16:03:36 init: starting pid 638, tty '/dev/ttyS0': '/sbin/getty
> 115200 ttyS0'
> Aug 11 16:03:36 getty[638]: ttyS0: TCGETS: Inappropriate ioctl for
> device
> 
> )
> 

Does /dev/ttyS0 have major=4, minor=64 on your rootfs?

> Cheers,
> Tim
> 

-- 
Philippe.



