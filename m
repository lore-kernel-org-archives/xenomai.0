MIME-Version: 1.0
In-Reply-To: <CADXNiGUNiEC9MaOWTc3UBCNaBMRp2SHbbJ4dsq379QpToBvGcw@mail.gmail.com>
References: <CADXNiGUNiEC9MaOWTc3UBCNaBMRp2SHbbJ4dsq379QpToBvGcw@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 1 Aug 2018 14:14:01 -0400
Message-ID: <CALLqZ8RDELtvuNtKWXJyQ2Sr4zUPOu3ZFeE0Wd0HAAyhHrxWAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] System Lockup while idle
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Jul 30, 2018 at 3:05 PM, Jackson Jones <jackson.jones@gmail.com> wrote:
> We have an app running Xenomai 3.0.7 on an i.MX6 quad-core processor.  We
> are using processor affinity to have different tasks bound to different
> cores.
>
> When the app runs on the target and is idle it will freeze the entire
> system after about 8 hours. If we enable these options it no longer locks
> up and runs for days.
>
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
>
> If we run without using processor affinity (all RT tasks will be on the
> same core),  the system will not lock up either.
>
>
> We are passing in xenomai.supported_cpus=0x0000000f on the command line. I
> noticed the irq-affinity test program assumes at least one non-real time
> cpu. Could having all 4 cores in the RT set be causing the lockups? Should
> we leave one core out of the RT group?
>
> Thanks,
>
> Jackson Jones
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

I don't think having all four cores in the RT set would be causing the
lockup.  If you don't pass xenomai.supported_cpus=0x0000000f what
happens?  I just started looking into this area of Cobalt (someone
correct me if I'm wrong), by default all cores are included in the set
of realtime cpus.  How are you setting the processor affinity?

