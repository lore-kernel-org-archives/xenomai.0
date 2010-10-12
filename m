Message-ID: <4CB481BC.8060105@domain.hid>
Date: Tue, 12 Oct 2010 17:41:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CB33738.206@domain.hid>	<4CB338AB.3070803@domain.hid>	<4CB339F9.5080202@domain.hid>	<4CB33F04.3000600@domain.hid>	<4CB34031.5090505@domain.hid>	<4CB3424A.5090504@domain.hid>	<4CB4299D.70600@domain.hid>
	<4CB43704.4020504@domain.hid> <4CB45B06.2070905@domain.hid>
	<4CB46855.4010401@domain.hid> <4CB473E4.8020709@domain.hid>
	<4CB4774F.2040904@domain.hid> <4CB47ECA.8060201@domain.hid>
In-Reply-To: <4CB47ECA.8060201@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and capabilities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Anders Blomdell wrote:
> OK, so short answer is you are root when you run Xenomai (or can easily become
> root)?
> 
> Fine with me, but it's always good to know.

Yes. I prefer you making this assumption than believing that the system
is mostly secure.

Now, if your concern is for teaching purposes, maybe you can put people
in a "cross-development" situation? They can not break the host machine
running the GUI and where they do the development, and they can break
the target machine at will without much consequences.

> 
> CAP_DAC_OVERRIDE still needs fixing for
> http://www.xenomai.org/index.php/Non-root_RT to work.

Ok. Thanks, will fix.


-- 
					    Gilles.

