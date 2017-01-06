MIME-Version: 1.0
In-Reply-To: <2426a18d-13ce-6774-b41a-cee7937f277f@xenomai.org>
References: <CAMJ=MEd=nsydR-ckQTHgwqcyp4h3UkiioFbTLiJNjKg-6mNciA@mail.gmail.com>
 <e24d081d-456f-4c99-0105-0ddf688d2319@xenomai.org>
 <CAMJ=MEcz=py5s-BVBs2VX3pD-w3zNzcgLUePpifWx08SVXdVDA@mail.gmail.com>
 <d7916ae4-0aa2-fff8-c42f-e230ad4619c8@xenomai.org>
 <CAMJ=MEfiXVkDiv4PAMNhLXbjkXV5xD_fG77_YdgiGajJFxZ6Hw@mail.gmail.com>
 <2426a18d-13ce-6774-b41a-cee7937f277f@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 6 Jan 2017 14:16:20 +0100
Message-ID: <CAMJ=MEfXQyL03ZH5JSG7-Gs5ZujRETJiwLn54uF03S0oi=0v3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] copperplate/registry daemon connection failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Jan 6, 2017 at 12:00 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 01/06/2017 10:54 AM, Ronny Meeus wrote:
>> On Fri, Jan 6, 2017 at 10:29 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 01/06/2017 10:21 AM, Ronny Meeus wrote:
>>>> That logic I had seen before.
>>>> As I understand the code it just tries 3 times to connect to the daemon
>>>> and if not successful, it just tries to start it again and reconnects ...
>>>> I find it a strange logic just to try something 3 times and hope it
>>>> will succeed.
>>>> In our case the CPU is fully loaded with RT threads so my assumption is that
>>>> the daemon, running at nonRT prio will not be scheduled at all.
>>>> (also see the traces above that confirm my assumptions)
>>>>
>>>> I would expect to see some kind of synchronization mechanism between the
>>>> daemon and the application.
>>>>
>>>
>>> The point is that such init code is aimed at running early, prior to any
>>> Xenomai application code, this is cold bootstrap code. The fact that
>>> your app can spawn threads overconsuming the CPU earlier than Xenomai's
>>> basic init code is a problem for Xenomai.
>>>
>>
>> Philippe,
>>
>> on our system we have a lot of Xenomai applications running, it can be up to 10
>> or more. So it is impossible to guarantee that there will be CPU power available
>> at the moment Xenomai init is called.
>> Next to the application code also the Linux kernel threads can consume a lot of
>> CPU power (especially during init).
>>
>
> I don't see how your app could ever compete with drivers during the
> kernel bootstrap phase, just because no application can run until user
> mode is started, which is last in the process, by definition.
>
> If referring to kernel helper threads overconsuming CPU during plain
> runtime or soon after user mode is entered, maybe you should consider
> determining why this happens, this does not look quite normal
> (vendor-originated mmc driver with broken power mgmt, massive logging on
> slow flash medium?). Maybe you did already, and I would be interested to
> know about your findings.
>

We have done an evolution from a non-Linux system (psos) to Linux based
system by using Xenomai. Our application's low priority threads run at pSOS
priorities below 5, which is mapped by Xenomai on the Linux FIFO scheduler.
This means that even very low priority application threads (logging etc) have
even a much higher priority than Linux apps (running on the OTHER scheduler).
These low priority application threads can even consume a complete CPU
and this is not an issue since it there is more important work to do, it will be
done by a higher priority thread.

For this model to work we needed to fit all other threads (like
shells, dropbear,
etc) in the RT range. For example the shells are running at prio -31. Linux
kernel threads at prio -95 etc. Also the init thread of Linux runs at prio -31.

So in our system is it perfectly normal that threads running in the non-RT
scheduling range are not scheduled at all.

With the previous version of Xenomai we used, the scheduling class of the
sysregd app was not explicitly set and inherited the prio of it
creator. So it was
nicely put in the medium/low priority range of the system (also -31 in
our case).
So there was no issue ...
Only  with the 3.0.3 version, we see the issue because it is
explicitly put in the
SCHED_OTHER scheduler.

>> Xenomai applications can be started during init but also at runtime, so it is
>> impossible to make assumptions about the availability of CPU power.
>>
>
> You obviously do make assumptions about the CPU power, such as assuming
> that your system can cope in a deterministic way with running distinct
> or even unrelated set of CPU-hungry threads from multiple real-time apps
> concurrently. Xenomai makes the assumption that the current CPU should
> be able to process all of the pending regular (non-rt) activity within 3
> seconds, which seems reasonable. We could make it 30, no issue with
> that, but that would not address the real problem anyway.

I do not know where the 3 seconds you mention are coming from.
I only see 200ms in the code.

        default:
                /*
                 * Make sure we sleep at least 200 ms regardless of
                 * signal receipts.
                 */
                while (usleep(200000) > 0) ;
                regd_pid = pid;
                barrier();

>
> Your point is about requiring Xenomai to work around a seemingly massive
> overload condition in the regular Linux system when the app initializes,
> hoping for the best. I don't think this is the way to go, this would
> only paper over the core issue, with potentially nasty effects.
>
> Typically, a consequence of raising the priority of registry threads to
> address this issue would be to serve fuse-fs requests at high (rt)
> priority, directly competing with other SCHED_RR/SCHED_FIFO threads in
> the system, since you don't run Cobalt, and therefore the co-kernel
> could not save your day in this case.
>
> Therefore, anyone issuing "cat /var/run/xenomai/*/*" on a terminal would
> actually compete with some real-time threads in your application(s),
> possibly delaying them for an undefined amount of time. At any rate, our
> fuse-fs threads that do string formatting to output human-readable
> reports upon (interactive) request should not compete with real-time
> threads, really.

This is acceptable for us since all threads run in the RT range, see before.
It is even correct since otherwise the "cat /var/run/xenomai/*/*" operation
would suffer from a massive priority inversion since it will only be handed
if all lower priority activities have finished and the non-RT task
will get a slot
to run ...

> Regarding the fact that your system cannot respond within 3 seconds to a
> socket connection, you still have the option to start the daemon
> separately, before the application is launched. Any showstopper with
> that option?

I think this will not solve anything. The daemon will be created, but still the
threads will be running in the non-RT range so the connect and/or the receive
will not be handled correctly ...

>
> --
> Philippe.

