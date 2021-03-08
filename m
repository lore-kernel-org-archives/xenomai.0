Date: Mon, 8 Mar 2021 08:34:57 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [IMPORTANT] gitlab relocation / rename
Message-ID: <20210308083457.76db0c20@md1za8fc.ad001.siemens.net>
In-Reply-To: <781641.1614525295@gemini.denx.de>
References: <621240.1614155458@gemini.denx.de>
 <781641.1614525295@gemini.denx.de>
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
To: Wolfgang Denk via Xenomai <xenomai@xenomai.org>
Cc: Wolfgang Denk <wd@denx.de>, u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de, Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>

Am Sun, 28 Feb 2021 16:14:55 +0100
schrieb Wolfgang Denk via Xenomai <xenomai@xenomai.org>:

> Hi all,
> 
> In message <621240.1614155458@gemini.denx.de> I wrote:
> >
> > We have to move all public projects off  gitlab.denx.de  to a new
> > gitlab instance; the new host name is then  source.denx.de .
> > We are fully aware that this will cause inconveniences, and I can
> > only assure you that we try hard to keep these as limited as
> > possible.
> >
> > # Details
> >
> > Around noon on Saturday, 2021-02-27, we will freeze all public
> > repositories on gitlab.denx.de.  They will still be readable/
> > cloneable but any attempt to push new commits after this point will
> > fail.
> >
> > We will then copy them over to the now host, source.denx.de .
> > All custodian accounts will also be transferred, the same login
> > credentials from gitlab.denx.de will work on source.denx.de .
> >
> > The URLs for the repositories will stay the same, except of course
> > for the host name.  So, for example, the U-Boot mainline repository
> > will then be hosted at
> >
> >     https://source.denx.de/u-boot/u-boot.git
> >
> > We will install redirects to forward HTTP accesses from the old
> > repository URLs to the new host.  This should make the transition
> > mostly transparent, but does not cover everything.  The following
> > needs to be taken care of manually:
> >
> > - Update the SSH URI for pushing to the repositories.  Just replace
> >   gitlab.denx.de  with  source.denx.de .  We will transfer all the
> >   SSH-keys to the new host so nothing else should be needed.
> >
> > - Make sure you're logging in on  source.denx.de .  Access to
> >   gitlab.denx.de  will no longer work!
> >
> > - CI runners connected to  gitlab.denx.de  need to be re-registered
> >   with  source.denx.de .
> >
> > The new host should hopefully be operational sometime on Sunday,
> > 2021-02-28.  We will send a further announcement once everything is
> > back up and running.  
> 
> As far as we were able to test it, the move has been completed and
> is fully functional again.  All public project are now on the new
> gitlab instance  source.denx.de

One fun side-effect is that pulling via ssh also does not work anymore.
Because it seems account have been fully deleted. This mail did not
make it to my inbox because it was only sent to a list i happen to read
sometimes.
It would have been nice to receive my own copy with me actually in
"To:". Would have saved me a bit of time trying to understand what is
wrong. Luckily i remembered the "New developer accounts on
source.denx.de" mail from last week, where that URL seemed strange when
i first read it.

I do not understand why this is not just gitlab (proper) or github. I
hope this discussion was held with the communities of the affected
projects involved. While being disruptive i would suggest for Xenomai
to move away from denx. For the git side of the operations. To be more
open and welcoming to users/contributers etc.

regards,
Henning

> If you should experience any problems, please do not hesitate to ask 
> Harald Seiler <hws@denx.de>, he will try to help you.
> 
> Thanks for your patience!
> 
> Best regards,
> 
> Wolfgang Denk
> 


