Message-ID: <48BCE69F.2080307@domain.hid>
Date: Tue, 02 Sep 2008 09:09:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <971398.39540.qm@domain.hid>
In-Reply-To: <971398.39540.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RT_HEAP Problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid
Cc: xenomai@xenomai.org

Yasser Kashfi wrote:
> this program previously worked on another PC. but now when I execute
> it on the new PC, It cause the kernel panic ( Unable to handle null
> pointer reference ...). same kernel is run on two PC, and not seems
> any difference.  but now I print memory status (/proc/meminfo). a
> huge difference is found! in first pc ( that program worked ) total
> vmalloc = totol memory = 510 M and highmem = 0, but on second pc (
> that kernel panic ) total vmalloc = 119M but total memory = 1 G and
> highmem = 122. have everyone any idea?

It seems that highmem could be the problem right ? To confirm that this
is the issue, could you recompile your kernel with CONFIG_VMSPLIT_3G_OPT ?

-- 
					    Gilles.

