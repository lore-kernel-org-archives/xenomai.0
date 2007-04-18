From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17958.32569.506331.124185@domain.hid>
Date: Wed, 18 Apr 2007 22:27:37 +0200
In-Reply-To: <1176926837.5010.90.camel@domain.hid>
References: <46265FC8.1070207@domain.hid>
	<1176926837.5010.90.camel@domain.hid>
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > - the posix registry

Is it enough to replace 1 << (fd % BITS_PER_LONG) 
with 1L << (fd % BITS_PER_LONG) ?

-- 


					    Gilles Chanteperdrix.

