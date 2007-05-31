Message-ID: <465ED94F.2010300@domain.hid>
Date: Thu, 31 May 2007 16:18:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
	<465ECE5A.8080809@domain.hid>
In-Reply-To: <465ECE5A.8080809@domain.hid>
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
>>Hi,
>>
>>I'm still blocked on a CPU affinity problem.
>>In order to adapt a set affinity function which is based on
>>posix linux lib :
>>- CPU_AssignPID(uint32 PID, uint32 CPU_id)
>>- the cpu affinity of the caller and all its child threads must be set to CPU_id.
>>
>>Problems are:
>>Child PIDs must be listed, the only means I found is listing pids using `ls /proc/"Parent pid"/ > temp_file`
>>And each listed pid is sched_setaffinity'ed.
>>I don't know if setting affinity of RT threads from an other thread (parent) using pid works with xenomai.
> 
> 
> It works in so far as the Xenomai thread will not change its CPU until
> it enters secondary mode. Moreover, there is no explicit "hey, RT thread
> x, go to CPU #n!" under the POSIX skin. Migration always go through
> secondary mode.

Let's repeat it, rephrased, once again: what works with Linux regarding
CPU affinity also works with Xenomai.

-- 
                                                 Gilles Chanteperdrix

