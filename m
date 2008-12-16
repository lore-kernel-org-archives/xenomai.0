From: Roberto Bucher <roberto.bucher@domain.hid>
Date: Tue, 16 Dec 2008 11:08:10 +0100
References: <200812090832.43063.roberto.bucher@domain.hid>
	<200812151919.10849.roberto.bucher@domain.hid>
	<494772EB.9090309@domain.hid>
In-Reply-To: <494772EB.9090309@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812161108.10943.roberto.bucher@domain.hid>
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

The patch from Gilles seems to be promising. I started scilab 10 times without 
freezing the PC!!!

I need more tests (and time) to be shure that the system is ok. I'll give you 
other feedback tomorrow. I'll try to work for some time with the present 
kernel.

Thanks 

Roberto

On Tuesday 16 December 2008 10:20:43 Jan Kiszka wrote:
> Roberto Bucher wrote:
> > I've unchecked the CONFIG_MTRR flag in kernel, but the behaviour is
> > exactly the same (scilab->freeze)
>
> Mmmh, would have been too easy.
>
> Next try: Gilles posted the attached fix for a quad system boot issue
> yesterday (also available as adeos-ipipe-2.6.27-x86-2.2-02.patch). Maybe
> it has some effect for you as well.
>
> Nevertheless, I will continue to dig into the patch as I see some SMP
> affinity issue for Linux IRQs.
>
> Jan

-- 
University of Applied Sciences of Southern Switzerland
Dept. Innovative Technologies
CH-6928 Lugano-Manno
http://web.dti.supsi.ch/~bucher

