From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problems compiling
	=?utf-8?q?arch/ppc/xmon/xmon=2Eo=09?=(CONFIG_XMON=y)
Date: Sat, 29 Apr 2006 19:40:52 +0200
References: <200604291850.36231.niklaus.giger@domain.hid>
	<44539DDD.9060200@domain.hid>
In-Reply-To: <44539DDD.9060200@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604291940.52764.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Am Samstag, 29. April 2006 19:09 schrieb Philippe Gerum:
> Niklaus Giger wrote:
<..>
>
> xmon looks like pretty much broken actually, and I see no issue
> regarding Xeno here. privinst.h's GSETSPR creates inlines with different
> return types than the declarations found in asm-ppc/time.h, so no wonder
> why the compiler is whining.
>
Thanks for your explanation. I have no problems, as I never used XMON.

Best regards

-- 
Niklaus Giger

