MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17536.18621.302528.67077@domain.hid>
Date: Fri, 2 Jun 2006 16:18:37 +0200
In-Reply-To: <447F72A0.8000000@domain.hid>
References: <447F72A0.8000000@domain.hid>
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
 > (...)
 > +#define DECLARE_BHEAP_CONTAINER(name, sz) \
 > +    struct { \
 > +        bheap_t bheap; \
 > +        bheaph_t elems[sz]; \
 > +    } name
 > +

Don't you mean bheaph_t *elems[sz] ?

 > (...)
 > +typedef struct {
 > +    bheap_t bheap;
 > +    bheaph_t __buffer[CONFIG_XENO_OPT_TIMER_HEAP_CAPACITY];
 > +} xntimerq_t;

Same remark. And why not using the macro here ?

I would also prefer passing the bheaph_t** storage to bheap_init, and
conserve bheap_destroy (with a callback called with the bheap_t**
storage) in case the storage was dynamically allocated by the caller.

-- 


					    Gilles Chanteperdrix.

