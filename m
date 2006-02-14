From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17394.816.773987.647984@domain.hid>
Date: Tue, 14 Feb 2006 17:20:00 +0100
Subject: Re: [Xenomai-core] [PATCH] separate queue debugging switch
In-Reply-To: <43F1CF9F.6020608@domain.hid>
References: <43F1C095.8030805@domain.hid>
	<43F1CF9F.6020608@domain.hid>
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
 > Jan Kiszka wrote:
 > > Hi,
 > > 
 > > while XENO_OPT_DEBUG is generally a useful switch for tracing potential
 > > issues in the core and the skins, it also introduces high latencies via
 > > the queue debugging feature (due to checks iterating over whole queues).
 > > 
 > > This patch introduces separate control over queue debugging so that you
 > > can have debug checks without too dramatic slowdowns.
 > > 
 > 
 > And this revision also takes care of 2.4.

Applied, thanks.

-- 


					    Gilles Chanteperdrix.

