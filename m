Date: Mon, 12 Jan 2015 11:42:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150112104200.GD25855@hermes.click-hack.org>
References: <54A69BFA.7060405@web.de> <54A6A506.3060504@xenomai.org>
 <54A6A387.4010109@web.de> <20150102141625.GD1492@daedalus>
 <20150102150638.GE1492@daedalus> <54A6C072.7020303@web.de>
 <20150103194050.GH12052@daedalus> <54A84E6E.2040501@web.de>
 <20150103222509.GA6409@hermes.click-hack.org>
 <54AD77A0.1010206@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54AD77A0.1010206@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum: copperplate: add
 configuration tunable for registry moint point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Jan 07, 2015 at 07:14:56PM +0100, Jan Kiszka wrote:
> On 2015-01-03 23:25, Gilles Chanteperdrix wrote:
> >>>
> >>> Alternatively (to the last item), the sysregd could be made suid
> >>> root, create the session directory if it does not exist with root
> >>> permissions but with the target user as owner, then drop root
> >>> privileges and continue as a normal user.
> >>
> >> Should work, but unless I stumbled over fundamental issues why sysregd
> >> is not working as normal user right now, I don't see a technical need
> >> for this big hammer for user-managed sessions.
> > 
> > The enormous advantage of using the big hammer (in fact, only if we
> > put the three changes into it), is that it avoids explaining things
> > to the users, and avoids as well questions on the mailing list.
> > Given the number of questions we have had about /dev/rtheap and
> > /dev/rtpipe, this would be a win.
> 
> We actually need the big suid-hammer: only root has the permission to
> clean up the mounts of other users. Obsoletes my fusermount -u patch.

Why does root need to clean up the mounts of other users if each
user cleans up its mounts ?

-- 
					    Gilles.

