Message-ID: <4D2C49D0.3070206@domain.hid>
Date: Tue, 11 Jan 2011 13:15:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201101111223.46697.peter@domain.hid>
In-Reply-To: <201101111223.46697.peter@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Correct use of xeno_sigshadow_install()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Peter Soetens wrote:
>         struct sigaction sa;
>         sa.sa_sigaction = &rl_sigwinch_handler;
>         sa.sa_flags = SA_SIGINFO;

You probably want sa.sa_fags = SA_SIGINFO | SA_RESTART here.

And you should initialize sa.sa_mask.

-- 
					    Gilles.

