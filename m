Date: Fri, 4 Apr 2008 14:22:37 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080404122237.GR13814@domain.hid>
References: <20080401103647.GR13814@domain.hid>
	<47F4A55B.4060605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <47F4A55B.4060605@domain.hid>
Subject: Re: [Xenomai-core] [PATCH][SOLO] add sparse support
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
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, Apr 03, 2008 at 11:37:31AM +0200, Philippe Gerum wrote:
> Robert Schwebel wrote:
> > This patch adds static analysis support with sparse to the xenomai-solo
> > makefiles. To enable sparse checking, use
> > 
> > 	./configure --with-sparse[=PATH]
> > 
> > and run 'make sparse' afterwards. I don't have a good idea right now how
> > to avoid this extra step; it would be much nicer if every call to
> > $(COMPILE) could be substituted by a sparse call plus the original one,
> > but I didn't find a good method for that yet that also works with the
> > libtool calls.
> >
> 
> I have merged this patch series, adapting the Makefiles so that we don't need
> any support from configure.in to run sparse.
> 
> Normally, you should be able to run "make [SPARSE=/path/to/sparse] sparse" to
> start the analysis. Default path is "sparse".
> 
> Additionally, this now works with out of tree builds and supports mixed 32/64bit
> environments.

Great! Thanks.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


