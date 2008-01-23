Message-ID: <2ff1a98a0801230212v181f5417xdb2d9d603e8494e0@domain.hid>
Date: Wed, 23 Jan 2008 11:12:32 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390801230120k1412d9acvce5ebdf11b72eb0b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390801230120k1412d9acvce5ebdf11b72eb0b@domain.hid>
Subject: Re: [Xenomai-core] TASK SCHEDULING E PRIORITY
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Jan 23, 2008 10:20 AM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> i'm testing xenomai but i have a problem:
>
> i try to run 2 TASKS with the same PRIORITY that never exit out of the cycle
> ( down there is the code of task )
> and never SLEEP

This will not work. Xenomai relies on Linux, so Xenomai tasks must let
Linux run from time to time.

but i see with the oscilloscope that the second task never
> execute.
>
> I set also round robin mode for the task, with rt_task_set_mode( 0,T_RRB,0
> ), and xnpod_activate_rr( LATCH ) kernel side.
>
> Which is the problem for you ?

If you use Xenomai in one-shot mode, round-robin is not implemented.
You have to switch Xenomai timer to periodic mode.

-- 
                                               Gilles Chanteperdrix

