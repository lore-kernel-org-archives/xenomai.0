From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17550.59390.98050.812303@domain.hid>
Date: Tue, 13 Jun 2006 18:29:50 +0200
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
In-Reply-To: <448EE593.7010809@domain.hid>
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>
	<448EA7F7.5000802@domain.hid> <448EB038.8070802@domain.hid>
	<448EE593.7010809@domain.hid>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Philippe Gerum wrote:
 > > Here is likely why we have different levels of accuracy and performance,
 > >  firstly my version is bluntly based on the khz freq, secondly it
 > > calculates the other way around, i.e. ns2tsc, so that tsc are keep in
 > > the inner code, but more efficiently converted from ns counts passed to
 > > the outer interface:
 > > 
 > > static unsigned long ns2cyc_scale;
 > > #define NS2CYC_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 > > 
 > > static inline void set_ns2cyc_scale(unsigned long cpu_khz)
 > > {
 > >     ns2cyc_scale = (cpu_khz << NS2CYC_SCALE_FACTOR) / 1000000;
 > > }
 > > 
 > > static inline unsigned long long ns_2_cycles(unsigned long long ns)
 > > {
 > >     return ns * ns2cyc_scale >> NS2CYC_SCALE_FACTOR;
 > > }
 > 
 > Your version performs ~50% better than mine (outperforming the original
 > version by factor 7 on a 1 GHz box, vs. 4.8). I think you compared
 > non-optimised code, didn't you? Without -O2, I see 15 times better
 > performance.
 > 
 > [Gilles variant yet refuses the get benchmarked.]

Since we accept a smaller range, I think you should benchmark
nodiv_imuldiv instead of nodiv_ullimd. And it should perform better
since it uses 32 bits shifts which are not real shifts.

-- 


					    Gilles Chanteperdrix.

