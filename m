Message-ID: <546A500A.5080004@xenomai.org>
Date: Mon, 17 Nov 2014 20:44:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca> <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
In-Reply-To: <20141117191237.GS24110@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 11/17/2014 08:12 PM, Lennart Sorensen wrote:
> On Fri, Nov 07, 2014 at 07:43:30PM +0100, Philippe Gerum wrote:
>> For this particular issue, Xenomai 2.x is deadly wrong. Creating,
>> deleting, enabling or disabling an IRQ channel must be done from
>> secondary mode. The syscall mode bits for these native API calls are
>> wrong, should be as follows instead:
>>
>> diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
>> index 950b092..dff7f4d 100644
>> --- a/ksrc/skins/native/syscall.c
>> +++ b/ksrc/skins/native/syscall.c
>> @@ -4145,12 +4145,12 @@ static xnsysent_t __systab[] = {
>>  	[__native_alarm_stop] = {&__rt_alarm_stop, __xn_exec_any},
>>  	[__native_alarm_wait] = {&__rt_alarm_wait, __xn_exec_primary},
>>  	[__native_alarm_inquire] = {&__rt_alarm_inquire, __xn_exec_any},
>> -	[__native_intr_create] = {&__rt_intr_create, __xn_exec_any},
>> +	[__native_intr_create] = {&__rt_intr_create, __xn_exec_lostage},
>>  	[__native_intr_bind] = {&__rt_intr_bind, __xn_exec_conforming},
>> -	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_any},
>> +	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_lostage},
>>  	[__native_intr_wait] = {&__rt_intr_wait, __xn_exec_primary},
>> -	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_any},
>> -	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_any},
>> +	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_lostage},
>> +	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_lostage},
>>  	[__native_intr_inquire] = {&__rt_intr_inquire, __xn_exec_any},
>>  	[__native_pipe_create] = {&__rt_pipe_create, __xn_exec_lostage},
>>  	[__native_pipe_bind] = {&__rt_pipe_bind, __xn_exec_conforming},
> 
> Are you sure all 4 of those had to change?  I can see intr_create and
> intr_delete, but intr_enable and disable?  We are seeing insane latency
> from realtime irqs on the omap gpio irqs (a few ms response to an irq).

The reason to move all of these calls to lostage is that all of them may
have to traverse regular linux code, which cannot be made I-pipe aware
by design (e.g. PCI config code holding the big pci_lock). In such a
case, we certainly don't want them to be called from the middle of
nowhere linux-wise, e.g. from the real-time domain. So yes, all of them
must be switched to lostage mode.

> Of course it could be the gpio irq is just doing something wrong.
> Not sure yet.  Of course before doing this change we sometimes saw it
> take close to 1s to call the realtime irq handler which made no sense
> at all.  gic interrupts are working as expected and see no delays that
> we are aware of at least.
> 

This is likely a bug in the irq chip handling for these gpios lines.

-- 
Philippe.

