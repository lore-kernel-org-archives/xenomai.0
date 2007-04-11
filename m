Message-ID: <b647ffbd0704110115w24af6f11o618cf50ff74baf18@domain.hid>
Date: Wed, 11 Apr 2007 10:15:20 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <20070410224715.132860@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070328203115.190280@domain.hid> <20070329031758.125210@domain.hid>
	<460B7CE0.60107@domain.hid> <20070403200539.126240@domain.hid>
	<1175631875.22950.72.camel@domain.hid> <20070403205554.107880@domain.hid>
	<1175674653.4666.9.camel@domain.hid> <20070404151057.177770@domain.hid>
	<1175798337.7594.56.camel@domain.hid> <20070410224715.132860@domain.hid>
Subject: Re: [Xenomai-help] Preemptive scheduling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jack Whorn <jackwhorn@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 11/04/07, Jack Whorn <jackwhorn@domain.hid> wrote:
> [...]
> As far as I have seen, Xenomai`s watchdog kills the currently running task when >wd_count (which is increased every second) has reached 4. But when is wd_count >reset? I have only seen wd_count being reset to zero whenever Linux is scheduled. I >don`t understand how this can be sufficient (which obviously is!), as I had expected it >being reset whenever *any* task is rescheduled. How can the system know that it is >the currently running task that has prevented Linux from being scheduled?
>

The comment in xnpod_watchdog_handler() is a bit misleading.

The idea is to avoid starvation of the linux kernel for more than 4
seconds, right. But this starvation can be well done either by one rt
task or a few which are running one by one. The watchdog will kill the
one that happens to run at 4-th second.

e.g. 2 tasks : task1 takes 3.98 s. and then task2 - just 0.05 second.
The watchdog handler will shoot task2, although the real problem is
task1.

Nevertheless, for the majority of cases, this problem happens when
some rt task is misbehaving (say, an endless loop under some
circumstances) and - the one that gets killed - is the one that
monopolise the CPU indeed.


-- 
Best regards,
Dmitry Adamushko

