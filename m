From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17550.47269.736193.860722@domain.hid>
Date: Tue, 13 Jun 2006 15:07:49 +0200
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
In-Reply-To: <448EB038.8070802@domain.hid>
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>
	<448EA7F7.5000802@domain.hid> <448EB038.8070802@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > static inline unsigned long long ns_2_cycles(unsigned long long ns)
 > {
 >      return ns * ns2cyc_scale >> NS2CYC_SCALE_FACTOR;

This multiplication is 64 bits * 32 bits, the intermediate result may
need more than 64 bits, so you should compute it the same way as the
beginning of ullimd. Something like:

static inline unsigned long long ns_2_cycles(unsigned long long ns)
{
    unsigned nsh, nsl, tlh, tll;
    unsigned long long th, tl;

    __rthal_u64tou32(ns, nsh, nsl);
    tl = rthal_ullmul(nsl, ns2cyc_scale);
    __rthal_u64tou32(tl, tlh, tll);
    th = rthal_ullmul(nsh, ns2cyc_scale);
    th += tlh;

    tll = (unsigned) th << (32 - NS2CYC_SCALE_FACTOR) | tll >> NS2CYC_SCALE_FACTOR;
    th >>= NS2CYC_SCALE_FACTOR;
    return __rthal_u64fromu32(th, tll);
}


-- 


					    Gilles Chanteperdrix.

