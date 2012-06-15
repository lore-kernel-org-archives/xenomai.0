Message-ID: <4FDB8E52.6000005@xenomai.org>
Date: Fri, 15 Jun 2012 21:34:42 +0200
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

Note that in order to pre-fault a stack, you do not need to memset the
whole stack, you can only write a few bytes per stack page.

-- 
                                                                Gilles.

