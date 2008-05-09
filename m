Message-ID: <2ff1a98a0805090235t2f3c46a2vb19a4ccc7c2157b@domain.hid>
Date: Fri, 9 May 2008 11:35:28 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4824197E.90709@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4824197E.90709@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Unfreeze timers when debugged target
	exits
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

On Fri, May 9, 2008 at 11:29 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> +       if (xnthread_test_info(thread, XNDEBUG))
> +               unlock_timers();
> +

Will this work if several threads are currently being debugged ?

-- 
 Gilles

