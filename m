Message-ID: <BLU436-SMTP79E4FBA0D080819091D8F2F0040@phx.gbl>
References: <CAJONJDvtgX6Lc27jTK9bA27XwyhTRwnEMpm58LP6+WaTDqK9Fw@mail.gmail.com>
 <CAJONJDtJ-eC4F8YvqGQ-n6jRO-uYA-SQTAkHvxy+G5QcYqXp0w@mail.gmail.com>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Thu, 26 Nov 2015 12:52:39 -0800
MIME-Version: 1.0
In-Reply-To: <CAJONJDtJ-eC4F8YvqGQ-n6jRO-uYA-SQTAkHvxy+G5QcYqXp0w@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: [PATCH] IPIPE patch for BCM2709/RPI2 (version #5)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Joe Lee <joelee271828@gmail.com>, xenomai@xenomai.org

On 15-11-26 03:28 AM, Joe Lee wrote:
> Hi Mathieu,
> Thanks for your patch.
> I apply your patch to my RPI2, but sometimes the booting hang like this
> [    7.407819] Xenomai: stuck on nucleus lock 808b14a0
> [    7.407819]    waiter = kernel/xenomai/nucleus/intr.c:114
> (xnintr_clock_handler(), CPU #2)
> [    7.407819]    owner  = kernel/xenomai/nucleus/intr.c:114
> (xnintr_clock_handler(), CPU #1)
> 
> That's low probability, about 1 of 50 times booting.
> The xenomai source is from xenomai-2.6 git repositories, commit is
> 199445423781daa4a7f1ade46a9e4559aad1468a.
> The kernel is newest version of raspberry 3.18.16,
> https://github.com/raspberrypi/linux/tree/rpi-3.18.y .
> First, I apply the ipipe patch "ipipe-core-3.18.20-arm-6.patch" from
> https://xenomai.org/downloads/ipipe/v3.x . Then I apply your RPI
> patch version #5.
> The root file system if Ubuntu 14.04 LTS for RPI2, which from
> https://wiki.ubuntu.com/ARM/RaspberryPi .
> Attached is the kernel booting hang log file and kernel config file.
> May be I forget something or make mistakes.
> Look forward to your reply.
> 
> --
> Joe Lee
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: kernel_booting_log
> Type: application/octet-stream
> Size: 29666 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20151126/6f93985d/attachment.obj>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: kernel_config
> Type: application/octet-stream
> Size: 111471 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20151126/6f93985d/attachment-0001.obj>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
> 
Hi Joe,

Thanks for trying the patch.
The patch is actually for xenomai-3, I have not tried it on xenomai-2.6
The way you apply the patch looks good to me, but there is likely
something missing in the patch for xenomai-2.6.
There is a patch for the rpi (the first version) for xenomai-2.6 here
for reference:
http://wiki.linuxcnc.org/cgi-bin/wiki.pl?RaspbianXenomaiBuild
you may have to take some parts and put it in the patch to get it to
work with the rpi version2 for xenomai-2.6.

does that make sense?
-Mathieu

