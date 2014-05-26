Message-ID: <5383406C.4070902@xenomai.org>
Date: Mon, 26 May 2014 15:23:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>	<5382E8B1.8070402@xenomai.org>
 <CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>
In-Reply-To: <CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drew <pythondrew@gmail.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 05/26/2014 02:50 PM, Drew wrote:
>
> On Mon, May 26, 2014 at 3:09 AM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
>
>
>     Any change with this?
>
>     - pause();
>     + for (;;)
>     +    pause();
>
>     --
>     Philippe.
>
>
> I get the "thread exited" messages before the "hello, world" is
> printed.. that's before the pause() call and even before the tasks have
> been started..

Do not trust stdio printouts for debugging in a dual kernel system, they 
may be delayed in different ways, despite your termios are set to 
canonical mode.

In addition, testing return codes of syscalls would be a good idea, e.g. 
rt_task_start(), assuming rt_task_create() did succeed since GDB told 
you about two new threads.

PS: please keep the list posted.

-- 
Philippe.

