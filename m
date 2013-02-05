Message-ID: <5110E324.8040401@xenomai.org>
Date: Tue, 05 Feb 2013 11:47:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20130205102325.GA25004@Mail.Phantasia.org>
In-Reply-To: <20130205102325.GA25004@Mail.Phantasia.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Behavior of rt_heap_bind
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Jung <woju@Phantasia.org>
Cc: Xenomai@xenomai.org

On 02/05/2013 11:23 AM, Wolfgang Jung wrote:
> Hi,
>
> while doing some tests with memory heap servives I encountered the following:
> a) documentation for rt_heap_bind() states "User-space task (switches to
>     primary mode)" which is actually switching from primary-mode to
>     secondary-mode.
> Reference:
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__heap.html
>

The documentation always mentions switches to the domain opposite to the 
calling context. In that case, the regular calling context is linux. 
But, that call does switch to primary mode automatically as well, since 
the caller might block (Xenomai-wise) until the target heap appears, if 
it was not present at the time of the call.

Only the first switch to primary mode is mentioned by the documentation, 
because the opposite switch is only a fixup to get back to the "natural" 
mode for this call.

> b) rt_heap_bind() also switches silently from primary-mode to secondary-mode
>     (SIGXPU will not be raised by rt_heap_bind() ) .
>
> As far as I understand, mapping of memory needs to be done in secondary-mode.
> Is there some major reason why a mode transition is done without raising
> SIGXPU in __rt_heap_bind() (syscall.c:2648 (Release 2.6.2.1) ?
> (it is done silently at __rt_queue_bind as well)

As mentioned above, this is because such relaxing switch is a fixup 
triggered by Xenomai internally to revert the effect of calling a mode 
conforming syscall, i.e. a syscall that switches the caller to primary 
mode on entry, if this is a real-time shadow thread.

Since rt_heap_bind() requires running in secondary mode for a while by 
design, there would be no point in raising a debug notification upon 
migration to secondary mode.

-- 
Philippe.

