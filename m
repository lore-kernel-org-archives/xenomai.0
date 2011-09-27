MIME-Version: 1.0
In-Reply-To: <1317110949.2155.9.camel@domain.hid>
References: <CAMJ=MEeevXWzJg8O9jz5JxutNCj=EOHU=Xc93+NzjSFya4O5uA@mail.gmail.com>
	<1317110949.2155.9.camel@domain.hid>
Date: Tue, 27 Sep 2011 21:56:10 +0200
Message-ID: <CAMJ=MEeQO2GtorFcgkpv8kzrBVG+5EBG4LiJK+2+a4Z-1MU4HQ@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Xenomai-forge: tm_evafter without tm_cancel
	causes memory leaks.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, Sep 27, 2011 at 10:09 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Mon, 2011-09-26 at 23:28 +0200, Ronny Meeus wrote:
>> Hello
>>
>> As for as I know it is not mandatory call tm_cancel on a one-shot
>> timer to cleanup the resources in the OS.
>> This means that if the timer expires, the event is sent and all
>> resources are released by pSOS at that time.
>>
>> Since I did not see a test for this in the testsuite, I created one
>> myself (in fact 2, see attachments).
>> This time it is a small piece of code :-).
>> In this test I create a task that starts 100 events timers
>> (tm_evafter) but does not stop them (no tm_cancel is called).
>>
>> In the first test (tm-10.c) I create a task that starts 100 timers,
>> sleeps some time and deletes itself.
>> This sleeping allows the timers to expire. This is the result if I run valgrind:
>>
>
> [snip]
>
>> So it looks like the contexts allocated in start_evtimer are at least
>> lost, but valgrind mentions another 100 blocks that are still
>> reachable but I think these are in fact also lost since these are
>> referenced by the timer contexs.
>>
>
> [snip]
>
> Ack, it would not make sense to leave elapsed oneshot timers alive. The
> code is now fixed.
>
>
>>
>> I also have created a similar test application (tm-11), but in this
>> code the sleep is not there. This means the timers are still running
>> while killing the task. When running this test, I see an invalid read:
>>
>
> Confirmed. Albeit the deletion code was there, it was badly broken. At
> this chance, the "invalid timer" error code returned by all timer
> routines has been fixed as well.
>
> I merged a slightly adapted version of these tests as tm-6 and tm-7 in
> the psos testsuite. Thanks.
>
> --
> Philippe.
>
>
>

I tried the latest version of the repo and the problem is resolved.
Thanks for the quick response.

Ronny

