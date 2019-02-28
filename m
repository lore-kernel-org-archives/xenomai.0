MIME-Version: 1.0
References: <CA+K1mPFRVPqD_Gg2_7_PqcpegJ+ADJm3hea2AHxiHzwwBBG_iw@mail.gmail.com>
 <3d5044db-0b5c-fe4a-480c-b50943d440e5@siemens.com>
In-Reply-To: <3d5044db-0b5c-fe4a-480c-b50943d440e5@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 27 Feb 2019 21:56:02 -0800
Message-ID: <CA+K1mPEfLdrvGOqnX+1F6omFQq-CT75v2-5qTXF8Rj8NY=mHrQ@mail.gmail.com>
Subject: Re: Periodic timing varies across boots
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Mon, Feb 25, 2019 at 12:09 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 24.02.19 07:57, C Smith via Xenomai wrote:
> > I am using Xenomai 2.6.5, x86 32bit SMP kernel 3.18.20, Intel Core
> > i5-4460,  and I have found a periodic timing problem on one particular
> type
> > of motherboard.
> >
> > I have a Xenomai RT periodic task which outputs a pulse to the PC
> parallel
> > port, and this pulse is measured on a frequency counter. This has been
> > working fine for years on several motherboards. I am able to adjust the
> > period of my task to within +/-10nsec, according to the frequency
> counter.
> > I can calibrate the periodic timing down to a period +/-10nsec on this
> > motherboard, and I cna restart my xenomai process many times and the
> timing
> > is fine. But if I cold-reboot the machine the measured period is wrong =
by
> > up to  +/-300nsec. Thus I cannot get consistent periodic timing from da=
y
> to
> > day without recalibrating, which is unacceptable in my application.
> >
> > In my kernel config, I am using the TSC: CONFIG_X86_TSC=3Dy
> > I use rt_timer_read() to determine what time it is, and my periodic tas=
k
> > sleeps in a while loop, like this:
> >        next +=3D period_ns + adjust_ns;
> >        rt_task_sleep_until(next);
> >
> > I don't know what to test. Can you suggest anything?
> St=C3=A9phane Ancelot said:
> Your problem seems being related to SMI interrupts rising.
> According to your chipset , Program xenomai  kernel SMI registers in
> boot options ,  in order to avoid this problem.
> Regards,
> S.Ancelot
>


> Can you reproduce the issue with a supported Xenomai and kernel version?
>
> Jan
>
>
We have tens of thousands of legacy code so I must use Xenomai 2.6.5 - we
will endeavor to got to Xenomai 3.x next year.
Per your suggestion I could try writing a stripped-down periodic app and
booting into Xenomai 3 for a test though... I'll do that soon and let you
know how it goes.
I doubt there is anything wrong with Xenomai 2.6.5 though. My periodic
timing worked fine with 3 other motherboards and this same
Xeno kernel, but I must use this motherboard because of its form factor
(and we spent months qualifying it).

First, I am exploring what Stephane A. said above, where he suspects SMI
interference.
I did try adding xeno_hal.smi=3D1 to my kernel boot options, but I get this
in dmesg at boot:
  Xenomai: SMI-enabled chipset found
  Xenomai: SMI workaround failed!
So I guess I can't solve the problem that way.
My periodic timing is not fixed by this attempt either.
Note that during boot I see: "CPU0: Thermal monitoring handled by SMI"

I also ran the 'latency' regression test and it does not show large
latencies, they are <=3D 2.6 usec.
* Does that indicate SMI is not interrupting my process?
* Is there anything I should disable in the BIOS or kernel, like ACPI ?
