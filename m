Message-ID: <4C73B776.4050607@domain.hid>
Date: Tue, 24 Aug 2010 14:13:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik6qbZkrFyWYC4HQten+EcfHLboiSN2eRtTTqnQ@mail.gmail.com>	<4C72D8C7.6000303@domain.hid>
	<AANLkTinZWo-U-mFzhKq3MjsTs6dr7zh49xZzWZVXe9wu@domain.hid>
In-Reply-To: <AANLkTinZWo-U-mFzhKq3MjsTs6dr7zh49xZzWZVXe9wu@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] periodical task in posix skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

ramon costa wrote:
> Any suggestion to substitute pthread_make_periodic_np and  pthread_wait_np
> in a POSIX skin ?

clock_nanosleep with TIMER_ABSTIME.


-- 
					    Gilles.

