MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17536.26182.536525.725211@domain.hid>
Date: Fri, 2 Jun 2006 18:24:38 +0200
In-Reply-To: <44806253.9020805@domain.hid>
References: <447F72A0.8000000@domain.hid>
	<17536.18621.302528.67077@domain.hid>
	<4480515F.7050500@domain.hid>
	<17536.21805.408809.703077@domain.hid>
	<44806253.9020805@domain.hid>
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
 > > bheap_destroy allow
 > > setting the bheap_t structure to an invalid value which, in turn, allow
 > > helping upper layers in catching invalid uses of the bheap after its
 > > destruction.
 > 
 > Ok, we could make bheap_destroy pop up under XENO_OPT_DEBUG. We may then
 > also add assertions to the bheap functions themselves to check for
 > invalid usage.

The checkings are already there, if you do not remove
bheap_destroy. They are unconditionnal, because I find such checkings way
too important to be optimized out.

-- 


					    Gilles Chanteperdrix.

