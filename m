Date: Wed, 25 May 2016 12:11:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160525101146.GH13609@hermes.click-hack.org>
References: <0abe0634dbf999057bf8529e0cc0ecd8@stud.hs-heilbronn.de>
 <20160523075954.GJ13609@hermes.click-hack.org>
 <674a5761ce5e9da1774b90b499a2e3d6@stud.hs-heilbronn.de>
 <20160524135324.GA11602@hermes.click-hack.org>
 <48747eda7ad827e2f69dd3d159a606bc@stud.hs-heilbronn.de>
 <b19757cdceb6cde95fb69b49a99f1361@stud.hs-heilbronn.de>
 <0ffacf8b2a8fe70df9e590c2964e3639@stud.hs-heilbronn.de>
 <20160524180256.GM13609@hermes.click-hack.org>
 <82d75d19468fc00b0b447ba3fc5a9bcd@stud.hs-heilbronn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d75d19468fc00b0b447ba3fc5a9bcd@stud.hs-heilbronn.de>
Subject: Re: [Xenomai] Xenomai on Udoo Neo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfinkbei <mfinkbei@stud.hs-heilbronn.de>
Cc: xenomai@xenomai.org

On Wed, May 25, 2016 at 12:03:44PM +0200, mfinkbei wrote:
> Am 2016-05-24 20:02, schrieb Gilles Chanteperdrix:
> > 
> > No, the file
> > https://xenomai.org//downloads/ipipe/v3.x/arm/older/ipipe-core-3.14.44-arm-16.patch
> > does not contain this hunk. So, if the patch you are using contains
> > this hunk, you are not using ipipe-core-3.14.44-arm-16.patch.
> > 
> > Anyway, I can find the hunk a patch contains, downloading the patch
> > from the server. This is not what I am asking you. The question I
> > have been trying to ask three times and to which I can not find the
> > answer because I do not have the sources you use is: does the device
> > tree file you use include imx6ql.dtsi?
> > 
> > When you do not understand a question, I prefer you to tell me,
> > rather than giving a random answer. This is very irritating.
> 
> I apologize for the misunderstanding.
> 
> The imx6qdl.dtsi file is being included into the imx6q- .dts files.
> Those dts files are converted to dtb files using make (see 'Compile 
> Device Tree' below).
> The resulting dtb files are copied on the boot partition of the SD card 
> afterwards (see rest of description below).
> 
> Here the concerning part of the documentation to the Udoo Neo board:
> 
> Compile Device Trees
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make dtbs -j5
> 
> 
> Compile the modules
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make modules -j5
> 
> 
> Copy the kernel to the SD card
> 
> You can overwrite the kernel on a UDOObuntu SD card with the following 
> commands:
> BOOT_PARTITION=/path/to/boot-partition
> ROOT_PARTITION=/path/to/root-partition
> 
> cp arch/arm/boot/zImage $BOOT_PARTITION
> cp arch/arm/boot/dts/*.dtb $BOOT_PARTITION/dts
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make firmware_install 
> modules_install INSTALL_MOD_PATH=$ROOT_PARTITION
> 
> In addition to that I insert before the last make the following:
> cp .config /boot/config-3.14.56-udooneo-02013-gabdce68
> cp System.map /boot/System.map-3.14.56-udooneo-02013-gabdce68
> 
> 
> So as far as I understood an found out the imx6qdl.dtsi file should used 
> in the device tree.
> Am I right here?

Basically what you showed here does not show what particular dts
your device uses, since all the dtbs are copied. So, no, you do not
know yet if the dtb your device actually loads contains the
declaration of the global timer.

-- 
					    Gilles.
https://click-hack.org

