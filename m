Date: Fri, 20 Oct 2006 10:31:04 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Subject: Re: [Xenomai-help] Re: LIRE LInux Real-time Environment
Message-ID: <20061020083104.GA18636@domain.hid>
References: <s5363968.059@domain.hid> <45362AE0.60301@domain.hid>
	<1161270429.9460.17.camel@domain.hid> <4537AA25.4090900@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4537AA25.4090900@domain.hid>
Sender: Robert Schwebel <rsc@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, kritop@domain.hid

On Thu, Oct 19, 2006 at 06:39:01PM +0200, Jan Kiszka wrote:
> > What build system are you chosen?
> 
> PTXdist is under consideration for quite some time, but resources were
> simply too limited to "play" with it.

Tell me if we can do something to boost your playing activities :)

> We first need to find a clean model how to integrate the Xenomai build
> process so that we can build from a single Xenomai source tree (to
> allow development on that Xenomai tree), but do not turn PTXdist
> upside down. Should be feasible. Once this is done, all other packets
> that are missing will be easy to port.

PTXdist can easily cope with usual things like patches, patch stacks
with series files and local software packages. So everything you need
should be there without turning PTXdist upside down. 

> The roadmap then looks like using PTXdist to build binary packets
> (like we now do on our own) AND a toolchain (we simply use SuSE so
> far), but first keep our installation process. Enhancing PTXdist with
> generic "installation skins" may be a future step, also depending on
> the further development of that project.

I missed the beginning of this discussion - which features are you
missing? PTXdist is able to build ipkg binary packets. It might also be
a good idea to discuss this on the PTXdist mailing list: 

	http://www.pengutronix.de/mailinglists/index_en.html

and not here.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


