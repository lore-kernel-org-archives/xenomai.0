Message-ID: <4B72A7E2.5020001@domain.hid>
Date: Wed, 10 Feb 2010 13:34:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
In-Reply-To: <E1NfBdX-0001ga-4b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Make
 xnarch_init_timeconv an uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: 6b40653e9c3c4a2433bb4e91344fc378eb860f75
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=6b40653e9c3c4a2433bb4e91344fc378eb860f75
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Wed Feb 10 13:24:29 2010 +0100
> 
> Make xnarch_init_timeconv an uninlined weak function
> 
> Otherwise the wrong set of time conversion variables might get
> initialized when using > 1 skin libraries.

If that would be possible, then it is the conversion variables which
should made be weak, not the function.

The way I see it, the posix and native skins currently get a different
set of variables and functions, which works, but with your change, since
there is only one function, only one set of variable gets initialized by
the two function calls. And one skin just broke.

Or am I missing something? Does the patch fix a problem you really had?

-- 
					    Gilles.

