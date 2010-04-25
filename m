Message-ID: <4BD4926D.2080908@domain.hid>
Date: Sun, 25 Apr 2010 21:05:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BD45469.5040006@domain.hid>
In-Reply-To: <4BD45469.5040006@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

Jan Kiszka wrote:
> The following changes since commit fbc3b858ee728c1a6b03996e3285198caa7053c6:
>   Gilles Chanteperdrix (1):
>         debug: fix CONFIG_XENO_OPT_DEBUG_* issues
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/xenomai-jki.git for-upstream

Something wrong here, the logs on your branch appear as:

13ee2a1 nucleus: Fix bogus lock stealing case
d0d95bf mutex-torture: Add test for disallowed lock stealing
9ef976e RTDM: Restrict use of rtdm_rt_capable
6b75977 uitron: Fix skin debug option
bc3fefd Move schedule_delayed_work into wrapping header
41b1eca RTDM: Drop __exit from rtdm_dev_cleanup
4f3d3f2 bootstrap
78acd8c Merge commit 'jan'
700a9fd arm: add a generic-vfp architecture, which enables vfp and
compiles for armv5
8337fc5 RTDM: Use non-atomic bitops for used_fildes

Seems you forgot to rebase?

-- 
					    Gilles.

