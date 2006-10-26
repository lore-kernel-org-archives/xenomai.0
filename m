Message-ID: <4540DACA.2050406@domain.hid>
Date: Thu, 26 Oct 2006 17:56:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
	<453FF6AA.6030406@domain.hid> <45406FEF.90806@domain.hid>
	<4540D998.2090908@domain.hid>
In-Reply-To: <4540D998.2090908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

Jeff Webb wrote:
> Gilles Chanteperdrix wrote:
> 
>> After the first Ctrl-C that does not work, could you try and attach gdb
>> to see where the threads are stopped ?
> 
> 
> I tried to do this, but was unable to determine the stopping point using 
> gdb.

type simply: "info threads"
then change thread to the main thread with "thread x", where x is the 
lowest thread id as listed by "info threads"
then type: "backtrace"

> 
>> Are you using NPTL or Linuxthreads ? 
> 
> 
> I'm running a stock Fedora Core 5 configuration, so I think that means 
> NPTL.
> 
>> Could you tell us in what state the
>> switchtest threads are when running ps and in /proc/xenomai/sched ?
>> After the second Ctrl-C, are the threads still alive ?
> 
> 
> See the output below.

/proc/xenomai/sched gives an information on the status that is easier to
understand.

-- 
                                                  Gilles Chanteperdrix

