MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.20014.842135.310718@domain.hid>
Date: Tue, 18 Oct 2005 21:34:06 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <43554BD2.1050305@domain.hid>
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
 > They are for both. You can compile some helloworld64 by calling gcc
 > without arguments or as easily a helloworld32 by running "gcc -m32" -
 > all on the same box withouth additional cross-tool stuff.

Ok, the -m32 fix to configure.in is what I can do for now, it is in the
repository. Could you try it ?

-- 


					    Gilles Chanteperdrix.

