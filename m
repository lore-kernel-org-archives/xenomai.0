Date: Wed, 8 Jun 2016 22:00:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160608200016.GA32218@hermes.click-hack.org>
References: <001201d1c17a$8b683bd0$a238b370$@ajinextek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001201d1c17a$8b683bd0$a238b370$@ajinextek.com>
Subject: Re: [Xenomai] My Device of xenomai 2.6.3 patch Issues ~!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?77+977+977+9ybXvv70=?= <sdkim@ajinextek.com>
Cc: xenomai@xenomai.org

On Wed, Jun 08, 2016 at 08:40:23PM +0900, ���ɵ� wrote:
>  
> 
> Hi

Hi,

> 
>  
> 
> When the xenomai 2.6.3 patch on my device, there are some
> problems.

Xenomai is not a patch.

> The first problem.
> 
> When in use the application program ¡°clock_gettime¡± function quickly
> (about 5ms), the spinlock occurred in the kernel.
> 
> See kernel message file (¡°dmesg¡± command), file name =
> dmesg_spinlock.txt

I do not understand what the problem is, you do not really give us
enough detail, in particular, you say "when I use the application
program clock_gettime", but for me clock_gettime is not a program.
Anyway, do you get the same issues if you use:
- Xenomai 2.6.4
- a mainline Linux kernel

> A Second problem.
> 
> Using a "rt_mutex_create" function in the parent program when generating a
> "MyMutex", performs "rt_mutex_acquire", "rt_mutex_release" quickly, and the
> problem occurs once in 5-7 days.
> 
> Kernel messages of the problem. (¡°dmesg¡± command)

Once again: I have not understood your problem. The message you get
on the console is normal if an application exits, without a mutex
having been destroyed. And the message can be suppressed with the
kernel configuration.

Regards.

-- 
					    Gilles.
https://click-hack.org

