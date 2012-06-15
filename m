MIME-Version: 1.0
Sender: madjsw@gmail.com
Date: Fri, 15 Jun 2012 14:12:05 -0500
Message-ID: <CAAvA3H-J-RudJ43bDTu0PfgWZ5mx5Hp7QUq_TizrZ+7NLBBzww@mail.gmail.com>
From: Jeff Weber <jwamsc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] pre-fault Xenomai thread stacks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

I occasionally run across net lore which recommends "pre-faulting" a stack.
 For example:
https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#A_Realtime_.22Hello_World.22_Example

>From my understanding of mlockall(MCL_CURRENT|MCL_FUTURE), all process
memory is paged and locked in.  Thus, a pre-faulting exercise appears
useless.
(I don't care about the main() thread.)  Can you confirm?

thanks,
Jeff
