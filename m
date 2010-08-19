Message-ID: <4C6D4BDE.1050605@domain.hid>
Date: Thu, 19 Aug 2010 17:21:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>	<4C6BD747.1090304@domain.hid>	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>
	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>
In-Reply-To: <AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel compilation problem with a Cortex A8,
 AM3517 EVM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marc doz <doz.marc@domain.hid>
Cc: xenomai@xenomai.org

marc doz wrote:
> The compilation is a sucess without the line 172 and 193. It seem that
> spin lock management is different between kernel 2.6.32 ans 2.6.33.
> 
> So I think that my realy problem is that is need a adeos patch  for
> kernel 2.6.32 adeos-ipipe-2.6.32-arm* . I have 298 patchs of Texas
> Instrument for the kernel 2.6.32 and my board. So I can't upgrade to
> 2.6.33 or downgrade to 2.6.31.
> 
> The 2.6.32 adeos-ipipe-2.6.32-arm* patch is not present in the
> downloading section of the adeos website

Yes, I did not produce this patch. If you want to do it, you should use
the I-pipe git: git://git.denx.de/ipipe-2.6.git, then merge the
ipipe-2.6.32-noarch branch with your vendor branch, then try and apply
the diff between ipipe-2.6.31-noarch and ipipe-2.6.31-arm or
ipipe-2.6.33-noarch and ipipe-2.6.33-arm.

-- 
					    Gilles.

