Date: Tue, 22 Sep 2015 00:17:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150921221716.GC28220@hermes.click-hack.org>
References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
 <20150921185425.GH15616@csclub.uwaterloo.ca>
 <20150921194151.GA28220@hermes.click-hack.org>
 <20150921220004.GK15616@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150921220004.GK15616@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: vibnwis <vibnwis@gmail.com>, xenomai@xenomai.org

On Mon, Sep 21, 2015 at 06:00:04PM -0400, Lennart Sorensen wrote:
> On Mon, Sep 21, 2015 at 09:41:51PM +0200, Gilles Chanteperdrix wrote:
> > The alternatives are:
> > - the devtmpfs filesystem, which requires no further tools installed
> > - the mdev tool on systems based on busybox.
> > 
> > Well, in fact, with devtmpfs, I do not even see any reason to have
> > udev.
> 
> Isn't devtmpfs the predecesor to udev that died?  Or was that devfs or
> something else.  I can't remember, it was years ago.
> 
> Hmm, I must be thinking of devfs.  Yeah devtmpfs is even appears to be
> required by udev these days and does much of the work already it seems.
> 
> Not much left for udev to do with devtmpfs around it seems.

udev still allows executing actions such as running scripts,
changing modes. Like auto-mounting USB keys.

-- 
					    Gilles.
https://click-hack.org

