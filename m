Message-ID: <4BD6FCA0.9080906@domain.hid>
Date: Tue, 27 Apr 2010 17:02:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1272375452-7626-1-git-send-email-fg@domain.hid>
In-Reply-To: <1272375452-7626-1-git-send-email-fg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] adeos-ipipe-2.6.30-arm-1.15-01.patch:
 Fix	hang on 'Calibrating delay loop...' on S3C24xx
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fabian Godehardt <fg@domain.hid>
Cc: xenomai@xenomai.org

Fabian Godehardt wrote:
> This patch should fix the hang during 'Calibrating delay loop...' on S3C24xx
> based kernels. Problem is that some machines do not have an externel TCLK
> signal so the timer doesn't start running.
> 
> This patch may also be of interest for the 2.6.28 and 2.6.29 patches.
> 
> Tested with a S3C2440 cpu.

Thanks a lot. Patches for 2.6.31 and 2.6.33 should be out soon, and they
will include that patch too.

-- 
					    Gilles.

