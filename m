Message-ID: <568FAD6C.2000801@isc.cnr.it>
Date: Fri, 08 Jan 2016 13:37:00 +0100
From: GianPiero Puccioni <gianpiero.puccioni@isc.cnr.it>
MIME-Version: 1.0
References: <56795E20.1010102@isc.cnr.it> <5679E096.3030807@xenomai.org>
 <567A5ED3.505@isc.cnr.it> <567AA8DD.9000202@xenomai.org>
In-Reply-To: <567AA8DD.9000202@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: xenomai@xenomai.org

Sorry for the delay, but I was away for a few days ... and then got the flu...

On 23/12/15 14:59, Jorge Ramirez Ortiz wrote:
> On 12/23/2015 03:44 AM, GianPiero Puccioni wrote:
>> On 23/12/15 00:45, Jorge Ramirez Ortiz wrote:
>>
>>>
>>> have you tried reading the Xenomai demo code or the analogy utilities?
>>> http://git.xenomai.org/xenomai-3.git/tree/utils/analogy
>>>
>>
>> Yes, of course, but the analogy utils are not written for realtime
>
> what do you mean? do you see mode switches when you run them?
> I havent executed them in a while but as far as I remember some of them were.
>
>> (and there
>> are some bits missing, for example insn_read does not set the range properly),
>
> could you point me where?
>

I think it's where it calls  a4l_sync_read and passes CHAN, that is only the 
channel info but not the range. While the range is used when printing the 
output, resulting in wrong values.


>> and the realtime examples are quite obscure for a beginner: only sparse comments
>> and no explanation on what's going on.
>>
>
> if you want a 101 example have a look at this control program
> http://git.xenomai.org/xenomai-jro.git/tree/demo/posix/cobalt/gpiopwm.c?h=410c
>
> it opens an rtdm driver that generates a PWM signal using a GPIO
> http://git.xenomai.org/xenomai-jro.git/tree/kernel/drivers/gpiopwm/gpiopwm.c?h=410c
>
> The control program spawns two threads one to set the PWM signal base
> configuration and another one to change the duty cycle (either automatically or
> via user control, optional vi command line)
>
> The driver presents a rt path to change the duty cycle and start/stop the PWM
> signal (so no mode switches, always running in primary mode) and a non-rt path
> to set the config.
> The config has to be in a non-rt path since the kernel framework to configure
> the GPIO requires some non-rt linux services.
>
> It doesnt get any simpler than that I believe.
>
>

Thanks, I'll check that.

GianPiero
-- 
GianPiero Puccioni               |Istituto dei Sistemi Complessi-CNR
gianpiero.puccioni@isc.cnr.it    |Via Madonna del Piano, 10
T:+39 0555226682 F:+39 0555226683|50019 Sesto F. (Firenze) ITALY

