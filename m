Message-ID: <4AF15AE1.9040402@domain.hid>
Date: Wed, 04 Nov 2009 11:43:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <985eb86f0911030429i5c419a6ak8f6e1f2a43250819@domain.hid>	
	<985eb86f0911030815t68e7bf14i14ab0d7374c8ce5a@domain.hid>	
	<4AF1545D.4060207@domain.hid>
	<985eb86f0911040238w2497849et58282e8b7840d60e@domain.hid>
In-Reply-To: <985eb86f0911040238w2497849et58282e8b7840d60e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai-core] Fwd: How to fix static priority
 to processes known in advance
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: tarek ben ali <tarekbenali@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

tarek ben ali wrote:
> Thanks for your reply,
> Can I do this with /sched_setscheduler/()
> <http://www.opengroup.org/onlinepubs/000095399/functions/sched_setscheduler.html>
> function by indicates the pid of the process that I want to set its
> priority?
> 
sched_setscheduler() allows to set the priority of an existing process.
sched_setscheduler() does not set the priorities of Xenomai threads.

Anyway, when running Xenomai, you usually want to give a high priority
only to some particular threads. See:

http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__posix__sched.html
-- 
                                          Gilles


