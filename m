Message-ID: <4562CE05.70900@domain.hid>
Date: Tue, 21 Nov 2006 10:59:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 3/3] control POSIX skin
	debugging	independently
References: <456236E5.5060203@domain.hid>
In-Reply-To: <456236E5.5060203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
> Following the logic of per-subsystem debug feature control, this patch
> introduces a separate kconfig switch XENO_OPT_POSIX_DEBUG and updates
> the involved source files.

I find the "if(XENO_DEBUG(FOO))" notation make it hard to understand
that the piece of code that follows is disabled at compilation time,
#ifdef CONFIG_XENO_OPT_FOO_DEBUG is easier to read. This also avoid the
rather inelegant

#ifndef CONFIG_XENO_OPT_POSIX_DEBUG
#define CONFIG_XENO_OPT_POSIX_DEBUG 0
#endif

Now about the Posix skin patch, in my opinion the Posix skin debug
should be enabled by default, because these printks are the indication
that there is something wrong in the user code: some objects were
created but not destroyed.

-- 
                                                 Gilles Chanteperdrix

