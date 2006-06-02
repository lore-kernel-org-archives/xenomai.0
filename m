MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17536.21805.408809.703077@domain.hid>
Date: Fri, 2 Jun 2006 17:11:41 +0200
In-Reply-To: <4480515F.7050500@domain.hid>
References: <447F72A0.8000000@domain.hid>
	<17536.18621.302528.67077@domain.hid>
	<4480515F.7050500@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: [patch] static buffer for timer-bheap
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
 > Gilles Chanteperdrix wrote:
 > > I would also prefer passing the bheaph_t** storage to bheap_init, and
 > > conserve bheap_destroy (with a callback called with the bheap_t**
 > > storage) in case the storage was dynamically allocated by the caller.
 > 
 > Do you have a concrete usage scenario in mind where this would be
 > required? I would rather bet that potential callers of bheap_destroy
 > know very well when some buffer is to be released. Looks at bit like
 > overkill unless someone has the real need to mix dynamically with
 > statically allocated bheaps.

Requesting a bheaph_t ** to be passed to bheap_init is type-safe and
would have caught the kind of mistake you have done. bheap_destroy allow
setting the bheap_t structure to an invalid value which, in turn, allow
helping upper layers in catching invalid uses of the bheap after its
destruction.

It is a low price to pay to make the interface a bit safer.

-- 


					    Gilles Chanteperdrix.

