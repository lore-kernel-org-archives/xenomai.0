MIME-Version: 1.0
In-Reply-To: <4FE9B6C7.4040702@xenomai.org>
References: <CAM1yFZ-CZ8qkTS1MqFMiQJtg85UVM5QiDUcPKSGBWDMDj4LdLQ@mail.gmail.com>
	<4FE9B6C7.4040702@xenomai.org>
Date: Wed, 27 Jun 2012 17:29:56 +0530
Message-ID: <CAM1yFZ8Z+K_p=uooS4OE0qXENK51jgGsCsyiC9L3OxcEK3XdHg@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RT_TASK isn't needed for every program, is it?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

> By default, the main thread, when using xenomai native API is not a xenomai thread. If you want to turn the main thread into a xenomai native skin thread, you should use rt_task_shadow.

This information is utterly helpful and enlightening. I was puzzled
that why that `hello world` program needs to create a "thread"!

Anyway, I have just now tested the UDP client server program with the
Xenomai RT_TASK and the RTnet's socket API. That's running all well.

Thanks for your help.
-Anisha

On 26/06/2012, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 06/26/2012 10:21 AM, Anisha Kaul wrote:
>> From what I've read here:
>> http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html
>> I could figure out that `RT_TASK`  is a kind of real time "thread"
>> concept.
>
> It is an id for a xenomai thread, very much like pthread_t.
>
>>
>> But in the cases where I don't need threads, can I simply write the
>> program in main() using Xenomai/RTnet API? Creating RT_TASK isn't
>> necessary for every program, is it?
>
> A xenomai thread is needed to access some of the xenomai services (most
> of them actually). By default, the main thread, when using xenomai
> native API is not a xenomai thread.
>
> If you want to turn the main thread into a xenomai native skin thread,
> you should use rt_task_shadow.
>
> xenomai sources distribution contains many examples of that.
>
> --
> 					    Gilles.
>


-- 
Anisha Kaul

