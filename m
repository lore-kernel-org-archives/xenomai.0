Message-ID: <4B2249E3.7030705@domain.hid>
Date: Fri, 11 Dec 2009 14:32:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B223227.4020208@domain.hid>
In-Reply-To: <4B223227.4020208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [pull request] Avoid double bug reports
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> The following changes since commit 88fd7426f3565647b4f5ef93d8e612e059dae873:
>   Philippe Gerum (1):
>         Make generic atomic ops Adeos-aware
> 
> are available in the git repository at:
> 
>   git://git.kiszka.org/ipipe-2.6.git queues/2.6.31-noarch
> 
> Jan Kiszka (2):
>       noarch: Don't check for internal errors during oops
>       noarch: Set oops_in_progress on failing context check
> 
>  kernel/ipipe/core.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> -------
> 
> noarch: Don't check for internal errors during oops
> 
> We are busted already, verifying the context here only generates
> confusing output or causes even more corruptions.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

Are we sure this fixes all issues? Maybe we should wait for Josh tests
before releasing another I-pipe patch?

-- 
                                          Gilles


