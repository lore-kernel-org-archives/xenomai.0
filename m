MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17475.49504.514098.178400@domain.hid>
Date: Mon, 17 Apr 2006 18:25:04 +0200
In-Reply-To: <4443BF6E.907@domain.hid>
References: <4443BF6E.907@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Adeos-main] Re: [PATCH] clean up latest ipipe-tracing changes
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
 > (...). Finally, I do not see a need for marking a static inline function
 > non-traced. (...)

Marking a function inline does not guarantee that the said function will
always be inlined, especially since with 2.6.16, inline no longer
necessary means __attribute__((always_inline)).

-- 


					    Gilles Chanteperdrix.

