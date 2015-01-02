Date: Fri, 2 Jan 2015 23:17:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150102221711.GD11990@daedalus>
References: <54A6DE57.6020900@xenomai.org> <54A6DED7.1010900@web.de>
 <54A6EF96.9040607@xenomai.org> <54A6EE3B.3070909@web.de>
 <54A6F202.3080307@xenomai.org> <54A6F14F.7080601@web.de>
 <54A6F79E.4010602@xenomai.org> <54A6F65F.5010405@web.de>
 <54A6FD20.5020601@xenomai.org> <54A71623.8090906@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54A71623.8090906@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] registry daemon mangement (was: Re: [Xenomai-git]
 Philippe Gerum: copperplate: add configuration tunable for registry moint
 point)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Jan 02, 2015 at 11:05:23PM +0100, Jan Kiszka wrote:
> On 2015-01-02 21:18, Philippe Gerum wrote:
> > I understand you are looking for a killer argument to make your point
> > about changing /mnt to /var/run, which seems to imply now that you would
> > want the entire registry to be rewritten, for the sake of making your
> > argument fly.
> 
> This is clearly over-interpreting my point. Gilles brought up the topic
> of mulit-user scenarios, and that made me think about mount-point
> unrelated aspects of the daemon. I renamed the thread therefore.

I brought the topic of people using Xenomai as non root user, the
point I was trying to make is that using /var/run/xenomai was not
much of an improvement compared to using /mnt/xenomai. I think I was
the one to bring FHS as well, so, that is two mistakes for me.

I do not think multi-user scenarios are that problematic either: who
has several untrusted users on the system using xenomai anyway? As
has been said multiple times already, xenomai has never been audited
for security, so, if you do not trust your users, you should not let
them run xenomai applications.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 173 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150102/ab3023ce/attachment.sig>
