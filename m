Date: Wed, 28 Sep 2011 10:16:06 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110928081606.GC6670@domain.hid>
References: <20110926114118.GA2213@domain.hid>
	<4E8188CB.4040102@domain.hid>
	<20110927120122.GA10155@domain.hid>
	<4E81BF9B.1030401@domain.hid>
	<20110927151009.GA3345@domain.hid>
	<4E81E8B9.8000004@domain.hid>
	<20110927160536.GA2425@domain.hid>
	<4E81F944.3070200@domain.hid>
	<20110927170012.GA6057@domain.hid>
	<4E8206F3.8010802@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E8206F3.8010802@domain.hid>
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

On Tue, Sep 27, 2011 at 07:25:07PM +0200, Jan Kiszka wrote:
> 
> It manages buffers for you, provides NIC drivers and interfaces to
> either build the higher protocol layers in the kernel or in user space.
> That's the mission, but I would not exclude that there is room for
> improvements (lacking safe copy-to/from user, unneeded RX thread for
> single-user scenarios and possibly more). Still, the Ethercat master
> library folks chose it back then as a platform, maybe you want to ask them.

Getting a little off topic, I wonder, who are these "Ethercat folks" of
whom you speak?

I do know of a few open source implementations, but none are based
Xenomai:

* IgH etherlab
  This is a complete stack in the kernel. Although they claim it works
  with Xenomai, in fact it does not, since it uses regular kernel spin
  locks, etc. However, it could be adapted to work with Xenomai.
* SOEM
  This is a user space (really simple) stack based on normal raw
  sockets. It could also be adapted to use Xenomai, by adding some
  sort of raw RT socket.
* OSADL
  This was withdrawn because of license concerns. I never saw the
  code, but I do beleive it was a user space solution using standard
  sockets.
* Another?
  There once was some C++ program from some institute in the
  Netherlands (or Belgium? can't remember), but it was also withdrawn.

So, did you mean any of these, or yet another implementation?

Thanks,
Richard


