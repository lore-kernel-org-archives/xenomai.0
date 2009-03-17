Message-ID: <49BFEEE4.6020204@domain.hid>
Date: Tue, 17 Mar 2009 19:41:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49BFED6E.4090009@domain.hid>
In-Reply-To: <49BFED6E.4090009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] posix: Fix error checks when copying
 user strings
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
> Obviously a conversion error while switching to __xn_safe*.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

Well, I have just checked the kernel code, and 0 as a return value of
strncpy_from_user is treated as a value in most places, even if not -EFAULT.

-- 
                                                 Gilles.

