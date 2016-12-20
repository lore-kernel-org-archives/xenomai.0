Date: Tue, 20 Dec 2016 09:36:32 -0500
Message-ID: <20161220143632.GC17365@csclub.uwaterloo.ca>
References: <a9bb92d8-5e99-7afe-4381-7fad371632d0@smile.fr>
 <21e6332e-1acf-d53e-3ad5-543ff548a3a5@xenomai.org>
 <f0e3a9e8-4120-5076-e812-550d7ff4007f@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e3a9e8-4120-5076-e812-550d7ff4007f@smile.fr>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] __COBALT_SYSCALL_BIT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Stephan <julien.stephan@smile.fr>
Cc: xenomai@xenomai.org

On Tue, Dec 20, 2016 at 01:36:44PM +0100, Julien Stephan wrote:
> I'm porting Xenomai on the MPPA processor of Kalray. The problem is that
> their Linux port is quite new and is not yet publicly available ...

Well that would easily be fixed if someone with the GPL code decided to
share it.  The license clearly says you can and that no other restrictions
are allowed to be impossed on the code.

I had never heard of this one before, although looking at their website,
I don't have much hope.  I don't think we need another architecture, which
means yet another architecture to support in the kernel, glibc, gcc, not
to mention all the stupid runtimes that need architecture specific code
(hard enough to get those to support existing popular architectures).
And when I see VLIW for a general purpose CPU, I can only think "doomed".
It never worked before, and I don't believe it ever will.  But maybe
they don't actually mean VLIW in the traditional sense.  Or maybe it is
just intel that can't make it work.

The design looks an awful lot like the tilera tile chips, which are also
lots of cores in a big mesh with lots of fast IO and VLIW.  Not sure
they have had much success yet.

Well we will see what happens.

-- 
Len Sorensen

