Message-ID: <4618A2BF.1030104@domain.hid>
Date: Sun, 08 Apr 2007 10:07:27 +0200
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Live CD
References: <46180AB8.3000905@domain.hid> <200704072306.46154.paul_c@domain.hid>
In-Reply-To: <200704072306.46154.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
> Hi Theo
> 
> On Saturday 07 April 2007 22:18, Theo Veenker wrote:
>> I've managed to create a Xenomai Live CD based on the Ubuntu Dapper
>> desktop install CD. Many webpages tell you how to do it (for instance
>> https://help.ubuntu.com/community/LiveCDCustomization/6.06) but the
>> important thing is to have squashfs and unionfs support in the kernel.
>> The following is what I did.
> 
>> TODO:
>>    - Remove Ubuntu Installer stuff from CD
>>    - Remove unnecessary packages from the squashfs file system.
>>    - Change isolinux/isolinux.cfg etc.
> 
> Having built a number of custom LiveCDs, it is much easier to start from 
> scratch rather than trying to remove stuff from an existing build. Stripping 
> down a build often leaves cruft behind...

So you are saying I went through all this ff-ing trouble for nothing?
You have all the knowledge and experience but did't bother putting it
to use for a Xenomai live CD? If it is not too much work maybe you could
put something together. I'm sure many people, including me, would be
interested.

> 
>> Here it goes (I think/hope I haven't forgotten any steps):
> 
>> Apply xenomai patches:
>> Apply squashfs patches:
>> Apply unionfs patches:
> 
>> Compile and install kernel. On my particular system this yields (v20 being
>> my local version number):
>>    /boot/vmlinuz-2.6.17.14-xenomai-v20
>>    /lib/modules/2.6.17.14-xenomai-v20/
> 
> If my experiences with Debian/etch is anything to go by, the grub-update 
> scripts will see "xeno" and tag the vmlinuz as a Xen virtual machine image. 
> Probably not an issue for a LiveCD, but would be if it were to be used as an 
> installation target..

Not on my systems. Anyway I didn't say how to do it, I said what I did.


> 
> http://www.morphix.org has a set of tools that greatly simplifies the task of 
> building LiveCDs - mmaker requires a simple XML file listing the main 
> components to include on the ISO, and isomaker does the grunt behind the 
> bootable parts. Having deb packages for both the kernel and Xenomai is an 
> advantage if/when anyone wants to do an install or upgrade.
> 
> When unionfs is shown to be stable on a 2.6.20 kernel, it might be worth while 
> setting up an autobuild system in conjunction with the Morphix project..
> [Side note: I already do nightly Sarge based Morphix modules, so slipping in a 
> Xenomai version once in a while is possible].

Would be nice. I'm very interested in having a (small) live cd which I can
customize and give to my clients.

Regards,
Theo


