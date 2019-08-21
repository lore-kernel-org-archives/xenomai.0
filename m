Subject: Re: Freeze using Linux function tracer on Xenomai 2.6
References: <CAD5jUk-fwG0SDyn+bDxxgR0=+wTEW7BWi0UDSS5SUy6fcK-Q8Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <19948996-aaf3-694f-0b7e-f37968ee8c8b@siemens.com>
Date: Wed, 21 Aug 2019 19:03:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAD5jUk-fwG0SDyn+bDxxgR0=+wTEW7BWi0UDSS5SUy6fcK-Q8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Radu Rendec <radu.rendec@gmail.com>, xenomai@xenomai.org

On 21.08.19 17:43, Radu Rendec via Xenomai wrote:
> Hi Everyone,
> 
> I know Xenomai 2.6 has been obsolete for a long time now, but I'm stuck
> with a legacy environment that I have to support.
> 
> Having said that, I enabled the Linux function tracer in the kernel
> configuration and I experience a complete system freeze when I try to
> activate it. Basically I'm doing this:
> 
>    mount debugfs /sys/kernel/debug/ -t debugfs
>    echo function > /sys/kernel/debug/tracing/current_tracer
> 
> At that point I get a freeze. The system eventually reboots, but after
> 10 minutes or so - even though no hardware watchdog is enabled.
> 
> I'm running Xenomai 2.6.5 on Linux 3.2.102, on a PowerPC e300 (Freescale
> MPC8378). Only Busybox init, sshd and a Busybox shell are running at the
> time this happens.
> 
> Can anyone think of any reason why this might happen or how I can figure
> out what goes wrong?

I never hacked on ppc, but I would bet that ftrace & Co. was never hardened 
there for use under Xenomai. Then, it may work for some time by luck and later 
crash randomly.

Maybe the ipipe tracer worked there.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

