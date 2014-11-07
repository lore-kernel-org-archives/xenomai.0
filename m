Date: Fri, 7 Nov 2014 17:43:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141107164322.GC11524@sisyphus.hd.free.fr>
References: <46e9aebbd25e45f8a3bb4732562bb97f@SI-MBX1019.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e9aebbd25e45f8a3bb4732562bb97f@SI-MBX1019.de.bosch.com>
Subject: Re: [Xenomai] Perf makes kernel panic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Ren Yuan (DC-IA/EAN3)" <Yuan.Ren@boschrexroth.nl>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 07, 2014 at 04:28:57PM +0000, Ren Yuan (DC-IA/EAN3) wrote:
> Hi,
> 
> I've encountered a problem to use perf to get the performance of
> our code on Linux kernel(3.14) with Xenomai(2.6.4) on ARM based
> board.

Depending on what you want to measure, do not expect precise
measurements with Xenomai running.

> When I use perf on Linux kernel with Xenomai, even a simple test without any xenomai tasks running reports an error "Unable to handle kernel NULL pointer dereference at virtual address 00000000".
> But if use perf on Linux kernel without Xenomai, it works.

The question is: is the configuration exactly the same in the two
cases, only has xenomai disabled.

> Could anyone give me some advices how to fix it? Any help would be appreciated.

Well, debug this like you would debug any oops, disassemble vmlinux
at address 0xc001371c at look at what is there, use addr2line to see
to what line of code corresponds to the bug, then try and understand
what happens. The oops gives you all the registers values, and the
whole call stack, this should make the job easy.

-- 
					    Gilles.

