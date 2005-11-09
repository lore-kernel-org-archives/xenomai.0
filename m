Message-ID: <009101c5e516$02bd2a80$1000000a@domain.hid>
From: "Hans-J. Ude" <ude@domain.hid>
Date: Wed, 9 Nov 2005 11:11:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Module loading problems
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

I've installed Xenomai 2.0.1 but can't load a module stack for the vxWorks
skin. Kernel is 2.6.13 with the included ipipe patch and I'm getting the
following results.

# insmod xeno_hal.ko
# insmod xeno_nucleus.ko
# insmod xeno_vxworks.ko
# insmod xeno_uvm.ko
insmod: error inserting 'xeno_uvm.ko': -1 Function not implemented

# insmod xeno_hal.ko
# insmod xeno_nucleus.ko
# insmod xeno_uvm.ko
# insmod xeno_vxworks.ko
insmod: error inserting 'xeno_vxworks.ko': -1 Device or resource busy

I've put some printk's into the nucleus modules and found that in the first
case there are two pointers which are compared when a subsequent modules is
loaded. Those pointers are expected to be equal but are unequal and the
module is rejected. Can someone tell what I can do here? Maybe there is
something wrong with the modules, with the distro (Suse 9.3) or maybe I'm
doing something wrong. I think i'm gonna try the original gnu modutils next
and get rid of that Suse stuff.

regards,
Hans


