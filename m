From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 Nov 2015 11:19:02 -0500
Message-ID: <20151105161902.GO21923@csclub.uwaterloo.ca>
References: <20151105015114.GJ21923@csclub.uwaterloo.ca>
 <20151105110141.GC16314@hermes.click-hack.org>
 <20151105145159.GK21923@csclub.uwaterloo.ca>
 <20151105145725.GL21923@csclub.uwaterloo.ca>
 <20151105150226.GM21923@csclub.uwaterloo.ca>
 <20151105151544.GD16314@hermes.click-hack.org>
 <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105155549.GE16314@hermes.click-hack.org>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 04:55:49PM +0100, Gilles Chanteperdrix wrote:
> As I said, that depends on the contents of the /proc file described
> in Documentation/arm/mem_alignment
> 
> If that file is configured to fixup faults in kernel, then every
> alignment fault in user-space triggers a trap, the trap handler
> simulates the faulting instruction and returns to user-space. If you
> do that from a Xenomai task running in primary mode, it should cause
> the task to switch to secondary mode, unless there is a bug in the
> I-pipe patch regarding that particular issue (like a fault not
> transmitted to Xenomai).

Well I tried changing that setting to 0 (ignore) and that just crashed
the system instead.

> Xenomai does not change the type of the RAM memory, the H_DMA flag
> only has an effect on heaps created with Xenomai shared user/kernel
> heaps interface. Xenomai only use that flag automatically on arm
> machines with VIVT cache. armv7 do not have VIVT cache as far as I
> know.

Hmm, not sure.

It does appear that when LPAE is enabled H_DMA does do something on arm,
but only when LPAE is enabled since that enables ZONE_DMA.

-- 
Len Sorensen

