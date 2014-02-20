Message-ID: <53068030.9030601@xenomai.org>
Date: Thu, 20 Feb 2014 23:22:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPydA0FQ+0AEeUQ2tXvcP1FZ0S21vVryBMqya0mcdg5vr8xmbw@mail.gmail.com>
In-Reply-To: <CAPydA0FQ+0AEeUQ2tXvcP1FZ0S21vVryBMqya0mcdg5vr8xmbw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Realtime tasks concepts (II)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Orestes Mas <masorestes@gmail.com>
Cc: xenomai@xenomai.org

On 02/20/2014 08:57 PM, Orestes Mas wrote:
>>
>> A 2014-02-20 11:41, Gilles Chanteperdrix escrigué:
>>
>> On 02/20/2014 11:27 AM, Gilles Chanteperdrix wrote:
>>
>> Our aim is to design NRT master and slaves (c++ objects) that communicates
>>>> with a RT task. The RT task is in charge of establish a continuous
>>>> communication with EtherCAT devices. This task communicates with NRT master
>>>> by the xddp sockects. The problem appears when the master call the RT SOEM
>>>> functions for the configuration, because it is necessary that the master
>>>> becomes a RT task, if not it doesn't work. And it has no sense.
>>>>
>>>
>>> Only a task with a shadow can call RT services, because it needs to be
>>> able to switch to primary mode, and only a task with a shadow can switch to
>>> primary mode.
>>>
>>
>> By RT services, I mean rt_mutex services and RTDM callbacks for which
>> you implemented the _rt version. If you mean anything else (like Xenomai
>> services), then you are to imprecise again, and the answer to your
>> question is "it depends", because on a service by service basis, some
>> need a task with a shadow, some do not. But usually, if a service needs
>> a task with a shadow, that is because its implementation requires it
>> (for instance because the task needs to be suspended in Xenomai
>> scheduler, which can not happen if the task does not have a shadow).
>>
> 
> 
> Sorry if I start a new thread with the same subject: I've just joined the
> mailing list and I don't have the past messages in my e-mail client.
> 
> Thanks for your explanations, Gilles. So, let's try to re-state the problem
> in "shadow" terms, to see if we finally understand it.
> 
> 1) We've a linux installation with xenomai patches and rt_net driver (RTDM)
> that manage rteth0 interface. From our experience and your explanations we
> assume that rt_net services, being RTDM, must be called _always_ from a
> task with a shadow. Is this correct?

In an RTDM driver, every file operation (read, write, ioctl) has an _rt
and an _nrt version. The _rt version requires a thread with a shadow,
the _nrt version does not.

> 
> The problem that started this list thread was that the SOEM library we use
> to communicate with some devices through the rteth0 interface has some
> initialization functions (init, config, and so on) and then a function to
> be executed periodically to maintain a data flow between the host PC and
> the devices. Initially we put _only_ this periodic part into a task with a
> shadow, but tried to call init and config functions from the main program
> --without a shadow--, and that didn't work. For it to work we had to shadow
> also the main task, a thing that becomes obvious after your explanations.
> 
> 2) We didn't like to have the main task shadowed because we assumed
> (perhaps erroneously) that it's better to keep the number of shadowed tasks
> to a minimum. If it's not possible, from your explanations I think that
> perhaps the best compromise is to have tha main task shadowed, but with
> priority 0 and scheduled by SCHED_OTHER. If I do that, will my shadowed
> task running in primary mode commute to secondary mode when called by the
> main task?
> 
> Probably I'll have more questions, but let's go step by step and clarify
> these before asking more.

Why not using the same task to do the initializations, and later on
become periodic and "maintain the data flow" ?

-- 
                                                                Gilles.

