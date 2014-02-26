MIME-Version: 1.0
In-Reply-To: <52FFABEA.9020700@xenomai.org>
References: <CAKKWdtf8-JMgtY+yksL1R6M4g+cN-+C_PAzye+dPBzy6VkymEw@mail.gmail.com>
 <52FFABEA.9020700@xenomai.org>
Date: Wed, 26 Feb 2014 18:14:40 +0330
Message-ID: <CAKKWdtfEGZNougOFJKqvC2z08+uUcVf9sHA=XMsOwX4NLRnoqg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] freeze for rt_task_delete()
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

On 2/15/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 02/15/2014 04:30 PM, ali hagigat wrote:
>> My system:
>> Fedora 13
>> x86, 32 bits
>> xenomai-2.6.3
>> kernel-3.5.7
>>
>> I executed examp13 and then examp12, computer froze, GNOME stopped,
>> only mouse could move but it could not point at the icons or execute
>> any thing. Key-presses were not seen.
>
> That is the usual sign for a kernel oops. Try runnning the example in
> text mode, in order to capture the oops. You can also capture the oops
> by redirecting kernel logs to a serial port or via network.
>
> --
>                                                                 Gilles.
>

I solved the problem of Linux virtual terminal and the text interface
and executing those programs are OK now. Yesterday i was writing some
simple codes for heap and message passing task services and i made
some mistakes in them and computer broke several times . I could not
repeat the problem, so i did not attach the code. But even
rt_timer_spin() made the computer to stop and break. Today was OK, i
was surprised why a real time task can make the whole  system fail.
When i used some timer functions the system started to become OK......

