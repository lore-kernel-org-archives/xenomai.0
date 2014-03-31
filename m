From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 17:53:48 -0400
Message-ID: <20140331215348.GX17765@csclub.uwaterloo.ca>
References: <5339BF3C.8090906@xenomai.org>
 <20140331191849.GR17765@csclub.uwaterloo.ca>
 <20140331193742.GS17765@csclub.uwaterloo.ca>
 <5339C5AC.4040409@xenomai.org>
 <20140331204257.GT17765@csclub.uwaterloo.ca>
 <20140331205339.GU17765@csclub.uwaterloo.ca>
 <20140331205710.GV17765@csclub.uwaterloo.ca>
 <5339D8EB.3030702@xenomai.org>
 <20140331212534.GW17765@csclub.uwaterloo.ca>
 <5339E2CE.7060703@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5339E2CE.7060703@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Mar 31, 2014 at 11:49:02PM +0200, Gilles Chanteperdrix wrote:
> Please post your .config, I will have a look. Please disable unlocked
> context switch as well. Also please note that the context switch has
> been reworked in 3.11, so you need Xenomai 2.6.x from the git repository.

I am using the xenomai-2.6 git tree (current commit I see is as HEAD is
4081e1b032329bf0cc9442f466233d5fc1083fc5).

Doing a git pull I see I am 4 commits behind, and one does sound
interesting.  I will have to update that.

> a.k.a Vayu ?

Yes the circuit board does say VAYU EVM.

> I made quite a few other changes for omap5, I never merged them in the
> I-pipe branch since the port was not finished. You may want to have a
> look at them if you are continuing the work on omap5.

OK I will look at that too.

> I have pushed the omap5-ipipe branch in ipipe-gch with this work in
> progress.

OK, it looked quite promising on initial attemps, so it almost looked
like it might just work.

-- 
Len Sorensen

