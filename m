Message-ID: <4EFAE1BF.4090203@domain.hid>
Date: Wed, 28 Dec 2011 10:30:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
In-Reply-To: <000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gregory Gosse <gregory.gosse@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 12/28/2011 10:17 AM, Gregory Gosse wrote:
> Now i use more recent xenomai and kernel versions :
>
> - xenomai 2.6.0   2011-11-05 ( latest )
>
> - kernel 2.6.39 ( latest in 2.6 serie )
>
> With the same patch :
>
> - adeos-ipipe-2.6.23-x86_64-1.4-03.patch
>
> I launch the command
>
> scripts/prepare-kernel.sh --linux=/usr/src/linux-2.6.39
> --adeos=/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.23-x86_64-1.4-03.patch
> --arch=x86_64

- there is no support for 2.6.39/x86. Looking at ksrc/arch/x86/patches 
tells you so. Latest kernel release currently supported on this arch is 
2.6.38.8.

--arch=x86, not x86_64 which is for legacy patches when 32 and 64bit 
linux trees were not merged yet.

You need to unpack a vanilla linux 2.6.38.8 kernel tree, then

$ cd <linux-tree>
$ <xenomai-2.6.0>/scripts/prepare-kernel.sh --arch=x86

Nothing more.

>
> And get
>
> Unable to patch kernel 2.6.39 with adeos-ipipe-2.6.23-x86_64-1.4-03.patch
>
> with many Hunk #xx FAILED at xx
>
> Gregory
>
> -----Message d'origine-----
> De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Envoyé : mardi 27 décembre 2011 17:59
> À : Gregory Gosse
> Cc : xenomai@xenomai.org
> Objet : Re: [Xenomai-help] problem following 'xenomai quick build guide'
>
> On 12/27/2011 05:56 PM, Gregory Gosse wrote:
>
>  > What can I do to go further ?
>
> There is no point in starting with such outdated versions. Please
> download the latest stable release of Xenomai (xenomai 2.6.0), and if
> the quick build guide does not work, follow the not quick build guide
> called "README.INSTALL" which ships with the sources.
>
> --
>
>                                                                  Gilles.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

