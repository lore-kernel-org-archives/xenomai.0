From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Wed, 19 Jun 2013 14:43:37 +0200
References: <201306110043.26534.leo@alaxarxa.net>
	<201306182333.22218.leo@alaxarxa.net>
	<934a9c927f75baad4409c50befcfec00.squirrel@www.xenomai.org>
In-Reply-To: <934a9c927f75baad4409c50befcfec00.squirrel@www.xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201306191443.38314.leo@alaxarxa.net>
Subject: Re: [Xenomai] Compiler and linker options for rtnet (and xenomai)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, rtnet-users@lists.sourceforge.net

A Dimecres, 19 de juny de 2013, Gilles Chanteperdrix va escriure:
> 
> Leopold Palomo Avellaneda wrote:
> > My problem is that neither of the three options fits my needs and to make
> > a
> > combination of two of them puts repeated options in the compiler. For
> > example
> > rtdm+native:
> >
> > -lnative -L/usr/lib -lxenomai -lpthread -lrt -lrtdm -L/usr/lib -lxenomai
> > -lpthread -lrt
> 
> So, what is the problem with this? Do you get a compiler warning? A
> compilation error?

well, 

obviously it's not a big problem, neither a problem. It's just that an option 
for rtnet will help a beginner user and don't waste time trying to understand 
why it doesn't link.

And to have a long long lines with options to the linker could produce that 
you don't see some errors in some option because the overinformation.

Leo

-- 
--
Linux User 152692
Catalonia

