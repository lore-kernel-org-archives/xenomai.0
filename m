From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200705011227.10534.ngustavson@domain.hid>
References: <200705011227.10534.ngustavson@domain.hid>
Content-Type: text/plain
Date: Fri, 04 May 2007 06:28:11 +0200
Message-Id: <1178252891.29093.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Uclinux-dist-devel] passing memory pointers
	through sysfs
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
To: NZG <ngustavson@domain.hid>
Cc: uclinux-dist-devel@domain.hid, xenomai@xenomai.org

On Tue, 2007-05-01 at 12:27 -0500, NZG wrote:
> Our Blackfin boards use memory mapped PLD's to create expandable io 
> interfaces.
> I've created a driver which detects the version of PLD core and creates 
> appropriate sysfs classes for it, providing a simple interface.
> 
> I want Xenomai to have access to the devices in the PLD, which mean that 
> ideally, I want the kernel to hand the real time user space applications a 
> memory map of the PLD.
> 
> Ideally, I'd like create device node(s) through sysfs, which Xenomai could 
> then access on initialization to get a memory map for it's devices.
> 
> Is this possible?

Is your question about accessing the device node from a user-space
Xenomai thread (which is ok), or about making use of the retrieved
memory map information to map the device memory?

-- 
Philippe.



