Message-ID: <5491BB1B.7020306@xenomai.org>
Date: Wed, 17 Dec 2014 18:19:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5491B5E9.4030200@siemens.com>
In-Reply-To: <5491B5E9.4030200@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday mechanism broken on x86-64 - simpler approach
 feasible?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 12/17/2014 05:57 PM, Jan Kiszka wrote:
> Hi,
> 
> while porting the sigdebug test case to forge I noticed occasional
> crashes of the test after it received a watchdog signal. It turned out
> that the problem is in the way mayday works on x86-64:
> 
> 1. sp/ip/ax of interrupted thread is saved
> 2. ip is set to mayday page
> 3. mayday page executes the mayday syscall via the syscall instruction
> 4. the syscall restores state on original state on return
> 
> That that's the theory. Unfortunately the syscall instructions
> overwrites the cx register with the caller's instruction pointer. We
> could save it but there is no way to restore it on syscall return
> without significant changes to the Linux code in entry_64.S.
> 
> x86-32 is fine as it uses the int80 path which does a full state
> recovery - but that is not available for 64-bit (only via ia32 compat,
> but that can be turned off).
> 
> I was playing with a different approach: Set a flag that mayday is
> underway, let the interrupt context cause a fault (set ip to 0) and then
> fix that up if we are in mayday mode. Seems to work fine (after fixing
> some x86 ipipe issue) and would simplify the mayday logic apparently. So
> I'm wondering why that approach wasn't chosen initially? IOW, what am I
> missing?
> 

The scheme had to work on MMU-less platforms as well, so jump <foobar>
seemed not a reasonable option.

-- 
Philippe.

