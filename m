Date: Wed, 24 Feb 2021 12:35:11 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [I-PIPE] ipipe-core-4.19.165-cip41-arm64-09 released
Message-ID: <20210224123511.529fe032@md1za8fc.ad001.siemens.net>
In-Reply-To: <20210224112455.56da9faf@md1za8fc.ad001.siemens.net>
References: <E1l9itV-000402-99@xenomai.org>
 <7c43aa40-9754-2529-8bc7-7df8c7124a96@siemens.com>
 <126b2b25b43ff4acbc3e5ffb902239e69fc67bfe.camel@siemens.com>
 <bddc49db-2dbd-af33-1ebe-473bcf403e91@siemens.com>
 <20210224112455.56da9faf@md1za8fc.ad001.siemens.net>
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
To: Henning Schild via Xenomai <xenomai@xenomai.org>

Am Wed, 24 Feb 2021 11:24:55 +0100
schrieb Henning Schild via Xenomai <xenomai@xenomai.org>:

> Am Wed, 10 Feb 2021 12:08:43 +0100
> schrieb Jan Kiszka via Xenomai <xenomai@xenomai.org>:
> 
> > On 10.02.21 11:07, Bezdeka, Florian (T RDA IOT SES-DE) wrote:  
> > > On Wed, 2021-02-10 at 09:15 +0100, Jan Kiszka via Xenomai wrote:
> > >   
> > >> On 10.02.21 07:22, xenomai--- via Xenomai wrote:    
> > >>> Download URL:
> > >>> https://xenomai.org/downloads/ipipe/v4.x/arm64/ipipe-core-4.19.165-cip41-arm64-09.patch
> > >>>
> > >>> Repository: https://git.xenomai.org/ipipe-arm64
> > >>> Release tag: ipipe-core-4.19.165-cip41-arm64-09
> > >>>    
> > >>
> > >> Hmm, now we have the 5.4-arm64 issue also on 4.19:
> > >> https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/219984
> > >>    
> > > 
> > > I don't know much about the things going on here, but found this
> > > line in the log. Maybe a starting point...
> > > 
> > > 2021-02-10T07:51:47 setsched.c:120, assertion failed: stats.msw ==
> > > msw   
> > 
> > Exactly, that is causing the overall failure. And it was first seen
> > with the newly added 5.4 kernel.  
> 
> Seing the same on amd64 when testing on qemu, real HW is fine.
> 
> Managed to bisect it down to 4.19.147-cip (good) 4.19.150-cip (bad)
> 
> Which also means that ipipe-core-4.19.152-cip37-x86-15 is affected.
> 
> https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/200646
> did not find it, so maybe our config differs

Digging further i found 0f0b6099c45ff3e06d2487816cf1ff30d21835f6 likely
causing the problem.

ipipe-core-4.19.152-cip37-x86-15 <- bad
revert 2b294ac325c7ce3f36854b74d0d1d89dc1d1d8b8
revert 8579a0440381353e0a71dd6a4d4371be8457eac4 <- bad
revert 0f0b6099c45ff3e06d2487816cf1ff30d <- good

I think here Jan or Phillipe should take over.

Henning

> Henning
> 
> > Jan
> >   
> > >     
> > >> Guess we need to understand this next now, specifically as it
> > >> "spreads".
> > >>
> > >> Jan
> > >>    
> > >     
> >   
> 
> 


