References: <09EA8A4C-D8EB-4470-A339-C2019D1B662B@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55BA500F.8010504@xenomai.org>
Date: Thu, 30 Jul 2015 18:25:51 +0200
MIME-Version: 1.0
In-Reply-To: <09EA8A4C-D8EB-4470-A339-C2019D1B662B@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mutate/start RT_TASK a posix thread?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>, xenomai <xenomai@xenomai.org>

On 07/30/2015 07:26 AM, Michael Haberler wrote:
> we're happily using RT threads using the Xenomai 2 thread API
> 
> is it possible _using this API_ to create/mutate/relax such a thread intentionally into a Posix thread but retaining the API usage?

It is possible to run them as low priority Xenomai threads, assigning
them to the SCHED_OTHER class. The native API is retained for those
threads, but their main runtime mode is relaxed, i.e. the co-kernel
makes sure to switch them back to relaxed mode automatically before
returning to user-space from a syscall which required a switch to
primary mode.

> 
> I can do any conditional API usage through thread parameters to avoid calls which will not work for a relaxed thread, but I would like to retain the API (I guess I could switch to the posix skin but I would like to avoid another learning curve/test cycle for now)
> 
> going forward/Xenomai 3: what would be your recommendation to address the issue long-term? 
>

Xenomai 3 in dual kernel mode extends the feature above, with the
SCHED_WEAK class:
http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Scheduling

> 
> 
> 
> (may sound like whacky question but great use case around here - turns out many jobs do not need RT capabilities but it would be handy to retain the flow)
> 

If I interpreted your question properly, it's definitely a legitimate
use case; sometimes the non-rt stuff may want to interact with the rt
world using Xenomai APIs, but without getting in the way priority-wise.

-- 
Philippe.

