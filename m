Message-ID: <48F79E94.7070404@domain.hid>
Date: Thu, 16 Oct 2008 22:05:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>
	<20081016154621.488387180@domain.hid>
In-Reply-To: <20081016154621.488387180@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 07/12] Convert POSIX skin to fast xnsynch
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

This patch contains too many #ifdefs.

Things like

#ifdef CONFIG_XENO_FASTSYNCH
if (xnsynch_fast_owner_check(...))
#else
if (xnsynch_owner(...) == ...)
#endif

could be replaced with only one macro xnsynch_check_owner in synch.h
that would be defined with some #ifdefs, and used everywhere without
#ifdefs.

-- 
					    Gilles.

