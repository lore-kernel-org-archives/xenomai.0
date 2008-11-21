Message-ID: <492690A5.8010703@domain.hid>
Date: Fri, 21 Nov 2008 11:42:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49268C78.5010600@domain.hid>
In-Reply-To: <49268C78.5010600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mark libs with nodlopen when
 using	initial-exec TLS
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
> Some naive optimist once claim that the dynamic linker would detect if
> we try to dlopen some Xenomai lib (directly or indirectly) which uses
> the optimised initial-exec TLS variables. He was wrong of course. It
> takes the special marker nodlopen to achieve this, and that's what the
> patch below does when and where required.

Ok. But I think we should document somewhere the fact that dlopening
Xenomai libs will not work because of __thread.

-- 
                                                 Gilles.

