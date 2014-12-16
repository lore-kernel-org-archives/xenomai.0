Message-ID: <549090FA.7000901@xenomai.org>
Date: Tue, 16 Dec 2014 21:07:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
 <CAMJ=MEfDQm_ymyL8FULhqMvpwzet4aHMbQFoEjL-sVDsCTg2Hg@mail.gmail.com>
 <549072DC.1030901@xenomai.org>
 <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
In-Reply-To: <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 12/16/2014 08:41 PM, Ronny Meeus wrote:
> On Tue, Dec 16, 2014 at 6:58 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 12/16/2014 06:36 PM, Ronny Meeus wrote:
>>> On Sun, Dec 7, 2014 at 5:26 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
>>>> Hello
>>>>
>>>> we are using the xenomai-forge implementation.
>>>> We from time to time see an issue that the timer-internal thread is
>>>> consuming a complete core. It is seen when we send broadcast traffic that
>>>> needs to be handled by the Linux kernel (ARP).
>>>>
>>>> The kernel thread's priority handling the packets in the middle between the
>>>> timer-internal thread and the application thread's priority. All threads run
>>>> on the same core.
>>>> If the priority of the timer-internal is lowered below the kernel thread,
>>>> the load disappears immediately.
>>>> So it looks like there is some busy polling on a common resource that is
>>>> currently held by the application thread running at the lowest prio.
>>>>
>>>> I see that the timer lock being used is a mutex with priority inheritance so
>>>> I would expect that the prio of the application is raised as soon as the
>>>> timer-internal thread tries to obtain the mutex.
>>>
>>> After investigating this issue in more detail I have the impression that it has
>>> nothing to do with the mutex used to protect the timer but with the conditional
>>> variable used to implement the psos event interface.
>>>
>>> I found references on the web that explain an issue with the internal mutex used
>>> inside the posix library to implement a conditional variable. See:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=438484
>>> http://marc.info/?t=134688711000002&r=1&w=2
>>>
>>> If this is indeed true, it means that the usage of conditional
>>> variables is not safe
>>> at all (from priority inheritance point of view).
>>
>> Yes, condvars are known not to work nicely with PI mutexes on the glibc.
> 
> Philippe,
> I do not understand.
> 
> We just use the pSOS interface of the xenomai-forge, which internally uses
> conditional variables.
> Does this mean that we cannot use the pSOS interface with glibc?
> 
> If above statement is correc, what libc should we use to make it work?
> 

A release of the glibc that fixes this issue. I must admit that I did
not track this problem lately. Jan likely knows better here.

-- 
Philippe.

