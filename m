MIME-Version: 1.0
In-Reply-To: <5009A63A.3090100@xenomai.org>
References: <CAKKWdtdjPVbTmUMRgXYuH_9y0Gjrcqa-KvLQWPzo2EA+x0t13Q@mail.gmail.com>
	<5009A63A.3090100@xenomai.org>
Date: Sat, 21 Jul 2012 15:31:00 +0430
Message-ID: <CAKKWdteQafmdxO0=GKnJQJog3YibNxo5_Uequ7VVL3b3cK6Scw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] question: periodic system timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai@xenomai.org

1) Can i use native-skin functions and POSIX-skin functions together
in one user space program?

2) I had a questions about skin timers and you answered it:

"and if a skin request periodic mode, a software
timer is started to provide the skin timebase. So, if each skin has a
different period, each skin will get a tick at the period it
requested."

What does it mean when you say each skin will get a tick? Getting a
tick means that a hardware timer interrupt happens? Each skin gets a
tick means when a function of that skin is called? So when that
function returns it will not get that tick?
As far as i understood the effect of these soft timers are seen for
some functions of a skin and the effect is based on that function. Is
a soft timer able to effect and change the next shot time of the
underlying hardware timer?( I think the answer is yes!)

On Fri, Jul 20, 2012 at 11:10 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 07/16/2012 11:41 AM, ali hagigat wrote:
>> When the system clock is set as periodic for a skin, does this mean
>> that the timer interrupt happens for the period and for any function
>> of that skin? or only some functions? This interrupt rate happens
>> after the skin API function is called?
>> So after returning the function and before executing any other
>> instruction, the timer mode gets back to one-shot?
>
> This is gibberish. Please try and read again my answer to your question
> about skin timers, and tell us what you do not understand in that answer.
>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
>
> --
>                                                                 Gilles.

