Message-ID: <465584FB.1010107@domain.hid>
Date: Thu, 24 May 2007 14:28:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C8@domain.hid>
	<4655800A.30506@domain.hid>
In-Reply-To: <4655800A.30506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "RAKOTOSALAMA,
	Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>

Jan Kiszka wrote:
> RAKOTOSALAMA, Nirilanto wrote:
> 
>>Thanks Jan,
>>
>>It's more and more clear.
>>Just a question, I've a little doubt. Native tasks do not inherit
>>affinity from their parent process. I've read that cpu affinity 
>>setting at pthread creation is only availablle in kernel space.
>>Do Posix skin threads inherit affinity from their parent, in user space?
> 
> 
> IIRC, pthread CPU affinity is not (yet) covered by the POSIX specs, thus
> the behaviour depends on Linux here. Moreover,
> pthread_attr_setaffinity_np support for Xenomai is infeasible due to
> glibc compatibility issues - again: IIRC. Gilles, please correct my weak
> memory on this topic.

Recent versions of glibc have pthread_attr_setaffinity_np as well as
pthread_setaffinity_np. Implementing pthread_attr_setaffinity_np would
mean that we change the pthread_attr_t structure, whereas we currently
use glibc pthread_attr_t, but implementing pthread_setaffinity_np would
be feasible. However, you can use whatever service glibc provides, it
should work with Xenomai.

The only advantage of Xenomai nucleus migration service
(xnpod_migrate_thread) over Linux service (set_cpus_allowed), is that
xnpod_migrate_thread migrates the thread timers as well.

-- 
                                                 Gilles Chanteperdrix

