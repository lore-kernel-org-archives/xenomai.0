From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 25 Apr 2016 13:08:00 -0400
Message-ID: <20160425170800.GJ11630@csclub.uwaterloo.ca>
References: <CAJ2oMh+Bp4iFpVSN0M+SvyL9WerjxJOgMWq-JEc2_AZvbvGdPg@mail.gmail.com>
 <20160418134509.GW11630@csclub.uwaterloo.ca>
 <CAJ2oMhJEuYiJ40xw4+dL5WYS9oPVfF21eh=wcWSwQXLzn35pdQ@mail.gmail.com>
 <20160418135438.GX11630@csclub.uwaterloo.ca>
 <CAJ2oMh+edAyPTNzwq0HNFDO9Y-ZFn=_BZvJ0-zdB-8NQCBPHDg@mail.gmail.com>
 <CAJ2oMhLrcs104KGKAKx4Z1XWpwLKaVQBn6cZRP4EOLoVXtZJNw@mail.gmail.com>
 <20160418143032.GZ11630@csclub.uwaterloo.ca>
 <CAJ2oMh+vab29mm8xhMc=3KT=2mG2cO=opi5jtJtTkc_wFugU3A@mail.gmail.com>
 <20160425143644.GI11630@csclub.uwaterloo.ca>
 <CAJ2oMhK+xcdxtkXY+1koTvnmXVVHFDBFzPWO3xGXq9KBmsTdnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhK+xcdxtkXY+1koTvnmXVVHFDBFzPWO3xGXq9KBmsTdnA@mail.gmail.com>
Subject: Re: [Xenomai] kernel 3.12
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Apr 25, 2016 at 07:38:45PM +0300, Ran Shalit wrote:
> Hi Len,
> 
> We've first tried to apply the patch for 3.12.0 but there were too many errors,
> so we eventually used
> http://git.xenomai.org/ipipe-gch.git/log/?h=raw/for-ipipe-3.12.0
> latest commit.
> I hope the ipipe should work without any issues wuth this tree.
> Is there a way to check if ipipe is OK with our version based on this commit ?

Well try it.  switch-test and latency and such that come with xenomai
are a start.  Pretty sure the documentation covers those.

-- 
Len Sorensen

