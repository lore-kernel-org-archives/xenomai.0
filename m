MIME-Version: 1.0
In-Reply-To: <CAA3JOdYL4dSX6Beayo00JMzgWS7guNY032=P0=R3_40jE9iiYQ@mail.gmail.com>
References: <CAA3JOdbY+p2yHyUEKmKDaug8hUj5izgxwfAYrf4BCgrx48-4Vw@mail.gmail.com>
 <CALLqZ8Qg9L1ooa0GmN+NkJjKejy8KG5sScn1VVPj4vtOg+O42w@mail.gmail.com>
 <CAA3JOdYL4dSX6Beayo00JMzgWS7guNY032=P0=R3_40jE9iiYQ@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 3 May 2018 14:42:01 -0400
Message-ID: <CALLqZ8T9Ka1jtqZJG3dDX1-cx6TVeAA+n=7r_AKrugQSXdf-aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Shared memory between RT and NRT tasks (Posix Skin)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Virendra Kate <virendrakate@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I can continue to do some digging, but I've only really used xddp.
I'm sure someone on the list can help out.

On Thu, May 3, 2018 at 2:33 PM, Virendra Kate <virendrakate@gmail.com> wrote:
> I am still looking into xddp but might not be the best solution for us.
>
> The shared memory is 16MB big.
>
> -Virendra
>
> On Thu, May 3, 2018 at 10:51 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>> Have you considered using xddp sockets instead?  How large is the
>> memory you are sharing?
>>
>> -Greg
>>
>> On Thu, May 3, 2018 at 1:49 PM, Virendra Kate <virendrakate@gmail.com> wrote:
>>> Hello,
>>>
>>> I am trying to create a shared memory between a RT (Cobalt) and a NRT
>>> (Linux) task. I went through the " A Tour of the Native API " document
>>> which pointed me towards the alchemy (previously "native") API.
>>>
>>> Currently we are using the Posix skin as it has better performance. This
>>> link:
>>> http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__posix__shm.html
>>> indicates
>>> that the typical posix share memory API was available for Xenoami Cobalt in
>>> version 2.4.
>>>
>>> Since the shared memory section is missing in the Xenomai 3 documentation
>>> and I couldn't find the --wrap shm_open() etc. flags in the
>>> "cobalt.wrappers" file I was wondering if this functionality is supported
>>> in Xenomai 3 Posix skin.
>>>
>>> At this point I am avoiding the use of message queues.
>>>
>>> Any help is appreciated.
>>>
>>> Thanks,
>>> Virendra Kate
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai

