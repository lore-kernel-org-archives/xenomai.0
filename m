MIME-Version: 1.0
References: <DB6P18901MB021417660CD32E74B1F2201184D30@DB6P18901MB0214.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DB6P18901MB021417660CD32E74B1F2201184D30@DB6P18901MB0214.EURP189.PROD.OUTLOOK.COM>
From: Tormod Volden <lists.tormod@gmail.com>
Date: Mon, 12 Aug 2019 09:52:57 +0200
Message-ID: <CAArsGaaF-oZOnCi01=Gmjv3upgES8dOQAd3vmJNuaHrFP8+HQg@mail.gmail.com>
Subject: Re: Xenomai install question (get error running test apps)
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Aug 12, 2019 at 3:40 AM Shabaz Yousaf wrote:

> In a nutshell, I installed a pre-built Xenomai kernel, and then tried to install the remainder of it and run a sample app, but I get an error:
> BUG in __xenomai_init(): [main] running non-SMP libraries on SMP kernel?

I believe you'll need to configure your xenomai libraries for SMP. It
defaults to --enable-smp=yes only on x86/cobalt, otherwise to
--enable-smp=no

> I've installed the pre-built Xenomi kernel on a BeagleBone Black using some script it already has, and uname -a looks good:
> Linux beaglebone 4.14.108-ti-xenomai-r114 #1 SMP PREEMPT Sun Aug 4 08:52:45 UTC 2019 armv7l GNU/Linux

Note the "SMP" in the kernel signature above.

> cd xenomai-3.0.9
>
> ./configure CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a -mfpu=vfp3"
>

https://gitlab.denx.de/Xenomai/xenomai/wikis/Troubleshooting#user-content-feature-mismatch-missingsmpnosmp

Regards,
Tormod

