MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 24 May 2016 17:48:48 +0200
From: mfinkbei <mfinkbei@stud.hs-heilbronn.de>
In-Reply-To: <48747eda7ad827e2f69dd3d159a606bc@stud.hs-heilbronn.de>
References: <0abe0634dbf999057bf8529e0cc0ecd8@stud.hs-heilbronn.de>
 <20160523075954.GJ13609@hermes.click-hack.org>
 <674a5761ce5e9da1774b90b499a2e3d6@stud.hs-heilbronn.de>
 <20160524135324.GA11602@hermes.click-hack.org>
 <48747eda7ad827e2f69dd3d159a606bc@stud.hs-heilbronn.de>
Message-ID: <b19757cdceb6cde95fb69b49a99f1361@stud.hs-heilbronn.de>
Subject: Re: [Xenomai] Xenomai on Udoo Neo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Tue, May 24, 2016 at 05:13:16PM +0200, mfinkbei wrote:
> Am 2016-05-24 15:53, schrieb Gilles Chanteperdrix:
> > On Tue, May 24, 2016 at 03:28:08PM +0200, mfinkbei wrote:
> >> Am 2016-05-23 09:59, schrieb Gilles Chanteperdrix:
> >> > On Mon, May 23, 2016 at 09:49:18AM +0200, mfinkbei wrote:
> >> >> Hi,
> >> >
> >> > Hi,
> >> >
> >> >>
> >> >> I am writing to request some Details about the Xenomai using for an
> >> >> Udoo
> >> >> Neo.
> >> >> In my currently Thesis I'm working for the first time with an
> >> >> real-time
> >> >> System.
> >> >> One objective therefore is to install Xenomai 3 on the Udoo Neo board
> >> >> with an iMX6 multicore Processor.
> >> >> For the board exist a Linux-Version on the base of the Linux kernel
> >> >> 3.14.56.
> >> >> For this kernel Version there no i-pipe patch available. This is why I
> >> >> was looking for differences in the affected Files of the kernel
> >> >> 3.14.44
> >> >> and 3.14.56 and Change the i-pipe-patch when there are differences.
> >> >> Afterwards, I was able to patch the Udoo Neo Kernel, to make the
> >> >> config,
> >> >> the bzImage and the modules and Install it from an Computer with
> >> >> Linux-OS to the SD-Card as described in the Documentation.
> >> >> At that time of the Installation I kept on working with the Udoo Neo
> >> >> Board. For Configuring and building the ARM libraries I use the
> >> >> commands
> >> >> ./scripts/bootstrap
> >> >> sudo ../configure CFLAGS="-march=armv7-a" LDFLAGS="-march=armv7-a"
> >> >> --with-core=cobalt --enable-smp
> >> >>
> >> >> After the make install Command I wanted to test the Installation with
> >> >> dmesg | grep -i xenomai
> >> >> where I get the Output
> >> >>
> >> >> [    0.147853] [[01;31m[KXenomai[m[K] scheduling class idle
> >> >> registered.
> >> >> [    0.147865] [[01;31m[KXenomai[m[K] scheduling class rt
> >> >> registered.
> >> >> [    0.148004] [[01;31m[KXenomai[m[K] init failed, code -19
> >> >>
> >> >>   the full dmesg output in this time frame is
> >> >>
> >> >> [    0.146610] Bus freq driver module loaded
> >> >> [    0.147489] futex hash table entries: 256 (order: 2, 16384 bytes)
> >> >> [    0.147909] [Xenomai] scheduling class idle registered.
> >> >> [    0.147921] [Xenomai] scheduling class rt registered.
> >> >> [    0.148021] I-pipe: high-resolution clock not working
> >> >
> >> > Xenomai on cortex a9 uses the global timer as its high resolution
> >> > clock source. AFAICT, you have not enabled the global timer in the
> >> > kernel configuration, so you simply need to enable it.
> >> >
> >> > Also note that board-specific kernels drivers have generally a lower
> >> > quality than the mainline kernel, because they are not reviewed by
> >> > the Linux kernel community. So, rather than working with
> >> > board-specific kernel, it is advised to cleanup the board specific
> >> > drivers you need and submit them to the mainline kernel, so as to
> >> > get reviewed, which improves the drivers quality. And when it is
> >> > done, you no longer need the board-specific kernel.
> >> >
> >> > Regards.
> >>
> >> Thank you for your answer.
> >> The CONFIG_ARM_GLOBAL_TIMER is already enabled.
> >
> > Not in the kernel configuration you have sent to this list and that
> > is available here:
> > https://xenomai.org/pipermail/xenomai/attachments/20160523/1ce893f7/attachment.ksh
> >
> >> I also noticed that a mainline kernel would be better, especially for
> >> newbies in Xenomai.
> >> But the main scope of my master thesis includes the work with that
> >> developing board and the multicore Processor. The realisation of an
> >> real-time-system for the A9 Processor is just necessary for my work.
> >> I'm
> >> not familiar with the driver development, so it's not possible for me,
> >> to fix the problems there in reasonable time.
> >> I've recognized, that the drivers have a lower quality and didn't
> >> support the frequency scaling switch. For this reason I'm searching
> >> for
> >> a possibility to install Xenomai with enabled frequency scaling and
> >> then
> >> disabling the frequency scaling outside the kernel.
> >
> > Enabling frequency scaling should not prevent Xenomai from starting.
> > The issue you have is unrelated to frequency scaling.
> 
> But the contents of dmesg are the same as when CONFIG_ARM_GLOBAL_TIMER
> is enabled in the .config file.
> Do you know some other strategies to detect and correct the cause of 
> the
> error message?

Yes. Get the clock source properly registered. What version of the
I-pipe patch are you using? The problem might be that you use a
custom device tree file which does not include the mx6 device tree
include file which declares everything necessary for the global
timer. Or that the kernel fork you use use another device tree file.


-- 
					    Gilles.
https://click-hack.org

I adapted the I-pipe patch 3.14.44 to the kernel 3.14.56. The files, 
which will be changed in the patch for kernel 3.14.44 have just little 
differences.

Melanie



