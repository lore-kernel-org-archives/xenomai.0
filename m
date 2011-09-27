Date: Tue, 27 Sep 2011 17:10:09 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110927151009.GA3345@domain.hid>
References: <cover.1316774468.git.richard.cochran@domain.hid>
	<4E7C8EB2.1020308@domain.hid>
	<20110926114118.GA2213@domain.hid>
	<4E8188CB.4040102@domain.hid>
	<20110927120122.GA10155@domain.hid>
	<4E81BF9B.1030401@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E81BF9B.1030401@domain.hid>
Subject: Re: [Xenomai-core] [RFC 0/1] Class driver for raw Ethernet packets
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Sep 27, 2011 at 02:20:43PM +0200, Jan Kiszka wrote:
> On 2011-09-27 14:01, Richard Cochran wrote:
> > Again, every MAC driver needs to be tastefully and wisely adapted. I
> > don't necessarily need to avoid coalescing. The goal (for me) is *not*
> > to provide deterministic Ethernet performance. Instead the RT packets
> > should just be delivered ASAP.
> 
> This is obviously the point I completely missed. And it makes the whole
> thing fairly uninteresting IMHO. If you want to do Ethercat, PowerLink
> or Profinet (RT), you do need a certain level of determinism along the
> *whole* packet path. And for the latter two, you definitely need RT IRQ
> support, Ethercat can be OK to poll in fast setups.
> 
> From that POV, your approach is likely OK. But I doubt its of generic
> use, specifically for industrial RT Ethernet.

So, how does rtnet support EtherCAT?

Does it support PowerLink and Profinet?

Thanks,
Richard

