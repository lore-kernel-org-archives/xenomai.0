Message-ID: <454200BF.6050009@domain.hid>
Date: Fri, 27 Oct 2006 14:51:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] InterProcessCommunication between Xenomai task
	and	Linux process
References: <5D63919D95F87E4D9D34FF7748CE2C2A5FF8F7@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A5FF8F7@domain.hid>
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> Is there a standard way for communication between nativ Linux processes
> and Xenomai task which ensures that the Xenomai task does not lose its
> raltime capability (e.g. can I use Xenomai (Posix)-queues within Linux
> processes ?).
> I just need a hint, where I can read about it.

Xenomai POSIX messages queues can only be used by Xenomai tasks, but
Xenomai tasks do not switch to secondary mode when using POSIX messages
queues. Note that when using the POSIX skin, all tasks are Xenomai
tasks, the SCHED_OTHER policy being reserved to non-realtime task.

Another solution is to use the native skin message pipe services,
described here:
http://www.xenomai.org/documentation/trunk/html/api/group__pipe.html

-- 
                                                  Gilles Chanteperdrix

