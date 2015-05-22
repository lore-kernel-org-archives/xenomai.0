Message-ID: <555F0443.6040906@basystemes.fr>
Date: Fri, 22 May 2015 12:26:11 +0200
From: Thierry Bultel <thierry.bultel@basystemes.fr>
MIME-Version: 1.0
References: <555D77F6.7030007@basystemes.fr> <555D7C73.8030905@basystemes.fr>
 <555DCA94.1070909@xenomai.org> <555DF3D3.9090600@basystemes.fr>
 <555DF877.8040001@xenomai.org> <555DFAA7.3090001@basystemes.fr>
 <555EDDD6.9010305@xenomai.org>
In-Reply-To: <555EDDD6.9010305@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Are concurrent writes to XDDP sockets allowed ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org
Cc: =?windows-1252?Q?C=E9line?= <celine.leberre.prestataire@basystemes.fr>



Le 22/05/2015 09:42, Philippe Gerum a =E9crit :
> On 05/21/2015 05:32 PM, Thierry Bultel wrote:
>>
>> Le 21/05/2015 17:23, Philippe Gerum a =E9crit :
>>> On 05/21/2015 05:03 PM, Thierry Bultel wrote:
>>>> Le 21/05/2015 14:07, Philippe Gerum a =E9crit :
>>>>> On 05/21/2015 08:34 AM, Thierry Bultel wrote:
>>>>>> Hi,
>>>>>> In an application, we have one regular thread listening on an RTP
>>>>>> device,
>>>>>> and 2 realtime threads that concurrently write data in the XDDP sock=
et
>>>>>> backend.
>>>>>> We use the POSIX skin.
>>>>>>
>>>>>> Sometimes, the regular thread gets its blocking read() call just
>>>>>> return 0.
>>>>>> That never happens with the classic "one reader, one writer" case.
>>>>>>
>>>>>> Also, we notice that the 'return 0' case occurrence is not the same,
>>>>>> depending
>>>>>> on the fact that the realtime task uses 'write' instead of 'sendto'
>>>>>> (more occurrences with 'sendto')
>>>>>>
>>>>> There is no restriction with respect to concurrent sending to such
>>>>> socket.
>>>> Ok, thanks
>>>>> Knowing about the Xenomai release number,
>>>> This is 2.6.4
>>>>> and a simple test code that
>>>>> actually illustrates the intended usage and ideally reproduces the
>>>>> issue
>>>>> would help.
>>>> Here is the test code, based on xddp-echo.c . Unfortunalely this does
>>>> not reproduce the issue.
>>>> Compared to our application, we also have 3 other additional
>>>> realtime-regular pairs communicating on 3 dedicated channels.
>>>>
>>>> What would trigger the 'read' return with zero ?
>>> Sending zero len messages from the rt side via sendto(), which is legit
>>> with XDDP. Using write() won't send anything.
>>>
>> This was my first assumption.
>> But the way we use it eliminates that possible cause; the sent struct is
>> on stack.
>> Moreover, we have 'zero' read even when using the 'write' instead of
>> 'sendto'
>> 'sendto' just seem to increase the number of zero read occurences.
>>
>>     RAWFRAME message;
>>
>> ...
>>
>>          nb =3D write(channel, &message, sizeof(message));
>>
>>
>>
> Any spurious wake up fixed with this?
>
> diff --git a/ksrc/nucleus/pipe.c b/ksrc/nucleus/pipe.c
> index 3c4dccf..df587ab 100644
> --- a/ksrc/nucleus/pipe.c
> +++ b/ksrc/nucleus/pipe.c
> @@ -122,13 +122,17 @@ static inline void xnpipe_dequeue_all(struct xnpipe=
_state *state, int mask)
>   	xnpipe_enqueue_wait(__state, __mask);				\
>   	xnlock_put_irqrestore(&nklock, __s);				\
>   									\
> -	prepare_to_wait_exclusive(__waitq, &__wait, TASK_INTERRUPTIBLE);\
> -									\
> -	if (!(__cond))							\
> +	for (;;) {							\
> +		__sigpending =3D signal_pending(current);			\
> +		if (__sigpending)					\
> +			break;						\
> +		prepare_to_wait_exclusive(__waitq, &__wait, TASK_INTERRUPTIBLE); \
> +		if (__cond)						\
> +			break;						\
>   		schedule();						\
> +	}								\
>   									\
>   	finish_wait(__waitq, &__wait);					\
> -	__sigpending =3D signal_pending(current);				\
>   									\
>   	/* Restore the interrupt state initially set by the caller. */	\
>   	xnlock_get_irqsave(&nklock, __s);
>
Many thanks;
that fixes the issue.

I am just curious; what is the test case to trigger the spurious wakeup=20
please ?
Will that patch be commited in mainline ?

Regards
Thierry


