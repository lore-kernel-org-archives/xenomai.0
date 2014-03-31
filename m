Message-ID: <53395E62.4070005@xenomai.org>
Date: Mon, 31 Mar 2014 14:24:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5338834B.5090604@steinkuehler.net> <53388F8A.6030403@xenomai.org>
 <533894D3.8090803@steinkuehler.net> <533951A9.5060307@xenomai.org>
 <CAN1+YZXRk1abosuhKawqxS=FwuLj1anjZb8Ezt4F9224WNzAzQ@mail.gmail.com>
In-Reply-To: <CAN1+YZXRk1abosuhKawqxS=FwuLj1anjZb8Ezt4F9224WNzAzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Dedicated Core?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Pugh <andy@bodgesoc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/31/2014 02:19 PM, Andy Pugh wrote:
> On 31 March 2014 12:29, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>
>> In the end, Andrey succeeded to have precise control by using timers,
>> in kernel-space, instead of threads in user-space, and a little trick:
>> waking up early and spinning waiting for the target time.
>
> LinuxCNC is rather tightly wedded to the thread model. The PWM /
> Stepgen / Encoder modules already exist and are in use on many
> machines.
> It is possible to run LinuxCNC with Xenomai in both kernel mode and
> user mode, but for reasons that I am not clear on the conclusion has
> been that user mode is preferable.
> (This may not be the same distinction as you are making).
>
I do not advocate putting everything in kernel-space, like in the old 
days. What I mean is that the user/kernel interface, should act as an 
"hardware abstraction layer". So, for instance, for a PWM, the interface 
between driver and application should be ioctl(s) to pass period and 
duty cycle. The driver should take care of the low-level details of 
toggling the GPIO for the given period and duty cycle, and the 
application should only call the ioctls when it wants to change the 
period or duty cycle.

-- 
					    Gilles.

