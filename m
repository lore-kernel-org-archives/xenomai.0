Message-ID: <2ff1a98a0712200720rf28c56bld833313aaaa4c567@domain.hid>
Date: Thu, 20 Dec 2007 16:20:47 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB028A9712@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB028A9712@domain.hid>
Subject: Re: [Xenomai-core] Auto closing of file descriptors and fork.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Dec 20, 2007 4:13 PM, Daniel Schnell <daniel.schnell@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > Hi,
> >
> > I have a problem with auto closing of file descriptors and fork. I
> > have an application (a modified pppd, to name it), which in a certain
> > mode (pppd "updetach" mode) opens some real-time file descriptors,
> > forks and exit the parent, continuing to use the file descriptors in
> > the child. The problem is that when exiting the parent, file
> > descriptors are automatically destroyed and therefore can not be used
> > in the child.
> >
> > Any ideas for a fix ?
>
> Maybe not exiting the child but saying waitpid() ?

The problem is that the aim of pppd updetach is to exit the parent
once the connection is established, so that the script running pppd
can continue.

-- 
                                               Gilles Chanteperdrix

