Message-ID: <4C077391.8000006@domain.hid>
Date: Thu, 03 Jun 2010 11:19:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6D556AFBBAD7426CBD7EDECBA8A2A361@domain.hid>
In-Reply-To: <6D556AFBBAD7426CBD7EDECBA8A2A361@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] "arm: fix mm switching" patch effective also for
 2.4.10 ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: k-isono@domain.hid
Cc: xenomai@xenomai.org

Katsuhiko Isono wrote:
> I use linux-2.6.26 + xenomai-2.4.10 with custom arm(i.mx31) board.
> 
> When realtime application was executed on my environment,
> application caused the SIGSEGV fault about once every several hours.
> 
> However, when I applied "arm: fix mm switching" patch of xenomai-2.5 to 
> my environment, SIGSEGV fault did not happen.
> 
> There is a following question.
>  - Is this patch effective also for 2.4.10 ?
>  - What trouble is corrected with this patch ?

The version of the I-pipe patch you are using has another known bug than
the one fixed by the "arm: fix mm switching" patch (by the way, to be
sure that we are talking about the same patch, I would prefer an URL
pointing to xenomai's gitweb), the bug mentioned here:

https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html

And the fix for this bug in the I-pipe patches which comes with Xenomai
2.4.10 should fix both bugs.

So, in short, do you oberve the segmentation faults when using the
I-pipe patches which ship with Xenomai 2.4.10 rather than whatever patch
you are using for linux 2.6.26?

-- 
					    Gilles.

