Message-ID: <48E4F8DD.9010600@domain.hid>
Date: Thu, 02 Oct 2008 18:37:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E4EE00.5080409@domain.hid> <48E4EE52.2000202@domain.hid>
	<48E4F172.3000400@domain.hid> <48E4F276.7040001@domain.hid>
	<48E4F46A.5060504@domain.hid> <48E4F730.9000109@domain.hid>
In-Reply-To: <48E4F730.9000109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_set_priority vs. Linux priority
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> So we should warn the user (in the doc) that rt_task_set_priority will
>> leave an inconsistent priority distribution between Linux and Xenomai
>> behind? But what is that propagation path in xnpod_renice_thread_inner
>> good for then?
>>
> 
> A failed attempt that used to work before the glibc folks decided to cache the
> priority level of threads locally. With the NPTL, it's useless and error-prone.

I think linuxthreads already did the caching. So, in fact, it probably
never really worked.

But what is funny is that glibc people have (or had) problems with that
caching too: when you passed priorities to pthread_create, whereas the
kernel used the correct priority, the user-space was not aware of this
priority, so pthread_getschedparam did not return the correct priority.
Which is probably the reason why we need to call pthread_setschedparam
in Xenomai libraries thread trampolines.

-- 
                                                 Gilles.

