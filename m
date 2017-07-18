From: Philippe Gerum <rpm@xenomai.org>
References: <CAMcKmiFbvicByv1oqbJMQx5-vOOskumHs7=60uM9QmooqdBEFg@mail.gmail.com>
 <CAMcKmiFCy=eaoaCUP+GFUhuE9Kd_SVs401-44Dk64CQVsDPHFQ@mail.gmail.com>
 <be4e97ab-f5b1-52de-ffef-90bedf167857@xenomai.org>
Message-ID: <070fe1da-6b24-7c6c-ed24-0a6639898499@xenomai.org>
Date: Tue, 18 Jul 2017 09:21:25 +0200
MIME-Version: 1.0
In-Reply-To: <be4e97ab-f5b1-52de-ffef-90bedf167857@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] select() unblocks when no data to read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <brozgeo@gmail.com>, xenomai@xenomai.org

On 07/17/2017 06:37 PM, Philippe Gerum wrote:
> On 07/13/2017 10:39 PM, George Broz wrote:
>> On 13 July 2017 at 09:26, George Broz <brozgeo@gmail.com> wrote:
>>> Hi -
>>>
>>> I'm using the UDD driver on Xenomai 3.0.4 / Linux 3.18.20 on an ARM SoC.
>>>
>>> I use select() to block on read events. The problem is select() unblocks
>>> twice in response to one interrupt event. The corresponding read()
>>> to the second erroneous unblocked select() then blocks until the next
>>> interrupt arrives.
>>>
>>> The psuedo-code in user-space looks like this:
>>>
>>>   while (active)
>>>   {
>>>     FD_ZERO (&FileDescSet);
>>>     FD_SET (FileDesc, &FileDescSet);
>>>
>>>     /* block until interrupt or timeout occurs */
>>>     IsInterruptPending = select ((FileDesc + 1), &FileDescSet, NULL,
>>> NULL, &Timeout);
>>>
>>>     /* check timeout (0) and error cases (-1) */
>>>     ...
>>>
>>>     /* otherwise, process */
>>>     if (IsInterruptPending && FD_ISSET(FileDesc, &FileDescSet))
>>>     {
>>>       err = read (FileDesc, &u32EventCount, sizeof (u32EventCount));
>>>       ...
>>>     }
>>>   }
>>>
>>>
>>> I have added debug to the UDD driver to verify udd_notify_event() is called
>>> exactly once per interrupt event, and that the ur->event is properly
>>> incremented.
>>>
>>> In udd_read_rt(), debug showing ur->event and context->event_count do what
>>> they should be doing - returning data when they mismatch and then setting
>>> one equal to the other, or blocking when they are equal. This function would
>>> be fine if select were working properly.
>>>
>>> (One thing to note is that when ur->event and context->event_count are equal,
>>> it takes two iterations of the for (;;) loop to actually block on
>>> rtdm_event_wait().)
>>>
>>> I added debug to udd_select(), but it doesn't work as expected. I had hoped
>>> to see debug emitted for each user-space call to select(), but it seems only
>>> one call is made to udd_select() the first time through the loop.
>>>
>>> In an unsuccessful workaround, I tried issuing rtdm_event_init() in an
>>> ioctl() called just before unmasking interrupts for the next iteration
>>> of the loop.
>>
>> However, if I add:
>>
>>    rtdm_event_clear(&ur->pulse);
>>
>> just before the return statement (return ret ?: sizeof(count);) in
>> udd_read_rt(),
>> then things to seem to work properly - select() unblocks only when there
>> is something to read...
>>
> 
> The rtdm_event_select() interface is broken. The portion signaling the
> state changes (e.g. IRQ pending <-> no IRQ pending) is simply missing...

Nah, it's there. I was looking for the wrong pattern. Ok, on the todo list.

-- 
Philippe.

