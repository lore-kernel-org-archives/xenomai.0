Message-ID: <48BBBCDC.8050306@domain.hid>
Date: Mon, 01 Sep 2008 11:58:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBADB0.5020508@domain.hid>
In-Reply-To: <48BBADB0.5020508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 5/9] Allow lock stealing
	via	pthread_mutex_trylock
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
> By calling into the kernel in the contended case and exploiting
> XN_NONBLOCK for xnsynch_sleep_on, this patch adds lock stealing support
> to pthread_mutex_trylock.
> 
> The latter part may change if we decide to go for a dedicates xnsynch
> trylock service. Maybe we are even lucky and able to implement lock
> stealing purely with the help of the fast lock algorithm. But we first
> have to merge fast locks into xnsynch to see clearer.

Nak. I can live without stealing for trylock in the mean time.

-- 
                                                 Gilles.

