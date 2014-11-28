From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 28 Nov 2014 11:13:10 -0500
Message-ID: <20141128161310.GR24110@csclub.uwaterloo.ca>
References: <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
 <20141127231527.GC24076@hermes> <5478430B.9030602@siemens.com>
 <20141128095038.GA3832@hermes> <547846AC.6070204@siemens.com>
 <20141128095745.GB3832@hermes> <5478618F.1010506@siemens.com>
 <20141128115537.GB6395@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141128115537.GB6395@hermes>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Fri, Nov 28, 2014 at 12:55:37PM +0100, Gilles Chanteperdrix wrote:
> Again, using /mnt/xenomai does not break any distribution following
> the standard.

Yes it does when I mount my disk on /mnt.  xenomai is hidden.

> Let us try things another way, the possibilities we have are:
> - /mnt/xenomai: a solution that used to be standard but ceased to be
> with the FHS which did not provide a standard replacement, but does
> not break any distribution

As above, it does.

> - /run/xenomai: a solution that relies on the existence on the /run
> directory, which is not standard, but is going to be, maybe.
> - /var/run/xenomai: a solution which does not violate any version of
> the standard, but is not standard either, does not make clear that
> the directory is a mount point (which /mnt does), breaks the
> existing documentation, breaks the existing usages of Xenomai 3, and
> is longer to type.

/ is a mount point too, but the name doesn't imply that either.  That's a
bad argument.

> So, I really find that /mnt/xenomai is the best compromise. There is
> no standard solution, at least /mnt/xenomai is a solution that used
> to be standard.

Well it will break on my system all the time.  It's a very shitty solution
and not a compromise at all.  You are breaking things on my system.

/mnt is for the admin's use only.  No exceptions.

-- 
Len Sorensen

