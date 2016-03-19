References: <E1ahDS5-0004G9-QW@sd-51317.xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56ED227B.2040309@siemens.com>
Date: Sat, 19 Mar 2016 10:57:15 +0100
MIME-Version: 1.0
In-Reply-To: <E1ahDS5-0004G9-QW@sd-51317.xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Philippe Gerum : cobalt/thread: add schedparam lazy
	propagation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2016-03-19 10:45, git repository hosting wrote:
> Module: xenomai-3
> Branch: next
> Commit: 4eee0136b4bcb744b9dfdc195f18dd839b3e2198
> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=4eee0136b4bcb744b9dfdc195f18dd839b3e2198
> 
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Fri Mar 18 12:12:50 2016 +0100
> 
> cobalt/thread: add schedparam lazy propagation
> 
> Provide a mechanism for carrying out a lazy propagation of schedparam
> updates to the regular kernel, so that userland does not have to
> switch to secondary mode for this.
> 
> When userland issues sc_cobalt_thread_setschedparam_ex for updating
> the scheduling parameters of a Xenomai thread, a request for
> propagating this change to the regular kernel is made pending. Such
> request will be committed later, either when:
> 
> - the thread relaxes if it is running in primary mode when the update
>   request is received;
> 
> - next time the thread calls back into the Cobalt core as a result of
>   receiving a HOME action from a SIGSHADOW notification, which is sent
>   if such thread was relaxed at the time of the update request.
> 
> As a result, the target thread will have propagated the schedparams
> update to the regular kernel as soon as it resumes (relaxed) execution
> in user-space.

More light-weight than my approach with the kernel helper task - but
doesn't this create a prio inversion window on the Linux side?

Consider a relaxed thread that received a prio raising while in primary
mode. It will now start off with its old, lower Linux prio in secondary
mode, potentially being starved by a higher prio Linux task because it
cannot update its own priority.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

