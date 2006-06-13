MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17550.48848.368995.713681@domain.hid>
Date: Tue, 13 Jun 2006 15:34:08 +0200
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
In-Reply-To: <448EBD89.4060003@domain.hid>
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>
	<448EA7F7.5000802@domain.hid> <448EB038.8070802@domain.hid>
	<17550.47269.736193.860722@domain.hid>
	<448EBD89.4060003@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > static inline unsigned long long ns_2_cycles(unsigned long long ns)
 > >  > {
 > >  >      return ns * ns2cyc_scale >> NS2CYC_SCALE_FACTOR;
 > > 
 > > This multiplication is 64 bits * 32 bits, the intermediate result may
 > > need more than 64 bits, so you should compute it the same way as the
 > > beginning of ullimd. Something like:
 > 
 > Sure, but the point is that if we were to use such code, we should bound 
 > the 64bit operand and would not use it beyond the tolerable loss of 
 > accuracy on output (e.g. 2ms).  This would require to break longer shots 
 > in several smaller ones, relying on the internal timer management logic 
 > to redo the shot until it has actually elapsed (which should be a rare 
 > case for oneshot timing), a bit like we are currently doing in bounding 
 > the values to 2^32-1 right now. Going for ullimd alike implementation 
 > somehow impedes the overall effort in reducing the CPU footprint, I 
 > guess. This said, I have still no clue if the gain in computation cycles 
 > is worth the additional overhead of dealing with possibly early shots - 
 > I tend to think it would be better on average though.

Ok, we could then write:

static inline unsigned long long ns_2_cycles(unsigned ns)
{
    return (unsigned long long) ns * ns2cyc_scale >> NS2CYC_SCALE_FACTOR;
}

-- 


					    Gilles Chanteperdrix.

