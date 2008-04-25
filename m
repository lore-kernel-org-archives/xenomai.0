Message-ID: <2ff1a98a0804250612k6ba655f5mc92cb47a12f01d@domain.hid>
Date: Fri, 25 Apr 2008 15:12:27 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4811D596.8070109@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4811D596.8070109@domain.hid>
Subject: Re: [Xenomai-core] [2.4.x PATCH] POSIX: Remove mutex/cond_init
	locking, fix NULL attribute
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

On Fri, Apr 25, 2008 at 2:59 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Hi,
>
>  trunk check-in #3369 did not just remove some "questionable critical
>  sections", it also happen to fix two ugly bugs in the POSIX skin: The
>  user was not able to pass NULL attributes down to mutex_init and
>  cond_init. Find a backport of that patch for 2.4.x attached.

I am using pthread_mutex_init and pthread_cond_init from user-space
with NULL attributes with pre 2.4 versions all the time, and never had
any problem.

-- 
 Gilles

