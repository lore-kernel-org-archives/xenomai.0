From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Wed, 14 Nov 2007 12:21:46 +0100
References: <4739E07B.1000608@domain.hid> <200711141056.06083.lepalom@domain.hid>
	<473AC972.8070209@domain.hid>
In-Reply-To: <473AC972.8070209@domain.hid>
MIME-Version: 1.0
Message-Id: <200711141221.47396.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: Re: [Xenomai-help] Xenomai v2.4-rc6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>

A Dimecres 14 Novembre 2007, Philippe Gerum va escriure:
> Leopold Palomo-Avellaneda wrote:
> > A Dimarts 13 Novembre 2007, Philippe Gerum va escriure:
> >> Here is the sixth candidate release for the v2.4.x branch.
> >
> > [....]
> >
> >> 	[i386, x86_64 => x86]
> >>
> >> 	* Merge i386 and x86_64 arch-dep support as x86.
> >>  	* Update Adeos/i386 support for 2.6.20, 2.6.22 and 2.6.23.
> >
> > [...]
> >
> > this has break the creation of the debian packages. I can understand that
> > conceptually they are the same arch (one with 32bits and another with 64
> > and more extensions) in general _all_ the distros treat them as two
> > different arch.
>
> How long do you think this is going to be that way, with 2.6.24 actually
> merging those supports at kernel level?
>
>  So this changes break things. I don't think that it's a good idea do it
>
> > in a release candidate, IMHO.
>
> We discussed this issue and the reason for doing this change asap in
> length on the mailing list two weeks ago or so. Please have a look at
> the archive for more. You will also find some significant patches
> already exploiting the new common tree in order to streamline the code,
> and ease maintenance on our side. Few resources, large work, we have to
> be efficient, and maintaining two closely related archs sharing bits in
> separate code bases is pointless, and a loss of time for the project.
>

Ok,

I'm not subscribing to xenomai-core, so I don't know if this have been 
discussed on the list.

Yes, I didn't have done a search on the web/list about if this have been 
discused, I just have pointed that you are working (with a few resources, 
etc) to release a new version rc-6 and have done a change that break 
our "lazy way" of install/ compile xenomai. I don't know if others things.

I'm sure that you have worked/thought that this is the best way to do the 
things. Now I have read the thread about it and well, it's just a normal 
discussions about to make a important change and the people comment. You as 
project leader have an idea that you think that it's good for the project, 
and you implement it. And other people saying, ok, if you want to do it, I 
will try to help...

I can understand that my post have ..... I don't know the verb in english, in 
catalan will be "tocar-te els collons" and in english something like "touch 
your balls". That's not my intention, really.

I also will try to help it and I will look the debian packages to solve 
this ... ;-) and probably I'm one this strange people that if I use a open 
source soft and I begin I use a release candidate to test it and try help. At 
least some kind of .. please could you run bla, or can you try bla ... but 
I'm not statistically important because I'm not showed at google ;-)

Leo

PS from some mail that I have read:
... sun is still shining, birds are still singing, hardware is not burning - 
yet. 








