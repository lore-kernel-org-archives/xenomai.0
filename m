From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Live CD
Date: Sat, 7 Apr 2007 23:06:46 +0100
References: <46180AB8.3000905@domain.hid>
In-Reply-To: <46180AB8.3000905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704072306.46154.paul_c@domain.hid>
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


Hi Theo

On Saturday 07 April 2007 22:18, Theo Veenker wrote:
> I've managed to create a Xenomai Live CD based on the Ubuntu Dapper
> desktop install CD. Many webpages tell you how to do it (for instance
> https://help.ubuntu.com/community/LiveCDCustomization/6.06) but the
> important thing is to have squashfs and unionfs support in the kernel.
> The following is what I did.

> TODO:
>    - Remove Ubuntu Installer stuff from CD
>    - Remove unnecessary packages from the squashfs file system.
>    - Change isolinux/isolinux.cfg etc.

Having built a number of custom LiveCDs, it is much easier to start from 
scratch rather than trying to remove stuff from an existing build. Stripping 
down a build often leaves cruft behind...

> Here it goes (I think/hope I haven't forgotten any steps):

> Apply xenomai patches:
> Apply squashfs patches:
> Apply unionfs patches:

> Compile and install kernel. On my particular system this yields (v20 being
> my local version number):
>    /boot/vmlinuz-2.6.17.14-xenomai-v20
>    /lib/modules/2.6.17.14-xenomai-v20/

If my experiences with Debian/etch is anything to go by, the grub-update 
scripts will see "xeno" and tag the vmlinuz as a Xen virtual machine image. 
Probably not an issue for a LiveCD, but would be if it were to be used as an 
installation target..

> Compile and install xenomai. On my system this yields:
>    /usr/xenomai-2.3.0-v20/

Hrmm... This breaks the package management philosophy behind most 
distributions - However, there is a Debian rule set that negates that 
problem..

<snipped CLI>
> Retrieve ubuntu-6.06.1-desktop-i386.iso (http://www.ubuntu.com/)
> Loop-mount the ISO image and the squashfs file system contained in it.
> Copy contents of the ISO image and the squashfs file system.
> Remove unwanted stuff from ISO image.
> Unmount the squashfs file system and the ISO image.
> Modify squashfs contents; install custom kernel and modules.
> Build initrd.gz
> Put custom kernel and initrd in iso/casper/.
> Create new iso/casper/filesystem.manifest* files.
> Create squashfs file system file in iso/casper/.
> Recreate md5sum.txt.
> Create ISO image.
>
> Burn the ISO image onto a CD and boot from it (choose first option from
> menu). Once everything is up, open a terminal and in /usr/rt/bin run sudo
> ./latency

http://www.morphix.org has a set of tools that greatly simplifies the task of 
building LiveCDs - mmaker requires a simple XML file listing the main 
components to include on the ISO, and isomaker does the grunt behind the 
bootable parts. Having deb packages for both the kernel and Xenomai is an 
advantage if/when anyone wants to do an install or upgrade.

When unionfs is shown to be stable on a 2.6.20 kernel, it might be worth while 
setting up an autobuild system in conjunction with the Morphix project..
[Side note: I already do nightly Sarge based Morphix modules, so slipping in a 
Xenomai version once in a while is possible].


Regards, Paul.


