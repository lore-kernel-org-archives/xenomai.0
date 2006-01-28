From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17371.18068.638207.894883@domain.hid>
Date: Sat, 28 Jan 2006 11:25:24 +0100
Subject: Re: [Xenomai-core] [PATCH] fix pthread cancellation in native skin
In-Reply-To: <43DB3AB1.5090004@domain.hid>
References: <43DB3AB1.5090004@domain.hid>
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
 > Hi,
 > 
 > Gilles' work on cancellation for the posix skin reminded me of this
 > issue I once discovered in the native skin:
 > 
 > https://mail.gna.org/public/xenomai-core/2005-12/msg00014.html
 > 
 > I found out that this can easily be fixed by switching the pthread of a
 > native task to PTHREAD_CANCEL_ASYNCHRONOUS. See attached patch.

Applied, thanks.

-- 


					    Gilles Chanteperdrix.

