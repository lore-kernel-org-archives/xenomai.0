References: <5601A1A1.2020506@siemens.com> <560263A0.4080208@sigmatek.at>
 <56026810.8040300@sigmatek.at> <56028093.6050805@siemens.com>
 <56050985.2060002@sigmatek.at> <560A8632.3020107@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <560AB4C7.3050508@xenomai.org>
Date: Tue, 29 Sep 2015 17:56:55 +0200
MIME-Version: 1.0
In-Reply-To: <560A8632.3020107@sigmatek.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: Re: Problem that the Linux scheduler is not
 called for some ms
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, xenomai@xenomai.org

On 09/29/2015 02:38 PM, Johann Obermayr wrote:
> Am 25.09.2015 um 10:44 schrieb Harald Feßl:
>> Hi
>>
>> I have done a ipipe trace for some working and one non working cycle.
>> The trace is stopped after the non working cycle.
>> I have marked the working cycles with green and the non working cycle
>> with red in my graphical trace.
>> The ipipe trace and graphical trace are stopped at the same time.
>>
>> After the non working cycle the system is working correct again for
>> some seconds or minutes.
>>
>> I think the problem is, that the migration of the task "cyclic" from
>> xenomai to linux, needs sometimes some ms.
>>
>> Harald
>>
>> Harald Fessl
>> Betriebssystem
>> ________________________________
>>
>> SIGMATEK GmbH & Co KG
>> Sigmatekstraße 1
>> 5112 Lamprechtshausen
>> Österreich / Austria
>>
>> Tel.:  +43/6274/4321-0
>> Fax:  +43/6274/4321-18
>> E-Mail: harald.fessl@sigmatek.at
>> http://www.sigmatek-automation.com
>>
>> ***********************Please note:************************************
>> This email and all attachments are confidential and intended solely for
>> the person or entity to whom it is addressed. If you are not the named
>> addressee you must not make this email and all attachments accessible
>> to any other person. If you have received this email in error please
>> delete it together with all attachments.
>> ***********************************************************************
>>
>> Am 23.09.2015 um 12:36 schrieb Jan Kiszka:
>>> On 2015-09-23 10:51, Harald Feßl wrote:
>>>> Hi
>>>>
>>>> The linux tasks are not blocked (not all).
>>>> I think the problem is , that the linux scheduler function in the
>>>> kernel
>>>> is not called for some ms.
>>>> I have also traced the calls to the scheduler function
>>>> "static int __sched __schedule(void)"
>>>> and sometimes when the decribed problem occur this function is not
>>>> called while no linux task are running.
>>> If no task is runnable, there is also no reason to invoke schedule.
>>>
>>> Please post a ftrace log of your system, covering both a working and a
>>> non-working cycle, including cobalt* and at least sched and irq events.
>>>
>>> Jan
>>>
>>
> 
> 
> Hello Philippe and Xenomai forum,
> 
> we have some trouble with a xenomai task (cyclic with prio 30) after
> switching to secondary domain.
> Linux ARM 3.0, Xenomai 2.6.2.1, and CONFIG_XENO_OPT_PRIOCPL=y.

PRIOCPL should be disabled, and all tests redone in this context.

-- 
Philippe.

