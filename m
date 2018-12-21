MIME-Version: 1.0
References: <9f8fd2ac-368b-8ce9-4982-108e923fad23@siemens.com>
In-Reply-To: <9f8fd2ac-368b-8ce9-4982-108e923fad23@siemens.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 21 Dec 2018 16:15:08 +0530
Message-ID: <CAOuPNLiOd+U0V29Wx8ay3u4x7GZL9PE09Y9F-xhvSi4_rHsKpA@mail.gmail.com>
Subject: Re: RTnet tests in smokey
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, Sebastian.Smolorz@gmx.de

On Fri, Dec 14, 2018 at 5:54 PM Jan Kiszka via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi all,
>
> while debugging that list corruption in Rtnet I noticed that the related
> smokey tests are in a rather improvable state. First of all, they are
> never working automatically unless the rtnet core is built into the
> kernel. When it is just a model, the corectl check will always fail
> because the core feature is not present. That can be fixed like this:
>
> diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
> index ea3daceca5..86ebf988ff 100644
> --- a/testsuite/smokey/net_common/setup.c
> +++ b/testsuite/smokey/net_common/setup.c
> @@ -352,6 +352,10 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
>         struct sockaddr_in *in_peer = vpeer;
>         struct sockaddr *peer = vpeer;
>
> +       err = smokey_net_modprobe("rtnet");
> +       if (err < 0)
> +               return err;
> +
>         err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
>                         &net_config, sizeof(net_config));
>         if (err == -EINVAL)
>
> But when you built more of the core into the kernel, the cleanup of the tests will start to fail.
>
> I was considering to add the above change as patch, but then we will always fail on net_udp test unless the user also had some physical link set up. That is at least my impression because the test reports
>
> > RTnet UDP test failed, all packets lost (is smokey_net_server running ?)
>
> while even running "smokey_net_server rtlo" does not work:
>
> > smokey_net_server options [ <interface> ]:
> >
> > Runs server for smokey network tests, on interface named <interface>
> > (rtlo if unspecified)
>    ^^^^^^^^^^^^^^^^^^^
>
> >
> > Available options:
> > -f | --file <file>              Answers clients from file named <file>
> >         (uses standard input if unspecified)
> >         Where every line contains a mac address and an IP address
> >    0"000.007| WARNING: [main] Xenomai compiled with partial debug enabled,
> >                               high latencies expected [--enable-debug=partial]
> >
> > Running smokey_net_server on rtlo makes no sense
>                                ^^^^^^^^^^^^^^^^^^^
>
> As we now have a fix for the bug this test revealed but digging deeper
> into it and making it a working default test is likely much more effort,
> I'm going to tag v3.0.8 after this fix settled and is merged over. But
> the above should be addressed eventually.
>

I have already reported this issue long back where I see the crash in
net_udp using my sample udp_server/client program (even with rtlo),
with xenomai-3.0.6 on all x86/arm/arm64 for kernel version 4.9.xx
But I observed that the problem does not occur on a virtual box environment.

This was the back trace at that time:

# dmesg
[612871.612307]
                *** RTnet for Xenomai v3.1-devel ***

[612871.612310] RTnet: initialising real-time networking
[612906.855980] initializing loopback...
[612906.855998] RTnet: registered rtlo
[613075.162006] BUG: unable to handle kernel paging request at 00007ffc7893b148
[613075.162009] IP: [<ffffffffc0a0503e>] rt_udp_getfrag+0x3e/0x110 [rtudp]
[613075.162013] PGD 744f76067
[613075.162014] PUD 80e1ae067
[613075.162015] PMD 6893dd067
[613075.162015] PTE 8000000581853867

[613075.162018] Oops: 0001 [#1] SMP
[613075.162019] Modules linked in: rt_loopback rtpacket rtudp rtipv4 rtnet
[613075.162049]  pinctrl_intel fjes
[613075.162052] CPU: 0 PID: 12658 Comm: rtnet-client Not tainted
4.9.51-scel-amd-x86-64 #4
[613075.162054] I-pipe domain: Linux

[613075.162076] Call Trace:
[613075.162091]  [<ffffffffc0a0f204>] rt_ip_build_xmit+0x1c4/0x2a0 [rtipv4]
[613075.162093]  [<ffffffffc0a05000>] ? 0xffffffffc0a05000
[613075.162094]  [<ffffffffc0a060db>] rt_udp_sendmsg+0x37b/0x3d0 [rtudp]
[613075.162097]  [<ffffffffa70a4676>] ? update_curr+0x66/0x180
[613075.162098]  [<ffffffffa70a67b8>] ? dequeue_entity+0x268/0xc00
[613075.162100]  [<ffffffffa718a117>] ? ___xnsched_run.part.73+0x3d7/0x400
[613075.162102]  [<ffffffffa70a4035>] ? hrtick_update+0x5/0x70
[613075.162103]  [<ffffffffa70a76d7>] ? dequeue_task_fair+0x587/0x900
[613075.162105]  [<ffffffffa71a0390>] ? CoBaLt_recvmmsg+0x30/0x30
[613075.162106]  [<ffffffffa71a0390>] ? CoBaLt_recvmmsg+0x30/0x30
[613075.162108]  [<ffffffffa719ad7b>] rtdm_fd_sendmsg+0xcb/0x240
[613075.162109]  [<ffffffffa71a0390>] ? CoBaLt_recvmmsg+0x30/0x30
[613075.162111]  [<ffffffffa71a03de>] CoBaLt_sendmsg+0x4e/0x70
[613075.162113]  [<ffffffffa71ad017>] ipipe_syscall_hook+0x117/0x340
[613075.162114]  [<ffffffffa712f9ff>] __ipipe_notify_syscall+0xbf/0x170
[613075.162116]  [<ffffffffa79007b7>] pipeline_syscall+0x8/0x1b
[613075.162118] Code: 54 49 89 f4 53 89 cb 8b 57 20 0f 85 c3 00 00 00
85 d2 7e 2f 8b 47 24 45 31 ed 49 63 cd 89 c2 41 83 c5 01 48 c1 e1 04
49 03 4e 18 <8b> 71 08 48 8b 39 e8 e7 f4 a0 e6 41 8b 56 20 41 89 46 24
44 39
[613075.162141] RIP  [<ffffffffc0a0503e>] rt_udp_getfrag+0x3e/0x110 [rtudp]
[613075.162143]  RSP <ffff9e2f0334bb70>
[613075.162144] CR2: 00007ffc7893b148
[613075.162145] ---[ end trace 90458bf1f92e3557 ]---


I hope this problem is fixed now in latest xenomai master branch.

