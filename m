Date: Thu, 22 Jan 2015 14:44:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122134400.GA26731@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho> <2296691.2JpS0rAJbA@soho>
 <20150122114038.GE23461@hermes.click-hack.org>
 <4743020.6q5RsBy8Ia@soho> <54C0F262.6010806@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54C0F262.6010806@siemens.com>
Subject: Re: [Xenomai] Xenomai-3 creating debian packages
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Jan 22, 2015 at 01:51:46PM +0100, Jan Kiszka wrote:
> On 2015-01-22 12:59, Leopold Palomo-Avellaneda wrote:
> > El Dijous, 22 de gener de 2015, a les 12:40:38, Gilles Chanteperdrix va 
> > escriure:
> >> On Thu, Jan 22, 2015 at 12:39:10PM +0100, Leopold Palomo-Avellaneda wrote:
> >>> El Dijous, 22 de gener de 2015, a les 12:31:05, Gilles Chanteperdrix va
> >>>
> >>> escriure:
> >>>> On Thu, Jan 22, 2015 at 12:17:15PM +0100, Leopold Palomo-Avellaneda 
> > wrote:
> >>>>> I have renamed the subject according with the theme.
> >>>>>
> >>>>> El Dijous, 22 de gener de 2015, a les 11:48:13, Gilles Chanteperdrix
> >>>>> va
> >>>>>
> >>>>> escriure:
> >>>>>>>> Well, the fact that the compilation error happens when trying to
> >>>>>>>> compile a Xenomai file would seem to indicate that
> >>>>>>>> prepare-kernel.sh
> >>>>>>>> has put the wrong link into init/Kconfig.
> >>>>>>>>
> >>>>>>>> You pass --arch=x86 to prepare-kernel.sh, right, not
> >>>>>>>> --arch=x86_64 ?
> >>>>>>>
> >>>>>>> yes, I have tried both, but I put --arch=x86 or the default option
> >>>>>>> as
> >>>>>>> I
> >>>>>>> said it in my email from yesterday ( :-P)
> >>>>>>
> >>>>>> Well, maybe the default option does not work, so please try
> >>>>>> specifying --arch=x86. The error you have is not in the compiled
> >>>>>> files, but in the Kconfig files. So, the fact that you can compile
> >>>>>> does not really prove that prepare-kernel.sh did not fail.
> >>>>>
> >>>>> Ok, from a clean sources I have run from the linux tree sources:
> >>>>>
> >>>>> $ ../xenomai-3.git/scripts/prepare-kernel.sh --linux=. --
> >>>>> ipipe=../xenomai-3.git/kernel/cobalt/arch/x86/patches/ipipe-core-3.16-
> >>>>> x86-1.patch --arch=x86
> >>>>>
> >>>>>> Now, prepare-kernel.sh adds the scripts/Kconfig.frag file to
> >>>>>
> >>>>>> init/Kconfig. Kconfig.frag contains:
> >>>>> I don't understand that sentence. Yes, the  Kconfig.frag now, contains
> >>>>> this:
> >>>>>
> >>>>> source "arch/$ARCH/xenomai/Kconfig"
> >>>>
> >>>> Ah OK. Could you try to revert that commit ?
> >>>>
> >>>> http://git.xenomai.org/xenomai-3.git/commit/scripts/Kconfig.frag?h=next&
> >>>> id=2 6cc64313e2e695ac227e5a02992c5fe72df2e5f
> >>>
> >>> Gilles, I did it. I explained it before. As I just run the script, I don't
> >>> run any autoconf, so, I then have this part as @LINUX_ARCH@ so it doesn't
> >>> work.
> >>>
> >>> prepare-kernel script doesn't touch (substitute) that.
> >>
> >> prepare-kernel.sh before that commit substitutes @LINUX_ARCH@. You
> >> just need to revert the whole commit.
> > 
> > Ok, the whole commit touch also the prepare-kernel script. I have tested and 
> > now, I got in linux-tree/init/Kconfig:
> > 
> > if XENOMAI
> > source "arch/x86/xenomai/Kconfig"
> > endif
> > 
> > so, I'm sorry Jan, but I think that at least in debian platforms it wasn't a 
> > good change.
> 
> See
> http://git.xenomai.org/xenomai-jki.git/commit/?h=for-forge&id=5d104b1de84c8f4cbfb9d6b79cfaa633ef550e1c
> for the fix. The bug was the improper variable use in the Kconfig
> fragment. You only had to revert the whole commit as you were falling
> back to the obsolete prepare-time patching then, which involved the script.

I do not see what is so obsolete about it. As long as patches are
provided separately for each architecture, the prepare-kernel script
has to know the architecture anyway.

-- 
					    Gilles.

