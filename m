Message-ID: <48F344A7.4060003@domain.hid>
Date: Mon, 13 Oct 2008 14:52:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F344D0.7080805@domain.hid>
In-Reply-To: <48F344D0.7080805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_[set|get]specific()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> can pthread_[set|get]specifi()c be used safely in user space real-time
> tasks. Or does it result in a switch to secondary mode?

I would expect pthread_getspecific to be safe on all platforms though
(and actually, I think the fast mutexes implementation relies on that).

I would say it should be always safe or always non-safe. So, you may run
a test with T_WARNSW (or XNTRAPSW) and you will know whether the
implementation on your platform is safe.

pthread_setspecific is another story, maybe it can trigger a re-allocation?

-- 
                                                 Gilles.

