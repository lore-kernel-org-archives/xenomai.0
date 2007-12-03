Message-ID: <2ff1a98a0712030253h6c9e6053q8143777cc37d9cdc@domain.hid>
Date: Mon, 3 Dec 2007 11:53:24 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <7289437c0712030216y5bd7d9f1p6af2a9cd4870d813@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7289437c0712030216y5bd7d9f1p6af2a9cd4870d813@domain.hid>
Subject: Re: [Xenomai-help] RTDM : Event wait
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 3, 2007 11:16 AM, Perrine Martignoni <perrmart@domain.hid> wrote:
> Hi,
>
> I would like to know what mecanism allows to wait events from User-space
> task (RT and non RT). I want to have some User-space Tasks waiting events
> from the kernel.
> I just read that rtdm_event_wait can be called only from RT User-space task.
> Any idea ?

The non real-time task waiting for an event should use one of the
wait_event_* calls defined in linux/wait.h. In order to signal the
event from a real-time task, you will have to post a non real-time
signal (rtdm_nrtsig_pend) that will call one of the wake_up_* calls
(also defined in linux/wait.h).

For an explanation of wait_event*/wake_up* see Linux Device Drivers chapter 6:
http://lwn.net/images/pdf/LDD3/ch06.pdf

-- 
                                               Gilles Chanteperdrix

