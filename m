MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18431.26441.771360.551180@domain.hid>
Date: Fri, 11 Apr 2008 15:27:37 +0200
In-Reply-To: <47FF5EB9.9070605@domain.hid>
References: <47FF5EB9.9070605@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH] Fix tiny memory leaks around
	rt_task_self()
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
 > Nothing critical, but when using rt_task_self != NULL as a hint if the
 > caller is Xenomai-mapped or not, this stall malloc can become at least
 > unpleasant. This is also material for stable.

This looks useless: TSD cleanup routines are automatically called
upon thread termination. It is even worse: you risk a double free if you
do not re-set pthread_setspecific after having called free.

-- 


					    Gilles.

