Message-ID: <4FCE28F8.9040001@xenomai.org>
Date: Tue, 05 Jun 2012 17:42:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>	<4FCDFB35.1050705@xenomai.org>
	<CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
In-Reply-To: <CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 06/05/2012 05:34 PM, Marcin Kuśka wrote:
> Thank you for quick response.
> 
> Again I tried to compile it using buildroot but this time I used
> following commands:
> /
> /
> /# cd /home/marcin/Documents/buildroot-2012.05/output/build/linux-3.0.13
> # make ARCH=arm vexpress_defconfig // i suppose this sets kernel
> configuration only for versatile express (ommiting multiple definitions)?
> # cd ..
> # xenomai/scripts/prepare-kernel.sh --linux=linux-3.0.13
> --adeos=adeos-ipipe-3.0.13-arm-1.18-09.patch --arch=arm
> # cd /home/marcin/Documents/buildroot-2012.05
> # make all
> /

You should run make vexpress_defoncig after the prepare-kernel.sh step.

I do not think vexpress_defconfig compiles for one board only, as the
versatile board may hold several processor. Anyway, it is easy to check:
just run make menuconfig/xconfig/whateverconfigyoulike yourself, and
check what boards are enabled in the config.

-- 
					    Gilles.

