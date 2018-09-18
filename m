Date: Tue, 18 Sep 2018 16:49:32 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180918164932.79d3c86d@md1pvb1c.ad001.siemens.net>
In-Reply-To: <CAFLxGvxpLybt_mQckAjtcRsY9jMrfT1x4KsQWrZwZR2SeYm9Kg@mail.gmail.com>
References: <CAFLxGvwW583A2NoHKEETzGju13PXqSMmQ2uxSbAsBa7sRFumvQ@mail.gmail.com>
 <25809e31-567f-18fb-8ef2-a32eee4baba2@siemens.com>
 <CAFLxGvxpLybt_mQckAjtcRsY9jMrfT1x4KsQWrZwZR2SeYm9Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe for 4.14 x86?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org

Am Tue, 18 Sep 2018 10:52:05 +0200
schrieb Richard Weinberger <richard.weinberger@gmail.com>:

> Jan,
> 
> On Mon, Sep 17, 2018 at 8:10 PM Jan Kiszka <jan.kiszka@siemens.com>
> wrote:
> >
> > On 17.09.18 15:39, Richard Weinberger wrote:  
> > > Hi!
> > >
> > > Are there plans to have an x86 ipipe for kernel 4.14?
> > > If there is something missing or needs testing I'm all open to
> > > help! 
> >
> > Henning and Philippe are on this, and there is progress as Henning
> > just reported today to me. Maybe just a matter of days, and then we
> > indeed need intensive testing by the community!  
> 
> Is this repo/branch the right one when I want to give ipipe x86 a try?
> Maybe I can help fixing issues too!
> https://gitlab.denx.de/Xenomai/ipipe-x86/tree/wip/4.14-split
> 

This one contains a few more fixes.

https://gitlab.denx.de/Xenomai/ipipe-x86/tree/henning/wip/4.14-split

Both are mainly tested under KVM. The 16 core Xeon i am currently
testing on runs into some timer init issues and gets stuck at boot.

Feedback welcome!

Henning

