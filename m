MIME-Version: 1.0
In-Reply-To: <4A5E046D.3020404@domain.hid>
References: <abaf774b0907150825l289e7730h60ed03ca8db83d9a@domain.hid>
	<4A5DF5EB.8040509@domain.hid> <4A5E01C2.9070805@domain.hid>
	<4A5E046D.3020404@domain.hid>
Date: Fri, 17 Jul 2009 12:07:18 +0100
Message-ID: <abaf774b0907170407q9544cc9la1c07860bd7ebf25@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mq_send takes longer than expected
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 15/07/2009, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>> Steve wrote:
>>>> Hi,
>>>>
>>>> Calling mq_send takes significantly varied amounts of time depending
>>>> on the queue length.  I was not expecting this behaviour, particularly
>>>> as this does not happen when using RTAI mq_send calls.  I can
>>>> understand that queue creation / opening times will heavily depend on
>>>> the queue's overall size, however I would have thought that sending a
>>>> message (adding it to the queue's data structure (linked list?)) would
>>>> take a constant time.
>>>>
>>>> Is this a bug, or expected behaviour?  I have attached an example.
>>> mq_send is expected by the posix specification to block its caller when
>>> the queue is full. If you do not want this behaviour, you should pass
>>> O_NONBLOCK to mq_open and be prepared for mq_send to return -1 with
>>> errno set to EAGAIN/EWOULDBLOCK.
>>>
>>> Would this be your problem ?
>>
>> Ok, I now have looked at your test code, you measure when posting the
>> first message, and you already have O_NONBLOCK set. Could you try to
>> create the queues in the reverse order and see what happens?
>
> Also, would you have CONFIG_XENO_OPT_DEBUG_QUEUES activated ? In this
> case, list operations are no longer O(1).
>
> --
>                                           Gilles
>
>

I did have CONFIG_XENO_OPT_DEBUG_QUEUES activated, I must have been a
little overzealous when choosing my config options.  Everything now
runs as expected.

Thanks for the help,

Steve

