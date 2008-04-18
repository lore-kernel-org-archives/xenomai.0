Message-ID: <d6c8ef150804180808y4d399365gad93fee2f1f9caa0@domain.hid>
Date: Fri, 18 Apr 2008 17:08:48 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0804180748o4dc88c91of90e8e26c36d32ed@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150804180733k3e2b2bc0p1255b84e16062f05@domain.hid>
	<2ff1a98a0804180748o4dc88c91of90e8e26c36d32ed@domain.hid>
Subject: Re: [Xenomai-help] Handling interrupt - jitter
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Apr 18, 2008 at 4:48 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

>  It's funny to notice how much you asked for the 2.6.24 patch for
>  actually not using it.

:) Actually, I've tried with the 2.6.24.3, Adeos 1.9-01 & Xenomai
2.4.3 before I posted my mail, but results are the same. And, yes, I'm
using it heavily, but because of some other 'compatibility issues' I
still haven't fully migrated to the 2.6.24. Thank you very much for
migrating Adeos to 2.6.24, I really appreciate it.

>  - handle interrupts in kernel space, so that you will be limited by
>  interrupt latency, not user-space scheduling latency
>  - use trunk so that user-space context switches involving real-time
>  threads do not happen with hardware interrupts off.

Will I get anything using xenomai-trunk, and still handling interrupt
from user-space?

Thanks,
Bosko

