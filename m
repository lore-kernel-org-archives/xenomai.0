Message-ID: <51A39043.5010609@xenomai.org>
Date: Mon, 27 May 2013 18:56:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51A30F04.701@xenomai.org>
In-Reply-To: <51A30F04.701@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] git://git.xenomai.org/ipipe.git reshuffle,
	3.8.0 kernel support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 05/27/2013 09:45 AM, Philippe Gerum wrote:
>
> The I-pipe tree at git://git.xenomai.org/ipipe.git will be reorganized
> today at 3pm GMT. At this chance, support for the 3.8.0 kernel will be
> introduced.
>
> The complete commit history will be preserved, along with existing tags.
> Branches may be renamed though, to better reflect the new development
> workflow introduced with the pipeline "core" series.
>
> If you have scripts pulling from this repository in any automated way,
> you may want to stop them for the day.
>
> A description of the few changes involved will be sent to this mailing
> list later today, shortly before the new repository is published.
>

The reshuffled repository is now on line.

The changes are as follows:

- all legacy pipeline branches (i.e. pre-"core" series) have moved under 
the legacy/ hierarchy, e.g.
ipipe-2.6.20-powerpc => legacy/ipipe-2.6.20-powerpc
All branches under legacy/ are frozen, and won't be updated anymore.

- the master branch now reflects the state of the mainline I-pipe 
development. Pull from this branch for the latest validated commits, for 
the latest supported kernel.

- new ipipe-<kernel.version> branches are started off master 
periodically, for maintaining the pipeline over stable kernel releases. 
These branches include the pipeline code for a given kernel release, for 
a set of architectures we support in this release. There is neither 
arch-specific nor -noarch branches anymore.

The former core-<kernel.version> branches are now available as 
legacy/core-<kernel.version>, with ipipe-<stable-kernel-version> 
reflecting the latest stable fixes that were merged into those branches. 
For instance, the former core-3.4 branch can be found as both 
legacy/core-3.4, and ipipe-3.4.6 in the reorganized repository.

- The new ipipe-next branch contains brewing stuff, possibly not fully 
validated on all supported architectures yet. It receives new features 
on their way to master, and arch-specific merges. Unlike other branches, 
ipipe-next may be subject to rebase, prior to merging it into master.

Practically, people who depend on a particular stable kernel version 
should track the corresponding ipipe-<kernel.version> branch.

People working over the bleeding edge tip should rebase over ipipe-next 
periodically.

People who want reasonably validated stuff for the latest kernel release 
we support should track master.

HTH,

-- 
Philippe.

