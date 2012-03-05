Message-ID: <4F551B9B.6060300@domain.hid>
Date: Mon, 05 Mar 2012 21:01:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADAaWNUQbHDzUMb6F3SP8qgxJbq5Yc58=OT8psFiDXUcCd=Dzg@domain.hid>
In-Reply-To: <CADAaWNUQbHDzUMb6F3SP8qgxJbq5Yc58=OT8psFiDXUcCd=Dzg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Difference between threads and tasks in Xenomai:
 -reg
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: SUBRAMANIAN NATESAN <yenyes88@domain.hid>
Cc: xenomai@xenomai.org

On 03/05/2012 08:55 PM, SUBRAMANIAN NATESAN wrote:
> Hi,
> 
> What is the difference between the threads and tasks in Xenomai. Tasks are
> defined in skins and threads in kernel. rt_task_info and xnthread_info
> structures have the similar variables, which have information regarding
> corresponding task or thread.
> 
> Also, during context switch, whether thread control block or task control
> block is used? Where would be the program counter and all the necessary
> details stored?

task is just the usual name for threads, in the context of RTOSes.
Legacy RTOSes and native skin speak about tasks whereas the posix skin
speaks about thread, but that is the only difference.

-- 
                                                                Gilles.

