From: Shabaz Yousaf <shabaz_yousaf@hotmail.com>
Subject: Re: Xenomai install question (get error running test apps)
Date: Mon, 12 Aug 2019 20:22:44 +0000
Message-ID: <DB6P18901MB02143E547F1E93E87015F2CF84D30@DB6P18901MB0214.EURP189.PROD.OUTLOOK.COM>
References: <DB6P18901MB021417660CD32E74B1F2201184D30@DB6P18901MB0214.EURP189.PROD.OUTLOOK.COM>,
 <CAArsGaaF-oZOnCi01=Gmjv3upgES8dOQAd3vmJNuaHrFP8+HQg@mail.gmail.com>
In-Reply-To: <CAArsGaaF-oZOnCi01=Gmjv3upgES8dOQAd3vmJNuaHrFP8+HQg@mail.gmail.com>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Tormod,

Thanks! I'll try that now and report back.
It did look suspicious to me too, but two BeagleBone websites had the ./con=
figure flags set the way I tried, but I believe it's very likely the websit=
es are outdated
(this is a common problem with BeagleBone Black info, there is a lot of out=
dated or incorrect information on websites : (
I'll write it up once I get it running.

Thanks again for your help.

Shabaz.

________________________________
From: Tormod Volden <lists.tormod@gmail.com>
Sent: 12 August 2019 08:52
To: xenomai@xenomai.org <xenomai@xenomai.org>
Cc: Shabaz Yousaf <shabaz_yousaf@hotmail.com>
Subject: Re: Xenomai install question (get error running test apps)

On Mon, Aug 12, 2019 at 3:40 AM Shabaz Yousaf wrote:

> In a nutshell, I installed a pre-built Xenomai kernel, and then tried to =
install the remainder of it and run a sample app, but I get an error:
> BUG in __xenomai_init(): [main] running non-SMP libraries on SMP kernel?

I believe you'll need to configure your xenomai libraries for SMP. It
defaults to --enable-smp=3Dyes only on x86/cobalt, otherwise to
--enable-smp=3Dno

> I've installed the pre-built Xenomi kernel on a BeagleBone Black using so=
me script it already has, and uname -a looks good:
> Linux beaglebone 4.14.108-ti-xenomai-r114 #1 SMP PREEMPT Sun Aug 4 08:52:=
45 UTC 2019 armv7l GNU/Linux

Note the "SMP" in the kernel signature above.

> cd xenomai-3.0.9
>
> ./configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" LDFLAGS=3D"-march=3D=
armv7-a -mfpu=3Dvfp3"
>

https://gitlab.denx.de/Xenomai/xenomai/wikis/Troubleshooting#user-content-f=
eature-mismatch-missingsmpnosmp

Regards,
Tormod
