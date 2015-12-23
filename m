References: <56795E20.1010102@isc.cnr.it> <5679E096.3030807@xenomai.org>
 <567A5ED3.505@isc.cnr.it>
From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <567AA8DD.9000202@xenomai.org>
Date: Wed, 23 Dec 2015 08:59:57 -0500
MIME-Version: 1.0
In-Reply-To: <567A5ED3.505@isc.cnr.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Programming Xenomai+analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gianpiero.puccioni@isc.cnr.it
Cc: xenomai@xenomai.org

On 12/23/2015 03:44 AM, GianPiero Puccioni wrote:
> On 23/12/15 00:45, Jorge Ramirez Ortiz wrote:
> 
>>
>> have you tried reading the Xenomai demo code or the analogy utilities?
>> http://git.xenomai.org/xenomai-3.git/tree/utils/analogy
>>
> 
> Yes, of course, but the analogy utils are not written for realtime

what do you mean? do you see mode switches when you run them?
I havent executed them in a while but as far as I remember some of them were.

> (and there
> are some bits missing, for example insn_read does not set the range properly),

could you point me where?

> and the realtime examples are quite obscure for a beginner: only sparse comments
> and no explanation on what's going on.
> 

if you want a 101 example have a look at this control program
http://git.xenomai.org/xenomai-jro.git/tree/demo/posix/cobalt/gpiopwm.c?h=410c

it opens an rtdm driver that generates a PWM signal using a GPIO
http://git.xenomai.org/xenomai-jro.git/tree/kernel/drivers/gpiopwm/gpiopwm.c?h=410c

The control program spawns two threads one to set the PWM signal base
configuration and another one to change the duty cycle (either automatically or
via user control, optional vi command line)

The driver presents a rt path to change the duty cycle and start/stop the PWM
signal (so no mode switches, always running in primary mode) and a non-rt path
to set the config.
The config has to be in a non-rt path since the kernel framework to configure
the GPIO requires some non-rt linux services.

It doesnt get any simpler than that I believe.


> GianPiero

-- 
jro

