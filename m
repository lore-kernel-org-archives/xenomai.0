Message-ID: <4C469259.3000708@domain.hid>
Date: Wed, 21 Jul 2010 08:23:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278943817.7023.18.camel@domain.hid> <4C3EF6D6.6040907@domain.hid>	
	<1279210298.1995.38.camel@domain.hid>
	<1279623645.2187.35.camel@domain.hid>
In-Reply-To: <1279623645.2187.35.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

Tim Cussins wrote:
>>> We can also provide you with a root filesystem for validating this platform.
> 
> That would be brilliant. I imagine I'll be iterating though uImages on
> an SD card loaded with your rootfs. Sound ok? Let me know how to obtain
> the rootfs (or better, show me how you prefer to do it, so I learn
> something! Ta.)

You will find the rootfs for orion SOCs, here:
http://www.xenomai.org/~gch/pub/rootfs-orion.tar.bz2

Edit etc/inittab to modify the serial console it needs (if it is not
/dev/ttyS0 running at 115200 bauds). The rootfs is meant to be booted by
NFS with the kernel IP auto-configuration, so, if you want to boot it on
an SD card, you will have to connect to the serial console once the
board is booted, and run "udhcpc" to configure the network by DHCP, or
use ifconfig to configure it by hand, then launch "telnetd" to be able
to connect to that board through telnet (if the kernel booted by NFS,
the telnet server will have been launched automatically)

In a first telnet session, run:
latency
In a second telnet session, if you have FCSE disabled, run:
dohell
if you have FCSE enabled, run:
noltp_hell 14400
(14400 means that you will generate some load during 14400s, that is 4
hours).
When either noltp_hell or dohell displays the line:
Listening on any address 5566
On the host, run:
netcat <target-ip> 5566 > /dev/null

Now you can return to the telnet session running latency. When the test
is finished the latency program should stop.

As for generating the root filesystem, it is not that it is really hard,
but it is a bit tedious. So, we made a tool to build a root filesystem
which suits our needs, that is testing Xenomai under load. I have just
finished working on a version of this tool (called mkrootfs, but I think
we should find a better name, as this one already exists) user-friendly
enough to be published. Currently, it is still lacking a documentation.
You will find it here:

http://www.xenomai.org/~gch/pub/mkrootfs.tar.bz2

However, to use it, you will need a few explanations. It is based on
Kbuild, the Linux kernel build system, so, it will build the same way.
Create a build directory, cd to it, then run:

make -C /path/to/mkrootfs O=`pwd` xconfig

Tweak the configuration. Then run:
make

It should build everything.

It does not download and patch the sources of the packages it uses, you
have to do this yourself, then pass the path where to look for them to
the configuration system. We use standard versions of the packages,
except for LTP, which we modified a bit to run on low-end platforms, and
which you can find here:

http://www.xenomai.org/~gch/ltp-20081130-patched.tar.bz2


>> You can also use the patch below as a starting point for your port:
>> http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.29-mv88f6290.patch
> 
> I've tried applying this to vanilla 2.6.29 and 2.6.29.6 - it doesn't
> apply cleanly (well, fails :P). Am I approaching this the wrong way?
> Also tried chucking the patch into the xenomai tree and getting
> prepare_kernel.sh to try: still no joy.

It probably does not apply to vanilla because vanilla has no support for
the Sheevaplug board. Or am I missing something?

-- 
					    Gilles.

