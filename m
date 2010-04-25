From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BD45469.5040006@domain.hid>
References: <4BD45469.5040006@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 25 Apr 2010 17:04:20 +0200
Message-ID: <1272207860.28983.120.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] Fix bogus lock stealing case
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2010-04-25 at 16:40 +0200, Jan Kiszka wrote:
> The following changes since commit fbc3b858ee728c1a6b03996e3285198caa7053c6:
>   Gilles Chanteperdrix (1):
>         debug: fix CONFIG_XENO_OPT_DEBUG_* issues
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/xenomai-jki.git for-upstream
> 
> I'm starting to believe that once our customer stops reporting weird
> Xenomai behavior, we have reached the ultimate level of zero bugs. For
> now this is just another "bugs--".

Are you feeling better now?

> 
> Jan Kiszka (2):
>       mutex-torture: Add test for disallowed lock stealing
>       nucleus: Fix bogus lock stealing case
> 
>  ksrc/nucleus/synch.c               |    6 ++--
>  src/testsuite/unit/mutex-torture.c |   62 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 3 deletions(-)
> 


-- 
Philippe.



