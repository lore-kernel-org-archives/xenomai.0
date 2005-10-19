MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17238.36436.576084.355073@domain.hid>
Date: Wed, 19 Oct 2005 20:20:04 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <435605E7.90201@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
	<4354AD5A.7010305@domain.hid>
	<17237.13723.766826.515585@domain.hid>
	<43553F22.80805@domain.hid>
	<17237.19216.373031.430361@domain.hid>
	<43554BD2.1050305@domain.hid>
	<17237.20014.842135.310718@domain.hid>
	<43555065.40704@domain.hid>
	<435605E7.90201@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > I know now what makes the difference: setting CC=\"$CC\" in
 > XENO_KBUILD_CMD. Xenomai does this and seems to override the "-m32"
 > extension of the kernel build system, RTnet does not.

Of course ! stupid me. In makefiles, the variables assignment passed on
command line take precedence over the one made in the makefiles
themselves. And the environment variable have the least precedence, so I
guess passing CC in Kbuild environment instead of on command line should
do the trick.


-- 


					    Gilles Chanteperdrix.

