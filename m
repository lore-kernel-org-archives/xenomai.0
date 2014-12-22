MIME-Version: 1.0
Sender: justinhartubc@gmail.com
In-Reply-To: <CAFgu5KVAKhXC+Tzds-b2P5o6+u+xBwZz_tL5-j2GL6sjbkme4g@mail.gmail.com>
References: <CAFgu5KXBDRLxt4q3PUw9he+4Z97RV0=Q96Y+or7FzEwT3CVZRA@mail.gmail.com>
 <20141220153337.GD24110@csclub.uwaterloo.ca> <20141220160408.GB3961@daedalus>
 <20141220162139.GF24110@csclub.uwaterloo.ca>
 <20141220162937.GA12315@daedalus.click-hack.org>
 <CAFgu5KVAKhXC+Tzds-b2P5o6+u+xBwZz_tL5-j2GL6sjbkme4g@mail.gmail.com>
From: Justin Hart <justin.hart@mech.ubc.ca>
Date: Mon, 22 Dec 2014 12:05:35 -0800
Message-ID: <CAFgu5KUG9N-13DwqwW9ryp0J3_9qvmB=A4A6x=2qk29BHSEzHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Kernel Configuration Woes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Oh, Lennart.  Commodity hardware.  Core i7, 32G RAM, Ubuntu 14.04, kernel
as described above, Linux 3.14.17 w/ Xenomai 2.6.4 with the packaged Adeos
patch.  The only thing interesting about the configuration that I thought
might be contributing to issues is running the CUDA driver.  I stumbled
onto the hypothesis that something was wrong with the kernel because I was
having rendering issues.  Backing out CUDA appeared to resolve the issues,
but I think that it's my software doing something *really* boneheaded.  I
have a small GUI that I wrote that displays the current pose of the arm.  I
think that I'm refreshing a set of gtk_entries with gtk_entry_set_text
every time the arm's position is updated.  I *should* be doing this in a
GTK worker that just updates it every time it goes through gtk_main_loop.
I think that what I'm doing is simply giving too many events to the
x-server.  I first noticed this because there was some latency in the arm's
responsiveness.

Altering it to test this should be easy enough, though.

Justin

On Mon, Dec 22, 2014 at 11:57 AM, Justin Hart <justin.hart@mech.ubc.ca>
wrote:

> Sorry for the delayed reply!  I was a bit under the weather this weekend.
> I think that you folks have hit on my alternate hypothesis: that I am doing
> something in my program in the real-time thread that is causing problems.
> It's a little weird, because I am linking against libbarrett.  I wrote a
> wrapper to the arm code that gives me a simple simulated arm or the real
> arm, based on how the program is invoked.  When it's not the real arm,
> however, nothing that interacts with xenomai is launched.  I'm going to do
> some testing today and see if I can narrow in on the problem.  I might have
> some more questions.  Thanks for the help so far, though!
>
> On Sat, Dec 20, 2014 at 8:29 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On Sat, Dec 20, 2014 at 11:21:39AM -0500, Lennart Sorensen wrote:
>> > On Sat, Dec 20, 2014 at 05:04:08PM +0100, Gilles Chanteperdrix wrote:
>> > > To make it simple: from Linux point of view, Xenomai behaves just as
>> > > an SMI.
>> >
>> > Certainly true, but that's the software you control so you can make it
>> > behave itself.
>>
>> Well, the only way to make it behave itself is to not run it at all,
>> because as soon as Xenomai run its threads, it "steals" time to
>> Linux. So, the workaround is to get it to run not too long, but it
>> is not guaranteed to be sufficient to avoid detection, and the other
>> workaround is to disable Linux detection mechanisms.
>>
>> --
>>                                             Gilles.
>>
>
>
