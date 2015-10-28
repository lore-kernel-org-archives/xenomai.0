Date: Wed, 28 Oct 2015 11:51:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151028105140.GA26607@hermes.click-hack.org>
References: <1445948476-7587-1-git-send-email-henning.schild@siemens.com>
 <20151027123003.GA4874@hermes.click-hack.org>
 <20151027133540.2f264249@md1em3qc>
 <20151028093313.201c9817@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151028093313.201c9817@md1em3qc>
Subject: Re: [Xenomai] [PATCH] scripts: use mktemp instead of relying on
 TMPDIR beeing in env
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On Wed, Oct 28, 2015 at 09:33:13AM +0100, Henning Schild wrote:
> On Tue, 27 Oct 2015 13:35:40 +0100
> Henning Schild <henning.schild@siemens.com> wrote:
> 
> > On Tue, 27 Oct 2015 13:30:04 +0100
> > Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > 
> > > On Tue, Oct 27, 2015 at 01:21:16PM +0100, Henning Schild wrote:
> > > > The environment variable TMPDIR is optional and not always set. We
> > > > could test for it and fall back to /tmp/ or just use the tool
> > > > mktemp.
> > > 
> > > I am not sure mktemp is available everywhere. What about setting
> > > TMPDIR to /tmp if not set ?
> > 
> > From what i can tell mktemp is more widely available than TMPDIR. My
> > gentoo boxes do not have TMPDIR set and i have used a ubuntu system
> > where it was not set either. mktemp is part of coreutils and even
> > busybox has one.
> > I did not feel too good reimplementing whatever else mktemp does, why
> > reinvent the wheel?
> 
> Please let me know whether i was convincing and the current patch
> version will be merged.

The patch is ok for me minus the use of $() which is used nowhere
else in the script and not strictly necessary (no nesting needed).

-- 
					    Gilles.
https://click-hack.org

