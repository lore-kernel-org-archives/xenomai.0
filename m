References: <81447d4fbbd44e3ca473502b0755813a@advaoptical.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0f1a1752-d76c-70ec-516e-3dac3ec3d223@siemens.com>
Date: Mon, 4 Jun 2018 12:16:16 +0200
MIME-Version: 1.0
In-Reply-To: <81447d4fbbd44e3ca473502b0755813a@advaoptical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2018-06-04 10:24, Sagi Maimon wrote:
> Hi all,
> Going over the xenomai documentation and code there is something I can't quite understand.
> 
> As far as I understand :
> One of the xenomai/nucleus tasks is INIT task, this task triggers the Linux kernel scheduler when no other xenomai task needs the CPU time.

I suppose that refers to what is called the ROOT task: A Xenomai task
which represents the whole Linux kernel on a particular core to the
Xenomai scheduler. It runs with lowest priority, as Xenomai idle task.

> In the RPI system when a xenomai task migrate to secondary domain (Linux), the INIT task gets the migrating task priority.
> That way xenomai preserve the priority scheme consistent across both schedulers.

This likely refers to the priority inheritance feature for that ROOT
task in case a Xenomai task migrated to Linux mode. This features was
obsoleted and removed, ignore any related descriptions in older documents.

> 
> But what about Linux timer interrupt?
> In case of Linux timer interrupt, ADOS/xenomai will pass interrupt to Linux handling which during scheduler_tick() will invoke the Linux scheduler.
> In this case a Linux process can get precedence over a xenomai task, how can it be?

Let's look at the simple case first: The timer interrupt is exclusively
used by Linux. In that case, I-pipe will recognize the hardware
interrupt when it arrives, but that interrupt will only be replayed in a
virtualized way for Linux when we switch to that ROOT task, i.e. when
there is no Xenomai RT task runnable at this point. There is no explicit
kicking of the Linux scheduler here, that is done by Linux itself after
running that delayed timer interrupt handler.

It's a bit more complex when the timer is shared by Linux and Xenomai.
In that case, the Linux timer event is abstracted by Xenomai software
timer that uses the shared hardware timer. If that software timer
expired, Xenomai will pend a virtual timer interrupt for Linux and let
that one handle when switching to Linux the next time - just like in the
above case.

Hope that helps to clarify the picture.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

