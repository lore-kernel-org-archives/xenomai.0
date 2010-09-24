From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Sat, 25 Sep 2010 00:08:04 +0200
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
	<201009242321.42954.kisda@domain.hid>
	<4C9D1713.8040608@domain.hid>
In-Reply-To: <4C9D1713.8040608@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201009250008.04443.kisda@domain.hid>
Subject: Re: [Xenomai-help]
 =?utf-8?q?switchtest/xeon-test_fails=3A_Help_neede?=
 =?utf-8?q?d_=28Ubuntu/Core_i7=29?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Freitag 24 September 2010, 23:24:35 schrieben Sie:
> Stefan Kisdaroczi wrote:
> > Am Freitag 24 September 2010, 22:05:37 schrieb Gajamohan Mohanarajah:
> >> Hi,
> >> 
> >> 3. I am compiling the kernel using [fakeroot make-kpkg --initrd
> >> --append-to-version=-xenomaiflv kernel-image kernel-headers
> >> --overlay-dir=$HOME/kernel-package]. After changing just the
> >> CONFIG_XENO_OPT_SYS_HEAPSZ via [make menuconfig], when I issue the the
> >> above command, the kernel goes on to a full recompile which  takes 2
> >> hours :(.
> > 
> > Have you set CONCURRENCY_LEVEL to the numer of cores ?
> > 
> >   [CONCURRENCY_LEVEL=8 fakeroot make-kpkg --initrd ... ... ... ]
> > 
> > Never tried, but "-j x" should work too today:
> >   [fakeroot make-kpkg -j 8 ... ... ...]
> 
> Are you sure make-kpkg does not issue a "make clean" before compiling.

It will do a "make clean" and I have no idea how to disable that. As he wrote 
the full commandline and nothing about concurrency I just wanted to make sure 
he knows about this option.

