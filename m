Message-ID: <508AC728.3070509@xenomai.org>
Date: Fri, 26 Oct 2012 19:23:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1351266099.5784.30.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1351266099.5784.30.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about Adeos I-pipe patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai <xenomai@xenomai.org>

On 10/26/2012 05:41 PM, Wayne Warren wrote:
> I am looking at the ksrc/arch/arm/patches directory in the Xenomai git
> repository for tags v2.6.0 and v2.6.1.
> 
> I notice in v2.6.1 there is an ipipe patch named
> "ipipe-core-3.2.21-arm-1.patch" which differs from the others I have
> seen which start with "adeos-ipipe".
> 
> Since I prefer to pull from the original ipipe tree directly rather than
> applying the patch, does it matter if I choose "ipipe-core" or
> "adeos-ipipe"? I would prefer the latest vanilla kernel version, so if
> you could recommend a head/tag to checkout corresponding to this patch,
> I would appreciate it. Right now I am looking at the "for-ipipe-3.2-arm"
> head.

adeos-ipipe-* are the previous generation of adeos I-pipe patches, they
stop around Linux version 3.0/3.1.

ipipe-core-* are a new incarnation of the adeos I-pipe patches, they
start at Linux version 3.2. The idea is to make the patch simpler by
making the assumption that Xenomai is the only user of the patch, so cut
down on things that were a bit more generic. At this chance we also did
some other refactoring, such as putting in a common place things that
were the-same-but-not-really on all architectures. What also changed is
that there is now one git branch for all the architectures.

the branch for-ipipe-3.2-arm is a branch in
git://git.xenomai.org/ipipe-gch.git
which is the git I use for working on the I-pipe patch. This branch is
merged in the core-3.2 branch in the official I-pipe git repository at:

git://git.denx.de/ipipe.git

The branch core-3.2 is the branch from which the ipipe-core-3.2-*
patches are made.

In the ipipe-gch git, you can also find the for-core-3.4 branch which
contains the current status of my work on the Adeos I-pipe core patched
Linux 3.4. There is currently no pending issue on this branch (and I
plan to backport some of the changes in the for-ipipe-3.2-arm branch).
But to use that branch, you will need to use the master branch from the
xenomai git:

git://git.xenomai.org/xenomai-2.6.git

-- 
					    Gilles.

