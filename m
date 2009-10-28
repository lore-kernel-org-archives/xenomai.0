From: Leopold Palomo Avellaneda <leo@domain.hid>
Date: Wed, 28 Oct 2009 15:53:36 +0100
References: <200910281314.00378.leo@domain.hid> <4AE84AED.20108@domain.hid>
In-Reply-To: <4AE84AED.20108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200910281553.36891.leo@domain.hid>
Subject: Re: [Xenomai-help] Xenomai patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

A Dimecres 28 Octubre 2009, Gilles Chanteperdrix va escriure:
> Leopold Palomo-Avellaneda wrote:
> > Hi,
> >
> > I'm having a trouble installing xenomai in a debian machines. Actually
> > the official debian package is not useful. You cannot use it because
> > there's no kernel package that could be patched.
>
> The debian packages are not maintained by the Xenomai project. So, if
> you are having problems with these, please contact Roland Stigge. 

[...]

yes, I know. Sorry for the noise. My fingers were faster than my brain. This 
comment have to go as bug to the package, not to the xenomai list.

>
> > Anyway, I would like to ask about if, for example, a patch against a
> > 2.6.30 could be used against 2.6.30.4 for example or reverse.
>
> Usually, I-pipe patches are for the base release, but work with later
> releases. When it happens that there is a conflict, and we find out
> about it, we release another I-pipe patch e.g for 2.6.30.4. In that
> case, you need to use the I-pipe patch for 2.6.30.4 for 2.6.30.4 and later.

well, as I understand if you release a I-pipe patch for a kernel 2.x.y 
it "should work" for all the releases 2.x.y.z (z>0) in "theory", but if 
there's a problem, then you release a patch for 2.x.y.z and this patch then 
works for 2.x.y.z (where z is the version where the conflict occurred, no?

But this patch also works with the previous versions (0 < z < ...) ?


> > I don't understand why
> > this four numbers instead of the classical 3. Or, how can I modify it to
> > use it.
>
> These are releases from the stable branch:
> http://kernelnewbies.org/FAQ/VariousKernelTrees

Ok,

thanks for the link. Well explained.

Regards,

Leo

-- 
--
Linux User 152692     PGP: 0xF944807E
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

