MIME-Version: 1.0
References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
 <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
 <73a5c9f6-5014-5113-1ddd-2fcf974273bb@siemens.com>
 <CAOuPNLjuB53ovnEBijNSqrgsKYcSGjLM-L=J4mfbRogwo_5kVA@mail.gmail.com>
 <CAOuPNLh2C8b1KC5D6+Lws_1UA0o0Sp_BaPb3mUTyebUPq_EduA@mail.gmail.com>
In-Reply-To: <CAOuPNLh2C8b1KC5D6+Lws_1UA0o0Sp_BaPb3mUTyebUPq_EduA@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 21 Jun 2018 16:50:40 +0530
Message-ID: <CAOuPNLiCfmUrDMWyX=N37hVJTBDEqwOtoOr1srf-55ks1qms+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Kernel oops during rtnet loopback usage on x86_64
	(e1000e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>, Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Jan, Greg,

Is there any pointer about this issue?
This is blocking my next work..

If there is already a fix available for it, please let me know.
Or, should I need analyze this freshly....
I wonder why no body else is facing this issue....

Thanks,
Pintu



On Wed, Jun 20, 2018 at 1:24 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> Can someone help me with this issue.
> I compared the xenomai-3 next repo
> (next/kernel/drivers/net/stack/ipv4/udp/udp.c) and the changes are
> almost same.
> Now I am stuck with this..
> Please help!
>
> Is there any test available for rtnet loopback ?
>
> Regards,
> Pintu
> On Tue, Jun 19, 2018 at 7:18 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
> >
> > Hi,
> > I upgraded to xenomai-3-next branch for x86, but still rtnet loopback
> > is crashing for me.
> > The xenomai kernel is used from 4.9.51 until
> > commit: 10605b427b1408cdc6926f7c25d4a4eda527da8d
> >     Author: Philippe Gerum <rpm@xenomai.org>
> >     Date:   Mon Mar 26 09:17:02 2018 +0200
> >
> >         ipipe-core-4.9.51-x86-5
> >
> > Is the rtnet loopback working with 4.9 ?
> > Please let me know if this issue is fixed already ?
> >
> > This is the kernel logs:
> > ------------------------------------------
> > [612871.612307]
> >                 *** RTnet for Xenomai v3.1-devel ***
> >
> > [612871.612310] RTnet: initialising real-time networking
> > [612906.855980] initializing loopback...
> > [612906.855998] RTnet: registered rtlo
> > [613075.162006] BUG: unable to handle kernel paging request at 00007ffc7893b148
> > [613075.162009] IP: [<ffffffffc0a0503e>] rt_udp_getfrag+0x3e/0x110 [rtudp]
> > [613075.162013] PGD 744f76067
> > [613075.162014] PUD 80e1ae067
> > [613075.162015] PMD 6893dd067
> > [613075.162015] PTE 8000000581853867
> >
> > [613075.162018] Oops: 0001 [#1] SMP
> > [613075.162019] Modules linked in: rt_loopback rtpacket rtudp rtipv4
> > rtnet binfmt_misc 8021q garp mrp stp llc rfcomm bnep
> > snd_hda_codec_hdmi nls_iso8859_1 eeepc_wmi intel_rapl btusb asus_wmi
> > x86_pkg_temp_thermal btrtl sparse_keymap intel_powerclamp coretemp
> > ath10k_pci kvm ath10k_core irqbypass ath mac80211 crct10dif_pclmul
> > crc32_pclmul ghash_clmulni_intel aesni_intel snd_hda_codec_realtek
> > aes_x86_64 snd_hda_codec_generic lrw cfg80211 gf128mul glue_helper
> > ablk_helper snd_hda_intel cryptd snd_hda_codec snd_hda_core input_leds
> > snd_hwdep mei_me mei shpchp serio_raw hci_uart btbcm btqca btintel
> > bluetooth acpi_als kfifo_buf intel_lpss_acpi industrialio intel_lpss
> > mac_hid acpi_pad autofs4 hid_generic usbhid nouveau mxm_wmi ttm
> > psmouse e1000e ptp pps_core ahci libahci i2c_hid pinctrl_sunrisepoint
> > wmi hid video
> > [613075.162049]  pinctrl_intel fjes
> > [613075.162052] CPU: 0 PID: 12658 Comm: rtnet-client Not tainted
> > 4.9.51-amd-x86-64-pintu-xeno3-rtdm #4
> > [613075.162053] Hardware name: System manufacturer System Product Name/xxx
> > [613075.162054] I-pipe domain: Linux
> > [613075.162055] task: ffff903e8921da00 task.stack: ffff9e2f03348000
> > [613075.162056] RIP: 0010:[<ffffffffc0a0503e>]  [<ffffffffc0a0503e>]
> > rt_udp_getfrag+0x3e/0x110 [rtudp]
> > [613075.162058] RSP: 0018:ffff9e2f0334bb70  EFLAGS: 00010202
> > [613075.162059] RAX: 0000000000000000 RBX: 000000000000000a RCX:
> > 00007ffc7893b140
> > [613075.162060] RDX: 0000000000000000 RSI: ffff903e88e431e4 RDI:
> > ffff9e2f0334bc40
> > [613075.162061] RBP: ffff9e2f0334bb90 R08: ffff9e2f0334bdb8 R09:
> > 0000000000000000
> > [613075.162062] R10: ffff903e88e43100 R11: ffff90400c1c8800 R12:
> > ffff903e88e431e4
> > [613075.162063] R13: 0000000000000001 R14: ffff9e2f0334bc40 R15:
> > 000000000000001e
> > [613075.162064] FS:  00007f310b789740(0000) GS:ffff904016200000(0000)
> > knlGS:0000000000000000
> > [613075.162065] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > [613075.162066] CR2: 00007ffc7893b148 CR3: 0000000744e5b000 CR4:
> > 00000000003406f0
> > [613075.162067] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [613075.162067] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [613075.162068] Stack:
> > [613075.162069]  ffff9040121bec00 ffff90400e262240 ffff9e2f0334bdb8
> > 000000000000000a
> > [613075.162071]  ffff9e2f0334bc00 ffffffffc0a0f204 ffff903dd1a84500
> > ffff9e2f0334bc10
> > [613075.162074]  0000000000033768 ffff9e2f0334bc40 ffffffffc0a05000
> > 0000000f00000000
> > [613075.162076] Call Trace:
> > [613075.162091]  [<ffffffffc0a0f204>] rt_ip_build_xmit+0x1c4/0x2a0 [rtipv4]
> > [613075.162093]  [<ffffffffc0a05000>] ? 0xffffffffc0a05000
> > [613075.162094]  [<ffffffffc0a060db>] rt_udp_sendmsg+0x37b/0x3d0 [rtudp]
> > [613075.162097]  [<ffffffffa70a4676>] ? update_curr+0x66/0x180
> > [613075.162098]  [<ffffffffa70a67b8>] ? dequeue_entity+0x268/0xc00
> > [613075.162100]  [<ffffffffa718a117>] ? ___xnsched_run.part.73+0x3d7/0x400
> > [613075.162102]  [<ffffffffa70a4035>] ? hrtick_update+0x5/0x70
> > [613075.162103]  [<ffffffffa70a76d7>] ? dequeue_task_fair+0x587/0x900
> > [613075.162105]  [<ffffffffa71a0390>] ? CoBaLt_recvmmsg+0x30/0x30
> > [613075.162106]  [<ffffffffa71a0390>] ? CoBaLt_recvmmsg+0x30/0x30
> > [613075.162108]  [<ffffffffa719ad7b>] rtdm_fd_sendmsg+0xcb/0x240
> > [613075.162109]  [<ffffffffa71a0390>] ? CoBaLt_recvmmsg+0x30/0x30
> > [613075.162111]  [<ffffffffa71a03de>] CoBaLt_sendmsg+0x4e/0x70
> > [613075.162113]  [<ffffffffa71ad017>] ipipe_syscall_hook+0x117/0x340
> > [613075.162114]  [<ffffffffa712f9ff>] __ipipe_notify_syscall+0xbf/0x170
> > [613075.162116]  [<ffffffffa79007b7>] pipeline_syscall+0x8/0x1b
> > [613075.162118] Code: 54 49 89 f4 53 89 cb 8b 57 20 0f 85 c3 00 00 00
> > 85 d2 7e 2f 8b 47 24 45 31 ed 49 63 cd 89 c2 41 83 c5 01 48 c1 e1 04
> > 49 03 4e 18 <8b> 71 08 48 8b 39 e8 e7 f4 a0 e6 41 8b 56 20 41 89 46 24
> > 44 39
> > [613075.162141] RIP  [<ffffffffc0a0503e>] rt_udp_getfrag+0x3e/0x110 [rtudp]
> > [613075.162143]  RSP <ffff9e2f0334bb70>
> > [613075.162144] CR2: 00007ffc7893b148
> > [613075.162145] ---[ end trace 90458bf1f92e3557 ]---
> > On Thu, Apr 26, 2018 at 9:53 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >
> > > On 2018-04-25 13:36, Pintu Kumar wrote:
> > > > Dear Jan,
> > > >
> > > > Thank you so much for your reply.
> > > > I will try the latest stable version to check again.
> > > > Is ipipe patches (linux: 4.9.51) also needs to be upgraded for this
> > > > issue? Or only xenomai-3/kernel patches are enough?
> > >
> > > This particular issue was addressed in the Xenomai core, not the I-pipe
> > > patch.
> > >
> > > >
> > > > Actually, now I am stuck with another question.
> > > > Hope if you could help me.
> > > >
> > > > As I said, I applied xenomai-3.0.6, kernel patches (using
> > > > prepare_kernel script) to my x86_64 kernel, around 4 months back.
> > > > I am using it since then. After that I never upgraded any patches.
> > > >
> > > > Now my concern is, how do I apply/upgrade only the latest patches?
> > > > I did not remember the last commit until which I applied the patches.
> > > >
> > > > Is prepare_kernel script in intelligent enough to find the patch
> > > > difference, and apply on the latest patches ?
> > > >
> > > > Normally how you people upgrade to the latest xenomai patches.
> > > > If you have any suggestions, please guide me.
> > >
> > > Well, best practice is versioning control and build automation. You can
> > > pull the patch into your local kernel or use the i-pipe kernel git tree
> > > as feed (if you have no own patches). Then you just need
> > > prepare-kernel.sh to refresh the xenomai core.
> > >
> > > And building everything can also be automated by scripts or more
> > > advanced systems that also track the source revisions for you. Can be
> > > git, can be something like yocto, buildroot etc.
> > >
> > > Jan
> > >
> > > --
> > > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > > Corporate Competence Center Embedded Linux

