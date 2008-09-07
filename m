Message-ID: <48C3F4F2.5030208@domain.hid>
Date: Sun, 07 Sep 2008 17:36:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <420196.99125.qm@domain.hid>
In-Reply-To: <420196.99125.qm@domain.hid>
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
> Hi
> Thanks Gilles for your notes. The problem is solved.

Well... not exactly, it shows that the problem is using highmem, but we
should now modify xenomai so that it supports using highmem.

-- 
					    Gilles.

