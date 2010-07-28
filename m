Message-ID: <4C4FDFD2.4010405@domain.hid>
Date: Wed, 28 Jul 2010 09:44:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C4F7930.90408@domain.hid> <4C4F7AF8.8090500@domain.hid>
	<4C4F949F.9090200@domain.hid>
In-Reply-To: <4C4F949F.9090200@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai xeno-test hangs on 2.6.31 on BeagleBoard,
 same works on 2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   On 2.6.33.......... (2.6.31 gives the same result)
> root@domain.hid:~# /usr/xenomai/bin/latency
> Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_nucleus?)
> 
> BUT, neither are disabled... And, xeno_nucleus is built-in to the kernel.

Ok. If you are using an EABI toolchain, did you pass --enable-arm-eabi
to the configure script?


-- 
					    Gilles.

