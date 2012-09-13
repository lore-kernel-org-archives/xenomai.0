Message-ID: <50520907.3080101@siemens.com>
Date: Thu, 13 Sep 2012 18:25:43 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
MIME-Version: 1.0
References: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
	<1347469235-17712-4-git-send-email-wolfgang.mauerer@siemens.com>
	<505180A8.2010100@xenomai.org> <50519D74.1060801@siemens.com>
	<5051AA22.2030107@xenomai.org> <5051D85A.4090105@siemens.com>
	<5051DF0A.7030901@xenomai.org>
In-Reply-To: <5051DF0A.7030901@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 3/3] Fix IRQs-off-tracer for x86_64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 13/09/12 15:26, Gilles Chanteperdrix wrote:
> On 09/13/2012 02:58 PM, Wolfgang Mauerer wrote:
>> On 13/09/12 11:40, Gilles Chanteperdrix wrote:
>>> On 09/13/2012 10:46 AM, Wolfgang Mauerer wrote:
>>>> On 13/09/12 08:43, Gilles Chanteperdrix wrote:
>> 
>> ... (some code with varying amounts of pops and pushed)...
>> 
>>>> that fixes the bug, too -- thanks. However, I deliberately
>>>> spent some extra assembler code (5 insns compared to your
>>>> approach) to make the code easier to  understand (the overall
>>>> size of the resulting kernel binary is identical for both
>>>> approaches on my machine, btw.). Since the overhead of 5
>>>> instructions is negligible compared to the two calls of 
>>>> __ipipe_trace that are necessary in any case, I'd argue that
>>>> the more straightforward code is beneficial in the long run,
>>>> but that's for the maintainers to decide.
>>> 
>>> To the contrary, the profusion of pushq and popq looked
>>> confusing to me, I wondered why so many were needed, so, I
>>> guess it is all a matter of taste.
>> 
>> most certainly a matter of taste, agreed. I've rearranged your 
>> suggestion slightly, added a comment or two, and turned it into
>> a patch.  Repo at https://github.com/siemens/ipipe.git
>> for-upstream is also updated.
> 
> Ok. Small nit:
> 
> +	movq ORIG_RAX+8-RBP(%rsp), %rdi # IRQ number... notq %rdi			#
> ...is inverted, fix up +	leaq RIP-8+8-RBP(%rsp), %rbp    # Show
> interrupted address in trace
> 
> I would avoid to use a register as a source in an instruction
> right after an instruction where it was used as a destination,
> because I believe in processors which do not have out of order
> execution, such as Intel Atoms, the processor would have to wait
> for an instruction to be finished to start the next. Though I do
> not know enough of the x86 architecture to know if that is true.
> That is the reason why I put leaq before notq.

thanks for the suggestion. Indeed even on a 2.7GHz Xeon where all CPU
trickery is available, the assembler instruction reordering gives a
speed-up of about 0.35ns, so one cycle. However, for any
application with such extreme performance needs, tracing would be
turned off anyway, wouldn't it? For debugging purposes, it does make no
difference whatsoever, so I'd argue that code clarity is the more
valuable optimisation goal in this case.

Best regards, Wolfgang

