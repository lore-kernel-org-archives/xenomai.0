Date: Wed, 10 Mar 2021 12:31:30 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [IMPORTANT] gitlab relocation / rename
Message-ID: <20210310123130.0ec40ac3@md1za8fc.ad001.siemens.net>
In-Reply-To: <1083829.1615363008@gemini.denx.de>
References: <621240.1614155458@gemini.denx.de>
 <781641.1614525295@gemini.denx.de>
 <20210308083457.76db0c20@md1za8fc.ad001.siemens.net>
 <1083829.1615363008@gemini.denx.de>
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
To: Wolfgang Denk <wd@denx.de>
Cc: Wolfgang Denk via Xenomai <xenomai@xenomai.org>, u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de, Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>

Am Wed, 10 Mar 2021 08:56:48 +0100
schrieb Wolfgang Denk <wd@denx.de>:

> Dear Henning,
> 
> In message <20210308083457.76db0c20@md1za8fc.ad001.siemens.net> you
> wrote:
> >
> > I do not understand why this is not just gitlab (proper) or github.
> > I hope this discussion was held with the communities of the affected
> > projects involved. While being disruptive i would suggest for
> > Xenomai to move away from denx. For the git side of the operations.
> > To be more open and welcoming to users/contributers etc.  
> 
> Are you positively sure that moving to any otherhosting environment
> will have any positive effect on how the Xenomai community works?

I am not sure. But i would be willing to give it a try. Sitting on a
platform that is open to everyone means we might see "stars",
"fork-relationships" etc. We might have to close issues and MRs with
ever repeating ... "please use ML". But at that point you are already
talking to someone who used the easy collaboration effects to
drive-by/random interact. And chances are high you get them onto the ML,
we see this in other projects where we keep PRs and issues enabled even
though we do not "use them". 

> We use the very same setup for U-Boot as well, which has a _much_
> bigger and _much_ more active community.  We have regular releases
> every 3 months, and most releases include commits from >200
> developers from >30 employers.  And the CI setup for U-Boot is in no
> respect (number of supported architectures / processors / boards /
> tool chains) less challenging than what you do in Xenomai, on
> contrary.  Not to mention the development rate - U-Boot sees > 20
> commits per day in mainline.

Xenomai does not have such a strong community, a point that needs to
improve. Putting it on a social coding platform (probably in addition),
where people can socialize could help. In a private gitlab social
interaction is pretty limited, especially with a strict bouncer
rejecting people that are invited to the party ;).

CI/CT needs mean a hoster is more than a storage of code, and also
means that more stakeholders need access. Many public hosters give
compute+storage away for free. Plus free code-coverage, style checking
with commercial tools ... Good stuff. Stuff that any project can
benefit from, just put a "mirror fork" on github, no offense to the
main hoster ... they can stay.

> Sorry, but I don't buy your "more open and welcoming to users/contri-
> buters" comment.  THe existing environment has proven to work fine
> for a FOSS community project.

Maybe you know now.

regards,
Henning 

> Best regards,
> 
> Wolfgang Denk
> 


