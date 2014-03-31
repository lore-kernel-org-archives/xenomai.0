MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <533951A9.5060307@xenomai.org>
References: <5338834B.5090604@steinkuehler.net> <53388F8A.6030403@xenomai.org>
 <533894D3.8090803@steinkuehler.net> <533951A9.5060307@xenomai.org>
From: Andy Pugh <andy@bodgesoc.org>
Date: Mon, 31 Mar 2014 13:19:21 +0100
Message-ID: <CAN1+YZXRk1abosuhKawqxS=FwuLj1anjZb8Ezt4F9224WNzAzQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Dedicated Core?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 31 March 2014 12:29, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

> In the end, Andrey succeeded to have precise control by using timers,
> in kernel-space, instead of threads in user-space, and a little trick:
> waking up early and spinning waiting for the target time.

LinuxCNC is rather tightly wedded to the thread model. The PWM /
Stepgen / Encoder modules already exist and are in use on many
machines.
It is possible to run LinuxCNC with Xenomai in both kernel mode and
user mode, but for reasons that I am not clear on the conclusion has
been that user mode is preferable.
(This may not be the same distinction as you are making).

-- 
atp

