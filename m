From: Jan Kiszka <jan.kiszka@siemens.com>
References: <a59535aa-62e7-7b74-c334-92b72d674558@siemens.com>
Message-ID: <0a6f7577-441c-04f5-6e86-6e600c3ef93f@siemens.com>
Date: Mon, 16 Jul 2018 16:20:50 +0200
MIME-Version: 1.0
In-Reply-To: <a59535aa-62e7-7b74-c334-92b72d674558@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] pthread_setschedparam(invalid_thread)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 2018-07-13 19:48, Jan Kiszka wrote:
> Hi all,
> 
> this pattern causes a kernel crash:
> 
> int main()
> {
> 	struct sched_param schedpar;
> 
> 	schedpar.sched_priority = 1;
> 	pthread_setschedparam(pthread_self(), SCHED_FIFO, &schedpar);
> 	pthread_setschedparam(0x1234, SCHED_FIFO, &schedpar);
> 	return 0;
> }
> 
> The second, invalid setschedparam makes the core try to shadow the
> current thread - which is already shadowed - and that fails and then
> causes a failure in the error cleanup path. But one after the other.
> 
> The semantic of pthread_setschedparam(unknown_remote_thread) should be
> to just invoke the plain glibc function for that thread. But right now
> the core's pthread_setschedparam_ex has no chance to tell a request to
> promote the current thread to a shadow apart from a request on an
> unknown (or invalid) remote thread ID. We would need to extend the
> syscall ABI for that, I'm afraid (pass down pthread_self() as well). Any
> better ideas?

Turned out that there is simple, ABI-compatible solution: pass NULL as
u_winoff in case the target thread ID is not one of the caller.
Preparing patches, ...

> 
> The actual crash I'm seeing is related to cobalt_thread_shadow() running
> over primary mode, failing with cobalt_map_user() (obviously), and then
> calling pthread_discard() -> __xnthread_discard() which finally detects
> the wrong caller mode. I guess we want secondary_mode_only() also in
> cobalt_map_user() or cobalt_thread_shadow().
> 

...also to harden the kernel against that issue.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

