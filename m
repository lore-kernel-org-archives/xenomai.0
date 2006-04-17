MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17475.54588.216703.656939@domain.hid>
Date: Mon, 17 Apr 2006 19:49:48 +0200
Subject: Re: [Adeos-main] Re: [PATCH] clean up latest ipipe-tracing changes
In-Reply-To: <4443CA1B.3010504@domain.hid>
References: <4443BF6E.907@domain.hid>
	<17475.49504.514098.178400@domain.hid>
	<4443CA1B.3010504@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > (...). Finally, I do not see a need for marking a static inline function
 > >  > non-traced. (...)
 > > 
 > > Marking a function inline does not guarantee that the said function will
 > > always be inlined, especially since with 2.6.16, inline no longer
 > > necessary means __attribute__((always_inline)).
 > > 
 > 
 > Yep, correct, though this particular function should only be non-inlined
 > by a confused compiler. So, shouldn't we rather convert this function
 > into a macro or mark it as always_inline? A review of the tracer for
 > further clarifications is required, I guess.

In my humble opinion, the function should not be instrumented. This way,
the tracer will continue to work if the function happens to not been
inlined.

-- 


					    Gilles Chanteperdrix.

