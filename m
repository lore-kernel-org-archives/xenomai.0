From: Philippe Gerum <rpm@xenomai.org>
References: <CAFjt0OkDDODSAjwBC6QJ4wMyae6RnzRhqKhgT7y0qqs1tPwc7g@mail.gmail.com>
 <CAK4EZFS9BOuZWAno7ZAp=wmnue-3qh_sd601Z4THTdu72=cACQ@mail.gmail.com>
 <6fa93df9-18c4-77fe-b24e-1bd396d92da9@xenomai.org>
Message-ID: <8932f1c6-676f-fa05-be4b-6e5819271d37@xenomai.org>
Date: Thu, 27 Apr 2017 18:32:20 +0200
MIME-Version: 1.0
In-Reply-To: <6fa93df9-18c4-77fe-b24e-1bd396d92da9@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RPi: Possible solution for freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Adam Vaughan <vaughana@umich.edu>, =?UTF-8?Q?Geber_Villa_Fern=c3=a1ndez?= <gebervf@gmail.com>
Cc: john.gwynne@matrixresearch.com, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/27/2017 06:27 PM, Philippe Gerum wrote:
> On 04/27/2017 06:09 PM, Adam Vaughan wrote:
>> Hi Gerber,
>>
>> I haven't tried Xenomai on the RPi in a few years (I've been working
>> on BeagleBone Xenomai lately), but I have experimented with Xenomai
>> 2.6 patches on the RPi 1 in the configuration you describe.
>>
>> There's more detail in section 7.5 in my dissertation [1], but I
>> strongly suggest checking that the USB driver isn't affecting your
>> overall system latency numbers under load.  Under heavy USB Ethernet
>> usage with the FIQ turned off I measured system stalls of up to 15
>> milliseconds under Xenomai with an oscilloscope.
>>
>> The only fix I had for this was to use PREEMPT_RT to lower the USB
>> driver thread priority.  At the time, I couldn't get PREEMPT_RT
>> patches to cleanly apply to the available Xenomai kernel patches, so I
>> ended up just using PREEMPT_RT exclusively.  This patch situation is
>> likely different these days.
> 
> I don't think any regular driver thread priority could interfere with
> the dual kernel operating in primary/real-time mode, that is actually a
> selling point of the pipelined IRQ architecture which decouples the
> regular kernel logic from the real-time core.
> 
> Using the I-pipe tracer combined with the -f option from the latency
> test may give some hints about the issue.
> 

Btw, there is a validated port of kernel 4.1 to the RPI Zero available
from git://git.xenomai.org/ipipe.git, vendors/beaglebone/ipipe-4.1.

-- 
Philippe.

