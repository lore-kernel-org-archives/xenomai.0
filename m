From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Mon, 15 Jun 2015 11:02:08 +0200
Message-ID: <1492864.8gpLiNMyCe@soho>
In-Reply-To: <6cbaf8e2f1d872e05fcb58ae61279c17.squirrel@sourcetrek.com>
References: <1859656.Cz6t9ftYOG@soho>
 <6cbaf8e2f1d872e05fcb58ae61279c17.squirrel@sourcetrek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Generating the documentation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

El Dilluns, 15 de juny de 2015, a les 10:47:36, Gilles Chanteperdrix va 
escriure:
> Leopold Palomo-Avellaneda wrote:
> > Hi,
> > 
> > I try to generate the documentation (2.6.4, official tarball) using:
> > 
> > ./configure --enable-dox-doc
> > 
> > and I have found that make -jX with X >= 2 fails:
> > 
> > and I got this message:
> > 
> > make[2]: Entering directory
> > '/srv/drp/packages/xenomai/xenomai.git/build/doc/doxygen'
> > doxygen
> > make[2]: *** No rule to make target 'api/search', needed by 'all-local'.
> > Stop.
> > make[2]: *** Waiting for unfinished jobs....
> > 
> > 
> > so, IMHO there's something wrong in the dependencies. Then, I would like
> > kindly to ask to upstream if you can:
> > 
> > - review the generation of the documentation, to avoid this error.
> > 
> > or if it's not obvious,
> > 
> > please add "make doc" target and take out from the default rule to be able
> > to
> > do:
> > 
> > - make -jX (>=2)
> > - make -j1 doc
> > 
> > Best regards,
> 
> The documentation generation is reserved to the maintainer. Why do you
> need it?

because it's recommended generate the documentation when you create the debian 
package. That's all.

Leopold

-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

