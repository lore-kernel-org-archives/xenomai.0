MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18414.41945.980220.264760@domain.hid>
Date: Sat, 29 Mar 2008 21:17:29 +0100
In-Reply-To: <47ED9D05.7060707@domain.hid>
References: <47ED5DE3.60202@domain.hid>
	<18413.32341.751841.753799@domain.hid>
	<18413.34914.638951.575098@domain.hid>
	<47ED9D05.7060707@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Tomas Kalibera wrote:
 > Hi Gilles,
 > 
 > thanks for looking at it. Your analysis is correct, I don't indeed have 
 > CONFIG_PREEMPT_RT kernel, but only CONFIG_PREEMPT, sorry for the confusion.
 > 
 > I've put the kernel config, sources, and binary on the web, so that you 
 > can be sure you're really looking on the kernel that is crashing, 
 > http://www.cs.purdue.edu/homes/tkaliber/crash

It looks like do_wp_page, the caller of cow_user_page calls it with
spinlock unlocked. So nothing prevents a rescheduling to happen and
reschedule a real-time process, which can call fork. Now, I wonder what
prevents do_wp_page to be called in the same conditions...

-- 


					    Gilles.

