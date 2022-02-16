Message-ID: <feefe610-fa4c-b49c-a8db-39cdeb3329a6@siemens.com>
Date: Wed, 16 Feb 2022 22:07:15 +0100
MIME-Version: 1.0
Subject: Re: Weird nanosleep behaviour while debugging after toolchain change
Content-Language: en-US
References: <d00-620c0d00-9-12ac4c80@203449265>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <d00-620c0d00-9-12ac4c80@203449265>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 15.02.22 21:28, François Legal via Xenomai wrote:
> Hello,
> 
> using xenomai 3.1/linux 4.4 on arm, I'm facing a weird issue with gdb debugging.
> I was previously using a croostool-ng generated toolchain, and had to switch to a yocto generated one.
> 
> The same application/kernel/xenomai user land being used, when I run the application through the debugger, the calls to nanosleep in my RT thread seem to block indefinitely unless I single step through the code. Placing a break right after a nanosleep and continuing will not trigger the break.
> 
> I don't know what to do to chase this.
> 
> While the thread is in nanosleep, I can see this in /proc/xenomai/sched :
> CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
>   0  1666   rt     cobalt     60   839ms140us    w          Thread a (sem_timedwaiting. Timeout changes each time I display threads)
>   0  1667   rt     cobalt     62   -                        s          Thread b (nanosleeping)
> 
> CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
>   0  1666   6          42         50         0     00248046    0.0  Thread a 
>   0  1667   4          96         95         0     00640040    0.0  Thread b
> 
> Can anybody help ?

In such weird cases, the general recommendation is to run a system trace
in parallel (trace-cmd record ...) and check what actually happens
scheduling wise. That can also reveal if the expected syscalls are
actually being issued.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

