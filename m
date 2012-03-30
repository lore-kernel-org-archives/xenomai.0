Message-ID: <4F75B5BF.8030401@domain.hid>
Date: Fri, 30 Mar 2012 15:31:43 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<4F7555F7.6010102@domain.hid>	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>
	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>
In-Reply-To: <CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Minh GIANG <giang.hminh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 03/30/2012 01:15 PM, Minh GIANG wrote:
> hello,
> 
> after testing a lot of time, i have one port which doesn't work well in
> writing (material problem i think). Now it works in writing and reading
> with one condtion that i have to remove the function
> "err=rt_dev_ioctl(...)" because it returns error.

Hm, what does rt_dev_ioctl() return?

> could you tell me the interet of this function? i think that rt_dev_read is
> enough to read the message.

Well, the ioctl waits for certain events and informs the task when they
occur. "cross_link.c" actually waits for the RTSER_EVENT_RXPEND meaning
that RX data are available. So, the sub-sequent read will/must work. You
do not need to call that ioctl but the read directly. But I doubt that
the read return successfully.

Maybe the interrupt service routine does detect errors due to hardware
problems:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/16550A.c#213

and that's why the interrupt counter increases.

You could check that by setting RTSER_EVENT_ERRPEND or reading the
status using the ioctl request RTSER_RTIOC_GET_STATUS.

Wolfgang.

> On Fri, Mar 30, 2012 at 10:45 AM, Minh GIANG <giang.hminh@domain.hid> wrote:
> 
>> hello,
>> thanks for your response. i compile cross-link program in ECLIPSE C++ so
>> my command in setting configuration is
>> command :   g++
>> All options:   -l/usr/xenomai/include -O3 -wall -c -fmessage-length=0
>>
>> i connected 2 serial port of my computer by one cable in order to make the
>> test. The write task works well but the other task is blocked by rt_dev_ioctl(...).as
>> i already mentionned and when i removed rt_dev_ioctl, the "rt_dev_read"
>> function return 0
>> I did what you said, but it doesn't work yet
>>
>> On Fri, Mar 30, 2012 at 8:43 AM, Wolfgang Grandegger <wg@domain.hid>wrote:
>>
>>> On 03/29/2012 05:26 PM, Minh GIANG wrote:
>>>> i want to revive the topic over the problem RTSER_RTIOC_WAIT_EVENT
>>>> while compiling cross-link.c program. I cann't resolve my problem
>>>> after doing some solution given by the others
>>>>
>>>> Loading module:
>>>>
>>>> insmod ./xeno_16550A.ko io=0x3f8,0x2f8 irq=4,3 tx_fifo=10,20
>>>
>>> Hm, is a FIFO size of 20 supported by the hardware? For a first try I
>>> would drop "tx_fifo=10,20" (using the default of 16 for both uarts).
>>>
>>>> start_index=0 (i have two serial ports on my pc)
>>>>
>>>> running crosslink test:
>>>>
>>>> main : write-file opened
>>>> main : write-config written
>>>> main : read-file opened
>>>> main : read-config written
>>>> main : write-task created
>>>> main : read-task created
>>>> main : starting write-task
>>>> main : starting read-task
>>>>  Nr |   write->irq    |    irq->read    |   write->read   |
>>>> -----------------------------------------------------------
>>>> read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
>>>> read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
>>>>
>>>> ...
>>>>
>>>>
>>>>
>>>> running test:
>>>>
>>>> cat /proc/xenomai/irq
>>>>
>>>> IRQ         CPU0
>>>>   3:        1089         rtser1
>>>>   4:        5155         rtser0
>>>
>>> You get interrupts, at least, but not the same amount, strange. What
>>> cross-link command options do you use?
>>>
>>> Wolfgang.
>>>
>>
>>
> 


