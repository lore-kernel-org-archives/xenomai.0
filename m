Message-ID: <4FDB8A07.7080303@xenomai.org>
Date: Fri, 15 Jun 2012 21:16:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAvA3H-J-RudJ43bDTu0PfgWZ5mx5Hp7QUq_TizrZ+7NLBBzww@mail.gmail.com>
In-Reply-To: <CAAvA3H-J-RudJ43bDTu0PfgWZ5mx5Hp7QUq_TizrZ+7NLBBzww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] pre-fault Xenomai thread stacks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Weber <jwamsc@gmail.com>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On 06/15/2012 09:12 PM, Jeff Weber wrote:
> I occasionally run across net lore which recommends "pre-faulting" a stack.
>  For example:
> https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#A_Realtime_.22Hello_World.22_Example
> 
> From my understanding of mlockall(MCL_CURRENT|MCL_FUTURE), all process
> memory is paged and locked in.  Thus, a pre-faulting exercise appears
> useless.
> (I don't care about the main() thread.)  Can you confirm?

Last time I checked, only the main thread stack was grown on demand, so
required pre-faulting the stack, which is why xenomai takes care of
pre-faulting the main thread stack.

To verify this, you have to check /proc/self/maps. If the thread stack
belongs to a mapping of a size you would not expect, try writing below
the limit, to see if you get a fault, or if the mapping grows in
/proc/self/maps.

-- 
                                                                Gilles.

