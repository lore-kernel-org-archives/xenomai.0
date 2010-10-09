Message-ID: <4CB04ACE.6050408@domain.hid>
Date: Sat, 09 Oct 2010 12:58:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CB04954.7010109@domain.hid>
In-Reply-To: <4CB04954.7010109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] cleanups and LTTng fix for head
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

Jan Kiszka wrote:
> The following changes since commit 36a0e05a86d0cd19311cd33ae9da8618cc4d0c55:
> 
>   posix: fix regression in clock_gettime (HOST_RT introduction) (2010-10-08 17:41:03 +0200)
> 
> are available in the git repository at:
>   git://git.xenomai.org/xenomai-jki.git for-upstream
> 
> Jan Kiszka (3):
>       Re-enable marker support for latest LTTng
>       posix: Cleanup CLOCK_HOST_REALTIME

Well, why not having CLOCK_HOST_REALTIME for machines without a tsc
accessible in user-space ?!

-- 
                                                                Gilles.

