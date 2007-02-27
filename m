MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17892.41807.168752.212360@domain.hid>
Date: Tue, 27 Feb 2007 22:31:59 +0100
Subject: Re: [Xenomai-help] task not being scheduled
In-Reply-To: <200702271509.33805.jweber@domain.hid>
References: <45E494AC.5050603@domain.hid> <200702271509.33805.jweber@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Jeff Weber wrote:
 > I will try the CONFIG_XENO_OPT_TIMER_LIST.  I have about 18 RT tasks,
 > of which only a few are ever runnable at the same time.

The thing that matters for selecting the timer list data structure is
the number of pending timers.

-- 


					    Gilles Chanteperdrix.

