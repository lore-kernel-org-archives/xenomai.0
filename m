Message-ID: <434B7447.8060203@domain.hid>
Date: Tue, 11 Oct 2005 11:13:59 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Generated docs
References: <434B6BC6.4030401@domain.hid>	<17227.27763.201941.114412@domain.hid>	<434B6FA4.80309@domain.hid>
	<17227.29206.223750.761504@domain.hid>
In-Reply-To: <17227.29206.223750.761504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix kirjoitti:
> Heikki Lindholm wrote:
>  > Gilles Chanteperdrix kirjoitti:
>  > > Heikki Lindholm wrote:
>  > >  > Hi,
>  > >  > 
>  > >  > One thing that always bothered my in fusion cvs: why do the generated 
>  > >  > docs have to be in the cvs/svn? Why not just let them be... well... 
>  > >  > generated?
>  > > 
>  > > Because it allows the releases to be done taking the docs from the
>  > > generated dir instead of generating them.
>  > 
>  > How about having "dist" or similar target in the Makefile do that, 
>  > instead? Releases aren't that often anyway.
> 
> dist does that only if documentation generation is enabled, if this was
> not an option, it would not allow separate maintenance of documentation
> and code. Some time ago, the plan was even to let documentation have its
> own configure, like the simulator.
> 
> If you do not checkout the "doc" or "sim" directory, the build system is
> supposed to continue working properly. It will not let you enable
> documentation generation or simulator, though.

Ok. I haven't actually tried that ever.

>  > 
>  > > IOW: separate maintenance of documentation and code.
>  > > 
>  > > What I do not understand is what is so bothering ?
>  > 
>  > (1) Kind of like having binaries in the repo: changes between generated 
>  > docs aren't usually meaningful. Doing diff between version dirs where 
>  > there's not much changed codewise, but different generations of docs 
>  > brings unneccessarily big diff or needs special attention not to. Btw. 
> 
> diff (and probably svn diff) have a --exclude option. So, you can skip

Indeed. But this is the special attention I'm talking about ;) I'm still 
not convinced about the "need 'em for the release" reasoning. Let's put 
it this way: what trouble would it bring, if we had "dist" always 
generate docs for a release (and not have them in the repo)?

>  > Many projects don't even have autoconf/make generated stuff (=configure) 
>  > in the repository..
> 
> I guess this is a matter of taste, but by putting the generated stuff
> into the repository, we do not impose contributors and users who want to
> work with the svn head to have the proper version of the autotools
> installed and to know how to use them. This is a little effort with a
> big pay off.

True. I've had my share of autoconf troubles and don't like the whole 
system at all. Having it ready-made is definitely the right thing to do.

-- Heikki Lindholm

