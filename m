Message-ID: <4CB85C64.9040307@domain.hid>
Date: Fri, 15 Oct 2010 15:51:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281709057.650414331@domain.hid>	<4C65583D.3030800@domain.hid>
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid>
	<1283531433.789315367@domain.hid>
	<1283590285.1709.2153.camel@domain.hid>
	<1287134519.029617765@domain.hid>
	<1287143691.028416668@domain.hid>
In-Reply-To: <1287143691.028416668@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> I am also finding that tasks are frequently hanging, causing
> ipipetraces with "INFO: task xxx:xxx blocked for more than 120
> seconds". Ihave just had this with apt-get update, and was previously
> getting itwith grub-install. Could this be related?

Yes. There is obviously an issue in your patched kernel, we need to find
this first before we draw any conclusion from any other behaviour.

>From the trace you sent, it looks like it happens in the MTRR code, but
it could also be an SMI, or some other bug. For debugging purposes,
could you try disabling MTRRs in the kernel configuration?

-- 
					    Gilles.

