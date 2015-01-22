Date: Thu, 22 Jan 2015 12:39:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122113932.GD23461@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho> <5878976.hoeVIdWPhU@soho>
 <20150122104813.GA23461@hermes.click-hack.org>
 <1724720.ZWD9XnFxZe@soho>
 <20150122113105.GB23461@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150122113105.GB23461@hermes.click-hack.org>
Subject: Re: [Xenomai] Xenomai-3 creating debian packages (was: Re:
 Xenomai-3 booting problems)
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

On Thu, Jan 22, 2015 at 12:31:05PM +0100, Gilles Chanteperdrix wrote:
> On Thu, Jan 22, 2015 at 12:17:15PM +0100, Leopold Palomo-Avellaneda wrote:
> > I have renamed the subject according with the theme.
> > 
> > El Dijous, 22 de gener de 2015, a les 11:48:13, Gilles Chanteperdrix va 
> > escriure:
> > > > > 
> > > > > Well, the fact that the compilation error happens when trying to
> > > > > compile a Xenomai file would seem to indicate that prepare-kernel.sh
> > > > > has put the wrong link into init/Kconfig.
> > > > > 
> > > > > You pass --arch=x86 to prepare-kernel.sh, right, not --arch=x86_64 ?
> > > > 
> > > > yes, I have tried both, but I put --arch=x86 or the default option as I
> > > > said it in my email from yesterday ( :-P)
> > > 
> > > Well, maybe the default option does not work, so please try
> > > specifying --arch=x86. The error you have is not in the compiled
> > > files, but in the Kconfig files. So, the fact that you can compile
> > > does not really prove that prepare-kernel.sh did not fail.
> > 
> > Ok, from a clean sources I have run from the linux tree sources:
> > 
> > $ ../xenomai-3.git/scripts/prepare-kernel.sh --linux=. --
> > ipipe=../xenomai-3.git/kernel/cobalt/arch/x86/patches/ipipe-core-3.16-
> > x86-1.patch --arch=x86 
> >  
> > > Now, prepare-kernel.sh adds the scripts/Kconfig.frag file to
> > > init/Kconfig. Kconfig.frag contains:
> > 
> > I don't understand that sentence. Yes, the  Kconfig.frag now, contains this:
> > 
> > source "arch/$ARCH/xenomai/Kconfig"
> 
> Ah OK. Could you try to revert that commit ?
> 
> http://git.xenomai.org/xenomai-3.git/commit/scripts/Kconfig.frag?h=next&id=26cc64313e2e695ac227e5a02992c5fe72df2e5f

You need to revert the whole commit, not just the change in
Kconfig.frag. The easy way to do this is to go in Xenomai git tree
and type:

git revert 26cc64313e2e695ac227e5a02992c5fe72df2e5f

Of course, you need to re-run prepare-kernel.sh after that.

-- 
					    Gilles.

