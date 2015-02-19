Date: Thu, 19 Feb 2015 15:46:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150219144624.GW30317@hermes.click-hack.org>
References: <54E4E166.5030701@siemens.com>
 <20150218190549.GI30317@hermes.click-hack.org>
 <54E4E546.8080801@siemens.com>
 <20150218192712.GJ30317@hermes.click-hack.org>
 <54E4FAF4.7050004@siemens.com>
 <20150218210012.GP30317@hermes.click-hack.org>
 <54E503FD.6030804@siemens.com> <54E5F3EE.6050406@siemens.com>
 <20150219144007.GV30317@hermes.click-hack.org>
 <54E5F68F.7050404@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E5F68F.7050404@siemens.com>
Subject: Re: [Xenomai] [PATCH] arm/ipipe: Fix logical inversion in
	ret_from_exception
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

On Thu, Feb 19, 2015 at 03:43:27PM +0100, Jan Kiszka wrote:
> On 2015-02-19 15:40, Gilles Chanteperdrix wrote:
> > On Thu, Feb 19, 2015 at 03:32:14PM +0100, Jan Kiszka wrote:
> >> On return from exception, we want to check if the current context is
> >> root or head to take the fast exit in the latter case. TIP_HEAD is set
> >> then, thus we have to check for 'ne' (Z==0) after tst.
> >>
> >> This affects only non-legacy users.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>
> >> This is for 3.14, but it should equally well apply to 3.16. Fixes both
> >> sigdebug test as well as the weird sshd deaths on the virtual vexpress
> >> target.
> >>
> >>  arch/arm/kernel/entry-armv.S | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> >> index a608340..f6ef839 100644
> >> --- a/arch/arm/kernel/entry-armv.S
> >> +++ b/arch/arm/kernel/entry-armv.S
> >> @@ -736,8 +736,8 @@ ENTRY(ret_from_exception)
> >>  	get_thread_info tsk
> >>  	ldr	r0, [tsk, #TI_IPIPE]
> >>  	tst	r0, #_TIP_HEAD
> >> - THUMB(	it eq)
> >> -	beq	__ipipe_ret_to_user_irqs_disabled  @ Fast exit path over non-root domains
> >> + THUMB(	it ne)
> >> +	bne	__ipipe_ret_to_user_irqs_disabled  @ Fast exit path
> >> over non-root domains
> > 
> > Mmm. Looks suspicious. The semantics of the PSR flags with tst is
> > contrary to to what one would believe. No, from compiling a small
> > example, it would seem you are right.
> 
> It took me a while to confirm this as well: 'tst' is 'and' without
> writeback. "val & FLAG" gives non-zero if FLAG is set in val. Non-zero
> (Z==0) is tested by 'ne'.
> 
> On x86, there are these nice jnz/jz aliases for that purpose.

My check is:

int f(int x)
{
	if (x & 1)
		return 42;
	
	return -123;
}

Which gives:
00000000 <f>:
   0:   e3100001        tst     r0, #1
   4:   03e0007a        mvneq   r0, #122        ; 0x7a
   8:   13a0002a        movne   r0, #42 ; 0x2a
   c:   e12fff1e        bx      lr

I am almost sure I did something similar before wrting the assembly,
well, I screwed up, sorry.

-- 
					    Gilles.

