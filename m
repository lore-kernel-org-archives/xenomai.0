From: Roberto Bucher <roberto.bucher@domain.hid>
Date: Sat, 13 Dec 2008 18:20:46 +0100
References: <200812090832.43063.roberto.bucher@domain.hid>
	<200812111119.40464.roberto.bucher@domain.hid>
	<4943A2AF.1050007@domain.hid>
In-Reply-To: <4943A2AF.1050007@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812131820.46419.roberto.bucher@domain.hid>
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

I have the problem on a Dual Core Machine (2xT9600 Processor). 

On a Centrino machine with 1 processor, the same kernel+patch seems to be ok.

Paolo Mantegazza has a similar problem on 3 Dual core machines.

Thanks

Roberto

On Saturday 13 December 2008 12:55:27 Jan Kiszka wrote:
> Roberto Bucher wrote:
> > Some results:
> >
> > 1) I changed the nvidia driver from 177.80 to 177.82: problem still
> > remains 2) I changed the driver to "vesa" in the xorg.conf file: X starts
> > but the problem remains!
> > 3) I connect using ssh -X from another terminal to the RT linux machine.
> > I can't reproduce the problem. When I start scilab on the RT machine the
> > RT system freezes and the connection fails.
> >
> > I installed the kernel 2.6.25.20 with patch  derived from
> > adeos-ipipe-2.6.25- x86-2.0-09.patch and the system seems to work fine.
>
> Another question (before I actually start looking at code): Are all test
> boxes using > 1 CPUs? Or is the issue also present when there is only a
> single CPU?.
>
> Jan

-- 
University of Applied Sciences of Southern Switzerland
Dept. Innovative Technologies
CH-6928 Lugano-Manno
http://web.dti.supsi.ch/~bucher

