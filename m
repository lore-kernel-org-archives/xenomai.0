Date: Tue, 27 Sep 2011 18:05:37 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110927160536.GA2425@domain.hid>
References: <cover.1316774468.git.richard.cochran@domain.hid>
	<4E7C8EB2.1020308@domain.hid>
	<20110926114118.GA2213@domain.hid>
	<4E8188CB.4040102@domain.hid>
	<20110927120122.GA10155@domain.hid>
	<4E81BF9B.1030401@domain.hid>
	<20110927151009.GA3345@domain.hid>
	<4E81E8B9.8000004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E81E8B9.8000004@domain.hid>
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

On Tue, Sep 27, 2011 at 05:16:09PM +0200, Jan Kiszka wrote:
> On 2011-09-27 17:10, Richard Cochran wrote:
> > On Tue, Sep 27, 2011 at 02:20:43PM +0200, Jan Kiszka wrote:
> >> On 2011-09-27 14:01, Richard Cochran wrote:
> >>> Again, every MAC driver needs to be tastefully and wisely adapted. I
> >>> don't necessarily need to avoid coalescing. The goal (for me) is *not*
> >>> to provide deterministic Ethernet performance. Instead the RT packets
> >>> should just be delivered ASAP.
> >>
> >> This is obviously the point I completely missed. And it makes the whole
> >> thing fairly uninteresting IMHO. If you want to do Ethercat, PowerLink
> >> or Profinet (RT), you do need a certain level of determinism along the
> >> *whole* packet path. And for the latter two, you definitely need RT IRQ
> >> support, Ethercat can be OK to poll in fast setups.
> >>
> >> From that POV, your approach is likely OK. But I doubt its of generic
> >> use, specifically for industrial RT Ethernet.
> > 
> > So, how does rtnet support EtherCAT?
> 
> There was once the EtherCAT Master Library. IIRC, it was discontinued
> and removed from the web for non-technical reasons.
> 
> > 
> > Does it support PowerLink and Profinet?
> 
> Not that I know, but that's not the point. You said your approach could
> provide the technical foundation for such a class of use cases while I
> doubt it would work as is.

But that is the point. Correct me please if I am wrong, but isn't
rtnet a competitor or alternative to EtherCAT, PowerLink, and
Profinet?

Unless rtnet implements (or helps to implement) these, it is kind of
silly to say, "your way won't work, you should use rtnet instead."

I don't know PowerLink or Profinet, but I do know EtherCAT and IEC
61850, and those two can surely be implemented on the interface that I
am talking about.

Also, the interface that I propose does not preclude the use of RTDM
ISR in the driver, so I wonder what exactly bothers you about it?

Thanks,
Richard

