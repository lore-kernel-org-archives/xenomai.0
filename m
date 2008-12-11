From: Roberto Bucher <roberto.bucher@domain.hid>
Date: Thu, 11 Dec 2008 11:19:40 +0100
References: <200812090832.43063.roberto.bucher@domain.hid>
	<200812091044.41645.roberto.bucher@domain.hid>
	<4940CF82.2070709@domain.hid>
In-Reply-To: <4940CF82.2070709@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812111119.40464.roberto.bucher@domain.hid>
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

Some results:

1) I changed the nvidia driver from 177.80 to 177.82: problem still remains
2) I changed the driver to "vesa" in the xorg.conf file: X starts but the 
problem remains!
3) I connect using ssh -X from another terminal to the RT linux machine. I 
can't reproduce the problem. When I start scilab on the RT machine the RT 
system freezes and the connection fails.

I installed the kernel 2.6.25.20 with patch  derived from adeos-ipipe-2.6.25-
x86-2.0-09.patch and the system seems to work fine.

Thanks in advance

Roberto 

On Thursday 11 December 2008 09:29:54 Jan Kiszka wrote:
> Roberto Bucher wrote:
> > Attached you can find my config. Basically, this is the same config the
> > works with version 2.6.24.7 (the only differencies are given by the new
> > CONFIG_XXX of the new linux version).
> >
> > I have a nvidia card and I use the commercial NVIDIA driver 177.80 under
> > X in Ubuntu 8.10.
>
> Thanks for the .config, will see if it triggers anything strange as well
> (ideally in kvm...), though I don't have nvidia nor its binary drivers
> around.
>
> Still some questions remain: Have you seen the problem without the
> nvidia driver, too? And is there a chance to capture the kernel console
> via serial or netconsole? Seeing an oops would help a lot.
>
> Jan
>
> PS: Please keep the list in CC.

-- 
University of Applied Sciences of Southern Switzerland
Dept. Innovative Technologies
CH-6928 Lugano-Manno
http://web.dti.supsi.ch/~bucher

