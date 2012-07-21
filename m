MIME-Version: 1.0
In-Reply-To: <5009A7DA.3010101@xenomai.org>
References: <CAKKWdtfdsiPqa_eV8fbMM9oZmNmwdvOpRs+eSXE1LPLCy0eg+Q@mail.gmail.com>
	<5009A7DA.3010101@xenomai.org>
Date: Sat, 21 Jul 2012 12:24:16 +0430
Message-ID: <CAKKWdtda5A6HxCk4VVg-34z1nWKY=zWMc4XRo30RymVfaVz4qA@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] question: rescheduling a blocked task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Dear Gilles,

I have already installed Xenomai, 2.6.0 under Fedora 13 and x86 and 32
bits system and every thing seems OK.

I believe that my questions and your answers has cleared many dark
sides of the issue and may be useful for others too on a bet that they
can read them some how.

Before writing any real time application i needed a deep understanding
of the whole logic and a general picture. Sorry to ask questions and
take up your valuable time and other people, please forgive me, but
what is recorded can be very useful for beginners.

Regards

On Fri, Jul 20, 2012 at 11:17 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 07/17/2012 11:26 AM, ali hagigat wrote:
>> If a real time task is blocked for some real time object, does Xenomai
>> guarantee the (re-)scheduling latency to be lower than a specific
>> number?
>
> As we already answered, I believe, Xenomai does not guarantee anything,
> it just provides you with the tools to measure an empiric estimate of
> the worst case scheduling latency. And the worst case scheduling latency
> only make sense when the woken up task is the highest priority runnable
> task, otherwise your task may be delayed for some time by higher
> priority tasks.
>
>> Does the task enter the Linux domain when it is blocked?
>
> No, of course not.
>
>> or when it is blocked it may be in the blocked state for arbitrary time lengths?
>
> That just depends on what the unblocking does.
>
> What about what I proposed you? Installing xenomai for real and asking
> real questions about real issues you get when porting real applications?
> Instead of asking questions in the void which you will find stupid when
> you have got your feet wet with xenomai?
>
> --
>                                                                 Gilles.

