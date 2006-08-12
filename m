From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17630.14923.739873.653613@domain.hid>
Date: Sat, 12 Aug 2006 22:30:03 +0200
Subject: Re: [Xenomai-core] SMI update
In-Reply-To: <200608101454.59570.schwab@domain.hid>
References: <200608091837.55424.schwab@domain.hid>
	<200608100944.34068.schwab@domain.hid> <44DAEDF9.8060500@domain.hid>
	<200608101454.59570.schwab@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org

Ulrich Schwab wrote:
 > On Thursday 10 August 2006 10:27, Jan Kiszka wrote:
 > > Ulrich Schwab wrote:
 > > > On Thursday 10 August 2006 00:44, Jan Kiszka wrote:
 > > >> Thanks for the patch, we just need some additional define of
 > > >> PCI_DEVICE_ID_INTEL_ICH7_0 for kernel 2.4 compatibility. And if you
 > > >> additionally provide a ChangeLog fragment, your patch would be perfect!
 > > >> (I tend to forget the last part often too... :) )
 > > >
 > > > Where to add the new define for kernel 2.4 ?
 > >
 > > I would say to smi.c directly as there are no other users in sight.
 > > Otherwise, wrapping code goes to include/asm-{generic|<arch>}/wrapper.h.
 > I did add the new Id to smi.c directly now.

Applied, thanks.

-- 


					    Gilles Chanteperdrix.

