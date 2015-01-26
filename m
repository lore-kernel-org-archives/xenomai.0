Date: Mon, 26 Jan 2015 15:59:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150126145943.GK12812@hermes.click-hack.org>
References: <129277905.Ag2XebZWbK@soho> <2052908.cWhQn5Pgch@soho>
 <20150126140826.GI12812@hermes.click-hack.org>
 <1531214.hYcPgWDQ6s@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1531214.hYcPgWDQ6s@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Mon, Jan 26, 2015 at 03:56:08PM +0100, Leopold Palomo-Avellaneda wrote:
> El Dilluns, 26 de gener de 2015, a les 15:08:26, Gilles Chanteperdrix va 
> escriure:
> 
> [...]
> 
> > Sure, but in that case you would have two xenomai build trees, that
> > you can configure with different options so that they do not collide
> > once installed.
> 
> I'm sure that you can install it where do you want. But are you sure that you 
> can install a library in a path outside the standard place, without touching 
> ld.so.conf and you can have a program running from an installation?

In Debian wheezy (and I assume any later revision), there is an
/etc/ld.so.conf.d directory where each package can install its
file with the directories it wants to add to the search path.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150126/900f2883/attachment.sig>
