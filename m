Message-ID: <48BE4846.1050307@domain.hid>
Date: Wed, 03 Sep 2008 10:18:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C4E37C03.874%samf48@domain.hid>
In-Reply-To: <C4E37C03.874%samf48@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai kernel compile issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Sam Ferguson wrote:
> Ok it must be a kernel patch issue.  When I patched it initially it seemed
> to go through, it returned me to the terminal with no errors.  So I tried to
> patch the kernel doing by running the script from xenomai.  Here is what
> happens:
> 
> igvc@domain.hid$ scripts/prepare-kernel.sh

Please use the latest release of xenomai.

> Linux tree [default /lib/modules/2.6.24-19-generic/source]:
> /lib/modules/2.6.24-19-generic/build
> Target architecture [default i686]:
> Adeos patch [default /dev/null]:
> /usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/adeos-ipipe-2.6.26-x86-2.0-09.p
> atch

If you are trying to patch a 2.6.24 kernel with the Adeos patch for
2.6.26, it will not work.

Please do not forget to CC the list.

-- 
					    Gilles.


