Message-ID: <4BA4C5EF.6020003@domain.hid>
Date: Sat, 20 Mar 2010 13:56:15 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4BA416AA.6050603@domain.hid>
In-Reply-To: <4BA416AA.6050603@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] analogy: bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Alexis Berlemont wrote:
> The following changes since commit 8cfc1103fe1cf9e700698e8230baf562ffb5cf06:
>    Gilles Chanteperdrix (1):
>          x86 syscalls: make __xn_get_eip a macro
> 
> are available in the git repository at:
> 
>    git://git.xenomai.org/xenomai-abe.git analogy

Hello. Looking at your pull request, I see that my patch for correct
buffer handling when using .stop_src  = TRIG_NONE is not included. Does
the patch need some more work? Or it simply get lost on the way?

Thanks. Cheers,
-- 
Daniele

