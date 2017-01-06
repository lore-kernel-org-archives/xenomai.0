MIME-Version: 1.0
In-Reply-To: <d7916ae4-0aa2-fff8-c42f-e230ad4619c8@xenomai.org>
References: <CAMJ=MEd=nsydR-ckQTHgwqcyp4h3UkiioFbTLiJNjKg-6mNciA@mail.gmail.com>
 <e24d081d-456f-4c99-0105-0ddf688d2319@xenomai.org>
 <CAMJ=MEcz=py5s-BVBs2VX3pD-w3zNzcgLUePpifWx08SVXdVDA@mail.gmail.com>
 <d7916ae4-0aa2-fff8-c42f-e230ad4619c8@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 6 Jan 2017 10:54:40 +0100
Message-ID: <CAMJ=MEfiXVkDiv4PAMNhLXbjkXV5xD_fG77_YdgiGajJFxZ6Hw@mail.gmail.com>
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

On Fri, Jan 6, 2017 at 10:29 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 01/06/2017 10:21 AM, Ronny Meeus wrote:
>> That logic I had seen before.
>> As I understand the code it just tries 3 times to connect to the daemon
>> and if not successful, it just tries to start it again and reconnects ...
>> I find it a strange logic just to try something 3 times and hope it
>> will succeed.
>> In our case the CPU is fully loaded with RT threads so my assumption is that
>> the daemon, running at nonRT prio will not be scheduled at all.
>> (also see the traces above that confirm my assumptions)
>>
>> I would expect to see some kind of synchronization mechanism between the
>> daemon and the application.
>>
>
> The point is that such init code is aimed at running early, prior to any
> Xenomai application code, this is cold bootstrap code. The fact that
> your app can spawn threads overconsuming the CPU earlier than Xenomai's
> basic init code is a problem for Xenomai.
>

Philippe,

on our system we have a lot of Xenomai applications running, it can be up to 10
or more. So it is impossible to guarantee that there will be CPU power available
at the moment Xenomai init is called.
Next to the application code also the Linux kernel threads can consume a lot of
CPU power (especially during init).

Xenomai applications can be started during init but also at runtime, so it is
impossible to make assumptions about the availability of CPU power.

Ronny

> --
> Philippe.

