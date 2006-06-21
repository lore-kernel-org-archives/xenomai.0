Subject: Re: [Xenomai-core] [PATCH] optimise rthal_timer locking
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4499B97A.5040800@domain.hid>
References: <4499B97A.5040800@domain.hid>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 23:37:56 +0200
Message-Id: <1150925877.25370.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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

On Wed, 2006-06-21 at 23:26 +0200, Jan Kiszka wrote:
> Hi,
> 
> long pending in my tree, I finally decided to role this one out as it is
> quite lone-standing:
> 
> This patch avoids to additionally switch off the local IRQs in
> rthal_timer_program_shot for the PIPELINE_HEAD case - the caller is
> expected to hold the nucleus lock with IRQs off anyway. Applies to i386
> and ia64.

Applied, thanks.

> 
> Jan
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



