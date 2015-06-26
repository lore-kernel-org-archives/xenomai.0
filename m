Date: Fri, 26 Jun 2015 14:44:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150626124430.GC23673@hermes.click-hack.org>
References: <2634889.oyRnRNCYxl@soho>
 <20150625205607.GA23673@hermes.click-hack.org>
 <1922926.QGJ4YRI68g@indiana>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1922926.QGJ4YRI68g@indiana>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian package of Xenomai 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Thu, Jun 25, 2015 at 11:10:32PM +0200, Leopold Palomo-Avellaneda wrote:
> El Dijous, 25 de juny de 2015, a les 22:56:08, Gilles Chanteperdrix va 
> escriure:
> > On Thu, Jun 25, 2015 at 01:43:51PM +0200, Leopold Palomo-Avellaneda wrote:
> > > - I have removed the previous debian patches (incorporated by upstream)
> > > but I have added one commit from upstream to build with 2.6.4 kernels =>
> > > 3.11.
> > Would be interested to know about this patch, because Xenomai 2.6.4
> > has been built-tested with kernels up to 3.14, so, there is no
> > problem to build it with versions superior to 3.11 that I know of.
> 
> Gilles,
> 
> on 2014-09-25 you released 2.6.4.
> 
> on 2015-01-16 you did a commit (can/flexcan: fixup for kernel release >= 3.11) 
> that is the one that I noticed.
> 
> However, looking now the log there are two commits that will affect on arm 
> platforms:
> 2014-11-24	hal/arm: fixup for Linux 3.16	
> 2014-11-05	hal: fixups for kernel 3.16
> 
> So, probably I will need them too.
> 
> All this patches came after the official released 2.6.4.
> 
> Personally, I would love a 2.6.5 with all the fixes ...

2.6.5 will probably happen, but not before the work on 3.0 is finished.

-- 
					    Gilles.
https://click-hack.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150626/b18ced63/attachment.sig>
