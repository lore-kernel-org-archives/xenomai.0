MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17241.55931.410285.92967@domain.hid>
Date: Sat, 22 Oct 2005 08:21:47 +0200
Subject: Re: [Xenomai-help] latency_rt: disagrees about version of symbol
	rt_task_wait_period
In-Reply-To: <4355626D.6070907@domain.hid>
References: <435543AD.4010807@domain.hid>
	<17237.22199.793983.902217@domain.hid>
	<4355626D.6070907@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
 > so I disabled modversion, recompiled kernel, recompiled xenomai.
 > Problem Gone.  Heisenbugs :-/ ?

Fully reproducible here when CONFIG_MODVERSIONS is enabled. So, this is
a bug in the interaction with Kbuild.

-- 


					    Gilles Chanteperdrix.

