Message-ID: <4C74E598.4070701@domain.hid>
Date: Wed, 25 Aug 2010 11:42:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikXsjX5oRTUYR3Tg_ew9-VEFVMiyTnFUGWRq9Sm@domain.hid>
In-Reply-To: <AANLkTikXsjX5oRTUYR3Tg_ew9-VEFVMiyTnFUGWRq9Sm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Page-fault, switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bharath Achuta Bhat <baambekar@domain.hid>
Cc: xenomai@xenomai.org

Bharath Achuta Bhat wrote:
> Hello Xenomai experts,
> 
> I am running a xenomai-2.5.1 patched kernel (v 2.6.30.3) with ipipe
> version 2.7-06.
> The target is powerpc (MPC8533E).
> My application is switching to the secondary mode (I guess because of a
> page-fault) when ntohl() is called.
> This is a libc function and I am wondering why only this function (ntohl())
> is causing a page-fault.

Before anything, could you try xenomai 2.5.3 ?

-- 
					    Gilles.

