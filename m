Message-ID: <437AE37D.8010304@domain.hid>
Date: Wed, 16 Nov 2005 08:45:01 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange pipe behaviour
References: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
	<4378D175.7010304@domain.hid> <437AC773.6070501@domain.hid>
In-Reply-To: <437AC773.6070501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


>>
>> 1- rt_pipe_receive returns with r >= 0.
>> 2- /* whatever */
>> 3- Message is freed using rt_pipe_free.
>> 4- Next call to rt_pipe_receive returns with r = -EINTR.
>>
>> The only explanation I could come up with is that when the pipe is
>> closed by the user mode process, the rt_pipe_receive tells the rt task
>> by returning -EINTR. Is this right?.
>
>
> Yes.
>
>  According to the docs, -EINTR is
>
>> only returned if rt_task_unblock() has been called...
>>
>
> Actually, this is what happened through the internal interface.
> driver::release(pipe) -> nucleus::unblock(sleepers_on_pipe)

Sure, but that behaviour is *extremely* confusing for a newbie (like
me). Should be described in the docs (this time I don't submit a patch
because I don't quite understand the pipe internals yet).

And anyway, I don't see the point in notifying the RT task that the
non-RT end has closed the pipe. Or, in other words, if we want to
provide such a notification, we should provide also opening notification.

By the way, where is the xnpipe_* API documentation? I could not find it
in the online docs (firefox downloads the file search.php when I try to
use the search feature).

>
>> Nacho.
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>
>


