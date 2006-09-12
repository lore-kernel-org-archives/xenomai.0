MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17670.39477.918020.470948@domain.hid>
Date: Tue, 12 Sep 2006 13:29:57 +0200
Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
In-Reply-To: <4505E336.2060201@domain.hid>
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>
	<4500789C.9070804@domain.hid> <450113E7.6000907@domain.hid>
	<4505C0F7.5060404@domain.hid>
	<17669.52163.920452.626173@domain.hid>
	<4505E336.2060201@domain.hid>
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
To: xenomai@xenomai.org

Jan Kiszka wrote:
 > > Calling pthread_cancel then pthread_join from a module cleanup routine
 > > should work. Because the cancelled thread preempts immediately the
 > > module cleanup routine, so when pthread_join is called, the thread no
 > > longer exists and there is no need to suspend the calling thread.
 > > 
 > 
 > Yes, but only on UP. What about including a simple polling loop into
 > kernel-space pthread_join, something like rtdm_task_join_nrt?

Yes, I will include this polling loop.

-- 


					    Gilles Chanteperdrix.

