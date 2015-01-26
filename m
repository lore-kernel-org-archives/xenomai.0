Date: Mon, 26 Jan 2015 19:32:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150126183217.GM12812@hermes.click-hack.org>
References: <129277905.Ag2XebZWbK@soho> <1531214.hYcPgWDQ6s@soho>
 <20150126145943.GK12812@hermes.click-hack.org>
 <2155048.C7RTQC2ILE@indiana>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2155048.C7RTQC2ILE@indiana>
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

On Mon, Jan 26, 2015 at 06:46:21PM +0100, Leopold Palomo-Avellaneda wrote:
> [1] https://lintian.debian.org/tags/package-modifies-ld.so-search-path.html

Besides, you misread this directive it says:

Packages containing shared libraries should either install them into
/usr/lib or should require binaries built against them to set RPATH
to find the library at run-time.

So, it is permitted not to install libraries under /usr/lib provided
that you encode the RPATH into binaries, and do not rely on the
loader search path.


-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150126/1080b35b/attachment.sig>
