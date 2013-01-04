Message-ID: <50E7092E.50109@xenomai.org>
Date: Fri, 04 Jan 2013 17:54:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
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
	<20130104160213.GA14111@localhost.localdomain>
In-Reply-To: <20130104160213.GA14111@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>
Cc: xenomai@xenomai.org

On 01/04/2013 05:02 PM, Richard Cochran wrote:
> I was able to push the beaglebone to the present (v3.8-rc2) state of
> actually booting with Ethernet working only by kicking and screaming
> on the arm list.

IIRC, you also had to kick and scream for ixp4xx fixes, and getting
clock synchronization through IEEE 1588, and no TI maintainer was
involved. So, I may be stating the obvious, but it seems to me that we
you are new to the exercise, getting code merged into mainline is not
that easy, perhaps both because you may not do it the way the known
maintainers/contributors expect you to do it, and because the
maintainers/contributors do not tend to trust someone they do not know.
Most people involved in short term projects simply give up after the
first rejection.

> The real problem there is the TI people who are
> posting the the lists, but fail to follow through, saying things like
> 
>   "it is already working" (but only with their out of tree patches)
> 
> and
> 
>   "we submitted a patch that will appear soon" (but the patch is only
>   on some omap list an not in maintainer tree)

These excuses look a lot like the ones which happen with xenomai between
the time a fix happens in the git tree and a release or between the time
a fix happen in my ipipe git, and is merged in the official ipipe git,
if you get a link to the actual patch, I do not see how else things
could be handled. If the patch is finally merged, this is not really a
problem.

> 
> and
> 
>   "yes, we got driver merged into the tree, but it is not our fault
>   that it doesn't actually work."

we try to avoid that here...

> 
> The TI people are clearly focused on their arago-whatever trees, and
> they are not gettings things done for mainline.

I am afraid the code contained in the arago tree is not entirely
developed by TI people, the people having to maintain it may not be the
ones who wrote it. That may make getting things done for mainline a tad
harder.

> * Post to the arm list. That is the one that counts.

I knew that, I even said it:
http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-February/021979.html

The FCSE patch was certainly posted to the lakml, but someone told me
"you should have sent a mail to rmk as well". What? rmk is not reading
the lakml? Sometimes, the rules for posting to a list (like never
posting a patch for review during the merge window) are a bit hard for
the newcomer, especially when they are of the kind "it is not written
anywhere, it is obvious, everybody knows that".

-- 
					    Gilles.

