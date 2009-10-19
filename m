Message-ID: <4ADC610C.6070106@domain.hid>
Date: Mon, 19 Oct 2009 14:52:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <72795ccb0910190545x69b3cef4k6cf9786cbc58fe8c@domain.hid>
In-Reply-To: <72795ccb0910190545x69b3cef4k6cf9786cbc58fe8c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos and Linux 2.6.18
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: simon polette <spolette@domain.hid>
Cc: xenomai@xenomai.org

simon polette wrote:
> Hi,
> 
> I'm trying to install xenomai on a Linux debian 2.6.18 kernel, but
> there is no adeos patch available for this kernel version. Why? Can I
> use the 2.6.19 patch and adapt it for my kernel?

You could, but you will hit known bugs with such an old version. I mean
linux 2.6.18 was released on september 2006, more than 3 years ago.

I am running the latest stable debian release, and the kernel is a
2.6.26, which should be more reasonable.

But in fact, since you need to patch the kernel and can no longer run
the distribution kernel, there is no reason not to use the latest stable
kernel.

-- 
                                          Gilles


