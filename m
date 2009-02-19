Message-ID: <499D3801.5040303@domain.hid>
Date: Thu, 19 Feb 2009 10:44:17 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <499D359C.3060805@domain.hid>
In-Reply-To: <499D359C.3060805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] XENO_OPT_SYS_STACKPOOLSZ vs. switchtest
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Gilles,
> 
> how much XENO_OPT_SYS_STACKPOOLSZ do I need to run switchtest for
> default settings? At least on x86-64, the default 32K is not enough.
> Unless we talk about GB ;), maybe it makes sense to adjust the default
> size accordingly.

It depends on the arguments you pass to switchtest.

-- 
                                                 Gilles.

