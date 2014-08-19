MIME-Version: 1.0
In-Reply-To: <53F30622.4050605@xenomai.org>
References: <CAKKWdtfZm+F3M+VtD2zG=JMun1GYtNDOAbzYvVUDXxq5B8qsMw@mail.gmail.com>
 <53F30622.4050605@xenomai.org>
Date: Tue, 19 Aug 2014 04:58:23 -0400
Message-ID: <CAKKWdtcS_Mz0vd3EMkEgGQuB98NwQbNfo5XGDmGMm3r-HBcz6g@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] a question about interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 8/19/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 08/19/2014 09:15 AM, ali hagigat wrote:
>> Is the following statements are true?
>>
>> If there are some Xenoma threads and an interrupt happens and it has
>> no head handling. The execuation of the Xenomai threads are stopped
>> and that interrupt is played.
>
> No.
>
> Ali, the aim of this mailing list is to help people with actual projects
> using Xenomai, which does not seem to be your case. You have been asking
> questions for monthes (if not years) on this mailing list, which show
> that you have not read or understood the documentation we provide. I am
> sorry, but unless you start a real project and have real questions about
> issues you have using xenomai, I will stop answering your questions.
>
> --
>                                                                 Gilles.
>

Thank you to answer my question. I really can not understand Xenomai
documentation like Life-with-ADEOS. It has been written in a
mysterious complicated way. When i do not know the function and
behaviour of something, how can i use it in real?
Honestly I am experiencing working with Xenomai, I have installed it
in a quad-core x86 32 bit machine and Fedora 13.
I do not earn money by Xenomai to need an urgent help for now (though
I may use it in real in the future) but I can be useful for you guys
testing at least the Xenomai library functions. I may find a bug this
way.
You people do not pay attention to my questions much. In two cases, i
could find small bugs. You wrote that only 4 config variables are
enough to be set to let Xenomai work properly on any machine while I
was losing my Linux virtual terminals in Fedora 13 and my machine.
I had to call kernel by one special parameter to get the virtual
terminal back and it is necessary for some systems and your
documentation could be updated but even you did not like to ask what
it was, simply ignored my emails.
Another one was one create Xenomai system call without deleting it at
the end, registry kept the object and next time the program executed
it stopped with an error. Actually in most of the cases when a program
finishes real-time resources are released but in this case it is not
released and a delete process must be done explicitly.
I know that these are some minor issues but I am surprised how they
never were attractive for you.
My energy and time for testing Xenomai is not useful for you? At the
same time I wish to understand the system. This is a basic fundamental
question:  Does Xenomai executes and handles  the interrupts even when
there are some Xenomai threads?
About the questions i asked before:  the Xenomai function and
behaviour was unclear for me completely. I was a beginner and your
answers were mentioned in a very ambiguous way only useful for
advanced users.

