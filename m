Message-ID: <934a9c927f75baad4409c50befcfec00.squirrel@www.xenomai.org>
In-Reply-To: <201306182333.22218.leo@alaxarxa.net>
References: <201306110043.26534.leo@alaxarxa.net>
	<201306151740.30939.leo@alaxarxa.net>
	<ca9bc8023d17b2e095231bfb1a527cef.squirrel@www.xenomai.org>
	<201306182333.22218.leo@alaxarxa.net>
Date: Wed, 19 Jun 2013 13:45:13 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Compiler and linker options for rtnet (and xenomai)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo Avellaneda <leo@alaxarxa.net>
Cc: Xenomai <xenomai@xenomai.org>, rtnet-users@lists.sourceforge.net


Leopold Palomo Avellaneda wrote:
> My problem is that neither of the three options fits my needs and to make
> a
> combination of two of them puts repeated options in the compiler. For
> example
> rtdm+native:
>
> -lnative -L/usr/lib -lxenomai -lpthread -lrt -lrtdm -L/usr/lib -lxenomai
> -lpthread -lrt

So, what is the problem with this? Do you get a compiler warning? A
compilation error?

-- 
                    Gilles.


