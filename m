Date: Mon, 24 Jun 2019 13:18:58 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: Preview: 4.19-x86 support
Message-ID: <20190624131858.41860152@md1za8fc.ad001.siemens.net>
In-Reply-To: <7b7ff8c9-0faa-2a9b-5347-ee5361a978d0@siemens.com>
References: <4a035faa-d1f8-d2ed-9351-192cea2d79eb@siemens.com>
 <20190621180432.483ea4a0@md1za8fc.ad001.siemens.net>
 <7b7ff8c9-0faa-2a9b-5347-ee5361a978d0@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Am Mon, 24 Jun 2019 08:32:24 +0200
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 21.06.19 18:04, Henning Schild via Xenomai wrote:
> > Hi Jan,
> > 
> > works fine. The only thing that did not was the gdb smokey test.
> >   
> >> FAILURE run_gdb:288: checking expression "primary_mode", expected
> >> "$", found "N"  
> > 
> > did not look into where this came from.  
> 
> OK, didn't see that so far. Did you only see this on 4.19 so far, ie.
> did you test 4.14 or older with master recently?

Switches from stable to master for just this one, so can not tell.

> > 
> > Tested todays master but think the 4.19 changes should be
> > backported to stable as well.  
> 
> I'm not planning for that due to the number of changes involved. 3.1
> will come out "soon", and that is for newer kernels.

Ok.

> > 
> > I also ran into an smb issue from upstream, which is fixed there.
> > So i think this should be rebased on latest 4.19 eventually. Or
> > leave it on 33 and merge for the first release.  
> 
> Which one exactly?

37, but is there anything from preventing 55?

Henning

> Thanks,
> Jan
> 
> > 
> > Henning
> > 
> > Am Tue, 18 Jun 2019 18:37:14 +0200
> > schrieb Jan Kiszka via Xenomai <xenomai@xenomai.org>:
> >   
> >> Hi all,
> >>
> >> @all early adopters: There is a first version of upcoming x86
> >> support based on the 4.19 kernel available at [1]. You need
> >> Xenomai master for it. The kernel should boot and run Xenomai
> >> workload fine - at least it does here so far. I only see one
> >> lockdep splat during early boot that needs to be sorted out.
> >> Possibly just an instrumentation issue, not a real problem. For
> >> the first release, cleaning up the series and adding latest 4.19
> >> support are on my to-do list.
> >>
> >> Early test reports appreciated!
> >>
> >> Jan
> >>
> >> [1]
> >> https://gitlab.denx.de/Xenomai/ipipe-x86/commits/wip/ipipe-x86-4.19.y
> >>  
> > 
> > 
> >   
> 


