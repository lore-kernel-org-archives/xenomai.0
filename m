Message-ID: <53594599.3050204@xenomai.org>
Date: Thu, 24 Apr 2014 19:10:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1WdMf6-0003VG-Mu@sd-51317.dedibox.fr>
 <53593F7F.5000106@xenomai.org>
In-Reply-To: <53593F7F.5000106@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Instrument
 syscalls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 04/24/2014 06:44 PM, Gilles Chanteperdrix wrote:
>> +    ),
>> +    TP_printk("nfds=%d in=%lx... out=%lx... exc=%lx..."
>> +          " timeout(%s)=%ld.%09ld", __entry->nfds, __entry->in_fds,
>> +          __entry->out_fds, __entry->exc_fds,
>> +          __timespec_used(timeout), __timespec_args(timeout))
>> +);
>> +#endif
>
> Do we really have to add all that dead code?
>

Jan is just handing over the tracepoint stuff for the POSIX layer to me 
with this commit, I'll pick what is needed when merging this code on top 
the instrumentation I recently did for the cobalt core (see -next branch).

This already makes my life much easier to have all the event classes and 
trace helpers readily available for the syscalls. Thanks for this.

-- 
Philippe.

