Date: Thu, 22 Jan 2015 11:48:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122104813.GA23461@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho> <1592000.mUrPdiXucy@soho>
 <20150122102455.GC20360@hermes.click-hack.org>
 <5878976.hoeVIdWPhU@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5878976.hoeVIdWPhU@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3 booting problems
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

On Thu, Jan 22, 2015 at 11:40:57AM +0100, Leopold Palomo-Avellaneda wrote:
> El Dijous, 22 de gener de 2015, a les 11:24:55, Gilles Chanteperdrix va 
> escriure:
> > On Thu, Jan 22, 2015 at 11:17:41AM +0100, Leopold Palomo-Avellaneda wrote:
> > > El Dijous, 22 de gener de 2015, a les 10:56:35, Gilles Chanteperdrix va
> > > 
> > > escriure:
> > > > > > What about the ARCH problem with make-kpkg, is it solved ?
> > > > > 
> > > > > As I said yesterday [1], there's a question of the ARCH var, used in
> > > > > the
> > > > > prepare-kernel script.
> > > > 
> > > > No, yesterday you said that the prepare-kernel script probably was
> > > > not the problem
> > > 
> > > I said a lot of things yesterday :-D and yes, I thought that probably it
> > > wasn't.
> > > 
> > > > because you can compile the prepared kernel
> > > > manually. Or did I misunderstand?
> > > 
> > > Yes, it's true. I can compile the kernel manually but I can create the
> > > debian package if I modify the result obtained by the prepare-kernel
> > > script.> 
> > > > > Any idea to solve this?
> > > > 
> > > > As I already said, you have to execute what make-kpkg does, by hand,
> > > > step by step, to understand which step goes wrong.
> > > :
> > > :-D
> > > 
> > > It's no easy, at least by my, check why make-kpkg does. But, I think that
> > > there's a collision with that var (ARCH). I think that debian use that var
> > > for some internal proposes and it's different (in the x86 platform x86 vs
> > > x86_64), or has some troubles.
> > > 
> > > Really I don't know if it's a mix of prepare-kernel problem, make-kpkg
> > > problem or user problem.
> > 
> > As you said, if you can compile the prepared kernel manually, it is
> > not a prepare-kernel problem.
> > 
> > > If you see clearly that it's make-kpkg problem, I concentrate my efforts
> > > on
> > > that.
> > 
> > Well, the fact that the compilation error happens when trying to
> > compile a Xenomai file would seem to indicate that prepare-kernel.sh
> > has put the wrong link into init/Kconfig.
> > 
> > You pass --arch=x86 to prepare-kernel.sh, right, not --arch=x86_64 ?
> 
> yes, I have tried both, but I put --arch=x86 or the default option as I said 
> it in my email from yesterday ( :-P)

Well, maybe the default option does not work, so please try
specifying --arch=x86. The error you have is not in the compiled
files, but in the Kconfig files. So, the fact that you can compile
does not really prove that prepare-kernel.sh did not fail.

Now, prepare-kernel.sh adds the scripts/Kconfig.frag file to
init/Kconfig. Kconfig.frag contains:

source "arch/@LINUX_ARCH@/xenomai/Kconfig"

With @LINUX_ARCH@ being substituted by prepare-kernel.sh. Could you
check init/Kconfig to see by what @LINUX_ARCH@ has been substituted
in your case?

If it is x86_64, then it is clearly wrong. It should be x86.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150122/c8a05a43/attachment.sig>
