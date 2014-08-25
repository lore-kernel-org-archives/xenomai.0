From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Mon, 25 Aug 2014 11:33:43 +0000
Message-ID: <D02088B2.184BA%shartmann@cnt.canon.com>
References: <D01BBA98.18467%shartmann@cnt.canon.com>
 <53F6E307.7050606@xenomai.org> <D01C95BF.18476%shartmann@cnt.canon.com>
 <53FAF809.5030004@xenomai.org>
In-Reply-To: <53FAF809.5030004@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAD5A560F4FD054D80ACA5D76C251110@mex06.mlsrvr.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] ENOMEM returned from rt_task_create and rt_sem_create
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



On 8/25/14 3:47 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

>On 08/22/2014 01:44 PM, Steve Hartmann wrote:
>>=20
>>=20
>> On 8/22/14 1:28 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:
>>=20
>>> On 08/21/2014 10:04 PM, Steve Hartmann wrote:
>>>> Hi folks,
>>>>
>>>> I am using linux 3.2.21 + xenomai 2.6.2.1 on intel core i7.  This is a
>>>> user land application.
>>>>
>>>> This code I am having issues with was working pretty well until I
>>>>added
>>>> some more semaphores.  As it runs right now, it will call
>>>>rt_sem_create
>>>> 544 times, then call a single rt_task_create.  There are also about 15
>>>> mutexes created also.  I didn't count it, but somewhere around 520 or
>>>>so
>>>> semaphores, I start getting ENOMEM returned from both of these
>>>>methods.
>>>>
>>>> Is there a way I can increase whatever memory pool these are pulling
>>>> from?  It is feasible to rewrite the code so I use less semaphores,
>>>>but
>>>> if it is not detrimental, I would like to just raise whatever limit it
>>>> is that I am running into.
>>>>
>>>
>>>
>>> Raising CONFIG_XENO_OPT_SYS_HEAPSZ should fix this issue.
>>>
>>> --=20
>>> Philippe.
>>=20
>> Thanks for the reply.
>>=20
>> That's what I thought too.  I doubled it to 512 and saw no effect.  I
>>also
>> doubled the value of CONFIG_XENO_OPT_GLOBAL_SEM_HEAP and
>> CONFIG_XENO_OPT_SEM_HEAPSZ to see if they had any effect - they did not.
>>=20
>>=20
>
>This could be the number of registry slots then, try raising
>CONFIG_XENO_OPT_REGISTRY_NRSLOTS.
>
>--=20
>Philippe.

Thanks, I will try that today.  However, in all the calls to
rt_sem_create, I pass NULL to the name parameter.  Should the semaphores
still be taking up registry slots even if unnamed?

Steven


