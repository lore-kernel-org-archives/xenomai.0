Message-ID: <2ff1a98a0801280622v63480a1cwd2cabd204369abed@domain.hid>
Date: Mon, 28 Jan 2008 15:22:36 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390801280610k7298eae0tfd626e574b8cccff@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390801280134l6073203fr3cee621b34321301@domain.hid>
	<18333.52494.176360.871342@domain.hid>
	<d3f72a390801280610k7298eae0tfd626e574b8cccff@domain.hid>
Subject: Re: [Xenomai-core] RESCHEDULE TASK
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

On Jan 28, 2008 3:10 PM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> thanks for the response but all that i want to know is a general answer:

Next netiquette lesson: when you reply a mail, please quote the part
of the mails that were relevant and to which you were replying, and
ask your questions under these quotes.

>
> what does the periodic timer do respect oneshot timer ? ( i understand that
> xenomai scheduler can't stop realtime task in execution ).

Your understanding is wrong: Xenomai scheduler can stop real-time task
in execution, as any preemptive scheduler can.

The issue you faced is the fact that round-robin scheduling is
unimplemented if the system timer is set to one-shot mode. But
round-robin scheduling works if the system timer is set to periodic
mode.

But round-robin scheduling only works with tasks belonging to the same
priority group, so it will not help Linux to run. And letting Linux
run is mandatory if you want your system to run correctly.

So, you have to suspend from time to time, and the best way to do this
is to implement your system as an event driven system.

>
> I think that periodic timer has the chance to run other task with the same
> priority even if the task is working ( for example a sum like this a = a + 1
> + sin( a );)

Computations unrelated to any inputs or outputs make little sense. If
you relate computations to event-driven inputs and outputs, your
system will let Linux run automatically.

-- 
                                               Gilles Chanteperdrix

