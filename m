Message-ID: <48AFE9E9.3050509@domain.hid>
Date: Sat, 23 Aug 2008 12:43:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AFCB3F.6070902@domain.hid>
In-Reply-To: <48AFCB3F.6070902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Racy pse51_mutex_check_init?
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
> Hi Gilles,
> 
> trying to understand the cb_read/write lock usage, some question came up
> here: What prevents that the mutexq iteration in pse51_mutex_check_init
> races against pse51_mutex_destroy_internal?
> 
> If nothing, then I wonder if we actually have to iterate over the whole
> queue to find out whether a given object has been initialized and
> registered already or not. Can't this be encoded differently?

We actually iterate over the queue only if the magic happens to be
correct, which is not the common case.

-- 
					    Gilles.

