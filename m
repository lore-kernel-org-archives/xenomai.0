MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.41333.124122.921988@domain.hid>
Date: Fri, 18 Aug 2006 13:16:05 +0200
Subject: Re: [Xenomai-core] [rfc, patch] allow timer interrupt to be shared.
In-Reply-To: <1155898533.4326.50.camel@domain.hid>
References: <17636.56428.140050.265677@domain.hid>
	<1155898533.4326.50.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > I'd rather keep the number of obscure conditional macros as low as
 > possible; we should actually try to reduce them since we have a growing
 > number of real and pseudo-archs to support, and those macros tend to
 > obfuscate the generic code.
 > 
 > In the same vein, is there anything we could use in the compatible Adeos
 > patch that would unambiguously identify the presence of such support
 > without resorting to yet-another-macro like IPIPE_HAVE_SHARED_TIMER_IRQ?

We could decide that ipipe_timer_irq_p() must be implemented as a macro,
and use #ifdef ipipe_timer_irq_p but I thought that #ifdef
IPIPE_HAVE_SHARED_TIMER_IRQ was easier to understand.

-- 


					    Gilles Chanteperdrix.

