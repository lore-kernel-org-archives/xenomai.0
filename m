Date: Tue, 27 Sep 2011 19:04:00 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110927170358.GB6057@domain.hid>
References: <4E7C8EB2.1020308@domain.hid>
	<20110926114118.GA2213@domain.hid>
	<4E8188CB.4040102@domain.hid>
	<20110927120122.GA10155@domain.hid>
	<4E81BF9B.1030401@domain.hid>
	<20110927151009.GA3345@domain.hid>
	<4E81E8B9.8000004@domain.hid>
	<20110927160536.GA2425@domain.hid>
	<4E81F944.3070200@domain.hid> <4E81FA08.4080106@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E81FA08.4080106@domain.hid>
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

On Tue, Sep 27, 2011 at 06:30:00PM +0200, Jan Kiszka wrote:
> On 2011-09-27 18:26, Jan Kiszka wrote:
> > I was simply hoping to collect some new ideas how to address the driver
> > maintenance issue in a better way but without dropping key features
> > needed for RT networking. Something like "let's add generic RT channels
> > to Linux upstream drivers and then only patch them fit RTDM". Not sure
> > if that works, but it would come with a vision how to keep things more
> > maintainable.
> 
> +this could be useful for other scenarios - on PREEMPT-RT.

(But PREEMPT-RT will make the whole kernel deterministic, right? ;)

Adding low-latency channels (eg. working against coalescing) will be a
very hard sell upstream.

Richard

