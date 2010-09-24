From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Fri, 24 Sep 2010 23:21:42 +0200
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
In-Reply-To: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201009242321.42954.kisda@domain.hid>
Subject: Re: [Xenomai-help] switchtest/xeon-test fails: Help needed
	(Ubuntu/Core i7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Freitag 24 September 2010, 22:05:37 schrieb Gajamohan Mohanarajah:
> Hi,

> 3. I am compiling the kernel using [fakeroot make-kpkg --initrd
> --append-to-version=-xenomaiflv kernel-image kernel-headers
> --overlay-dir=$HOME/kernel-package]. After changing just the
> CONFIG_XENO_OPT_SYS_HEAPSZ via [make menuconfig], when I issue the the
> above command, the kernel goes on to a full recompile which  takes 2
> hours :(.

Have you set CONCURRENCY_LEVEL to the numer of cores ?
  [CONCURRENCY_LEVEL=8 fakeroot make-kpkg --initrd ... ... ... ]

Never tried, but "-j x" should work too today:
  [fakeroot make-kpkg -j 8 ... ... ...]

Regards Stefan

