From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46763C3D.3080005@domain.hid>
References: <464814D9.8070700@domain.hid>
	<1179135141.5045.53.camel@domain.hid> <46763C3D.3080005@domain.hid>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 14:28:10 +0200
Message-Id: <1182256090.6569.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Adeos for Linux 2.6.19 PowerPC kernels.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin ZORES <benjamin.zores@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-06-18 at 10:03 +0200, Benjamin ZORES wrote:
> Philippe Gerum wrote:
> > FWIW, I've almost finished an I-pipe port over 2.6.21 also using the
> > arch/powerpc tree. It relies on the genirq layer which makes things way
> > more comfortable, and which does not require to redefine particular ack
> > routines but rather keep the original irqchip handlers.
> >
> >   
> Hello Philippe,
> 
> Do you have any news about the 2.6.21 port ?
> Is there something that can be tested ?
> > This should get better when the I-pipe/powerpc development is merged
> > into the main git repo here, which should happen in a reasonable future:
> > http://www.denx.de/cgi-bin/gitweb.cgi?p=ipipe-2.6.git;a=summary
> >
> >   
> There's not much about PowerPC arch changes right there.
> Is the development stuck ? :-(
> 
> Thanks for any news.

Highest priority goes to closing the merge window before 2.4-rc1 which mostly
consists of integrating all generic core changes, and we are already late on this.

2.6.21/powerpc will be there for 2.4 final; but since we do have a decent
2.6.19/ppc support available already, the former will have to wait
because it is not on the critical path - AFAIC, that is.

-- 
Philippe.



