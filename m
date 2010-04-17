Message-ID: <4BC9F9DA.5000508@domain.hid>
Date: Sat, 17 Apr 2010 20:11:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BC9F841.20009@domain.hid>
In-Reply-To: <4BC9F841.20009@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull v2] RTDM fixes and reworks
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a5987d:
>   Gilles Chanteperdrix (1):
>         switchtest: increase stack sizes
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/xenomai-jki.git for-upstream
> 
> 
> Changes in v2:
>  - compat support for rttest device names
>  - documented RTDM close procedure
>  - internal rework of the close procedure
>  - basic RTDM unit test, so far targeting at the close rework
>  - some additional small cleanup patches
> 
> Beyond that series, there is now also our full /proc rework updated in
> git, see
> 
>   git://git.xenomai.org/xenomai-jki.git queues/proc
> 
> I will send a separate pull request for that one later, either on top of
> this (if there are no further concerns) or against master (it should
> be orthogonal).

Ok, could you git-send-mail the patches to the list? Reviewing them in
the xenomai-git mailing list is not that convenient, I am afraid to miss
some of them.

One thing I did not see in your close test (but may have missed it, I
just can not find back the specific mail containing it), you should
check that, if a driver returns -EAGAIN, and open is called right after
close, the caller gets the same file descriptor.

-- 
					    Gilles.

