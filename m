Date: Fri, 4 Jan 2013 17:02:13 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20130104160213.GA14111@localhost.localdomain>
References: <382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
	<20130103085312.GA8132@localhost.localdomain>
	<5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
	<20130103141552.GB9656@localhost.localdomain>
	<50E5E7D9.7020605@xenomai.org>
	<20130104085019.GA13416@localhost.localdomain>
	<50E6A5CF.7040501@xenomai.org>
	<20130104100435.GA2309@netboy.at.omicron.at>
	<50E6E42C.9040300@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50E6E42C.9040300@xenomai.org>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Jan 04, 2013 at 03:16:12PM +0100, Gilles Chanteperdrix wrote:
> On 01/04/2013 11:04 AM, Richard Cochran wrote:
> > FCSE is a special, esoteric case I think. New drivers are not so hard
> > to get merged, but you are right about the iterations.
> 
> Is it? Still working on that consumer device I have another example of
> patch that never made it to mainline. Maybe simply different communities
> have different goals?
> 
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-January/021885.html
> 
> https://lkml.org/lkml/2011/2/3/43

Looks like this patch didn't go to the arm list, the arm maintainer,
or the soc mainainter, and it probably should have. In any case, if a
patch gets ignored, then it is okay to nag* the gate keepers until
they respond. The squeaky wheel gets the grease, you know.

I was able to push the beaglebone to the present (v3.8-rc2) state of
actually booting with Ethernet working only by kicking and screaming
on the arm list. The real problem there is the TI people who are
posting the the lists, but fail to follow through, saying things like

  "it is already working" (but only with their out of tree patches)

and

  "we submitted a patch that will appear soon" (but the patch is only
  on some omap list an not in maintainer tree)

and

  "yes, we got driver merged into the tree, but it is not our fault
  that it doesn't actually work."

The TI people are clearly focused on their arago-whatever trees, and
they are not gettings things done for mainline.

That is the whole problem.

Thanks,
Richard

* Post to the arm list. That is the one that counts.

