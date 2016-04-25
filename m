Date: Mon, 25 Apr 2016 22:23:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160425202341.GI1881@hermes.click-hack.org>
References: <20160418135438.GX11630@csclub.uwaterloo.ca>
 <CAJ2oMh+edAyPTNzwq0HNFDO9Y-ZFn=_BZvJ0-zdB-8NQCBPHDg@mail.gmail.com>
 <CAJ2oMhLrcs104KGKAKx4Z1XWpwLKaVQBn6cZRP4EOLoVXtZJNw@mail.gmail.com>
 <20160418143032.GZ11630@csclub.uwaterloo.ca>
 <CAJ2oMh+vab29mm8xhMc=3KT=2mG2cO=opi5jtJtTkc_wFugU3A@mail.gmail.com>
 <20160425143644.GI11630@csclub.uwaterloo.ca>
 <CAJ2oMhK+xcdxtkXY+1koTvnmXVVHFDBFzPWO3xGXq9KBmsTdnA@mail.gmail.com>
 <20160425195054.GH1881@hermes.click-hack.org>
 <CAJ2oMhKccwbyCsOyi_JN-EybDmdttotajqKh6nK=zz=-Ay33gA@mail.gmail.com>
 <20160425200932.GK11630@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160425200932.GK11630@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] kernel 3.12
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Mon, Apr 25, 2016 at 04:09:32PM -0400, Lennart Sorensen wrote:
> On Mon, Apr 25, 2016 at 11:01:40PM +0300, Ran Shalit wrote:
> > On Mon, Apr 25, 2016 at 10:50 PM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> > > On Mon, Apr 25, 2016 at 07:38:45PM +0300, Ran Shalit wrote:
> > >> On Mon, Apr 25, 2016 at 5:36 PM, Lennart Sorensen
> > >> <lsorense@csclub.uwaterloo.ca> wrote:
> > >> > On Sun, Apr 24, 2016 at 10:21:50AM +0300, Ran Shalit wrote:
> > >> >> We intend to use ipipe with zynq (we already have 3.12.0 kernel used with zynq).
> > >> >> Do you think the patch should be relevant for zynq ?
> > >> >> I see that xilinx have their own patch , but it is for older kernel 2.6.3
> > >> >> http://www.wiki.xilinx.com/Xenomai+for+Zynq#Xenomai for Zynq-7000 AP
> > >> >> SoC Linux--Patch
> 
> Actually that is xenomai 2.6.3 with 3.8 kernel patches.  2.6.4 is the
> latest xenomai 2, while current xenomai is now 3.x (which we have not
> yet moved to but really should at some point).
> 
> The fact it needs pre and post patches for zynq makes me suspect it
> might involve a bit more work, but maybe I am wrong.  I have never had
> to deal with pre and post patches.

pre and post patches allow applying an I-pipe patch to a vendor
kernel. They make it possible for the I-pipe patch to evolve with
little changes to the pre/post patches.

-- 
					    Gilles.
https://click-hack.org

