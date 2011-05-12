From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <201105122201.47478.lux-integ@domain.hid>
References: <201105101823.50226.lux-integ@domain.hid>
	<201105111631.00882.lux-integ@domain.hid>
	<4DCAABF6.9090606@domain.hid>
	<201105122201.47478.lux-integ@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 May 2011 23:05:45 +0200
Message-ID: <1305234345.2168.63.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] preferred  uid?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luxInteg <lux-integ@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2011-05-12 at 22:01 +0100, luxInteg wrote:
> On Wednesday 11 May 2011 16:32:06 Gilles Chanteperdrix wrote:
> > On 05/11/2011 05:31 PM, luxInteg wrote:
> > > On Tuesday 10 May 2011 20:23:43 Gilles Chanteperdrix wrote:
> > >> On 05/10/2011 07:23 PM, luxInteg wrote:
> > >>> greetings
> > >>> 
> > >>> I normally  compile stuff as an ordinary user,  but   I noticed in this
> > >>> area people often compile as root as  kernel  modules are involved.   I
> > >>> note xenomai can be compiled either as user or root so  is there a
> > >>> preferred way ?
> > >> 
> > >> As others have said, compile as ordinary user, run make install or make
> > >> modules_install as root, or run "sudo make install". Another reason for
> > >> running "make install" as root, is that root privilege is also required
> > >> to create the device nodes (/dev/rtheap, /dev/rtp*) needed by Xenomai
> > >> applications.
> > > 
> > > yes this is my rule of thumb  too
> > > 
> > > However   as I read through the install file  in the xenomai tarball   I
> > > noticed  there  was only reference   to 'make install' (at least on x86
> > > platforms).  i did this   and did not bother with running make.  Is this
> > > acceptable?
> > 
> > As we already told you, it is preferable to run
> > make
> > then
> > sudo make install
> > 
> > For reasons already explained in the three answers you received.
> 
> so perhaps you should update the INSTALL file   that accompany released 
> tarballs of xenomai  then?

Do not hesitate to contribute such update since you are now well aware
of the issue, a simple patch would do. Anything which may help the
Xenomai maintainers to cope with the workload involved in bringing you
that software is welcome.

> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



