References: <CAF06wtgV=DewshLh48CMNFy3J7SzBk06ToJjaQsXpF2+TkBqoA@mail.gmail.com>
 <6f55db98-0988-3b9f-f1dc-6f393211af4d@xenomai.org>
 <CAF06wtgMdvZ-K2yNMY6wZMSUa+ELdwBV=rbm7F1vAiLX57OyeQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a977c731-91ce-e308-8676-1a1a82f7cf22@xenomai.org>
Date: Mon, 5 Jun 2017 10:24:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAF06wtgMdvZ-K2yNMY6wZMSUa+ELdwBV=rbm7F1vAiLX57OyeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issues with Xenomai 3.0.5...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jlangston@panurgyinc.com
Cc: xenomai@xenomai.org

On 06/04/2017 08:02 PM, Jim Langston wrote:
> Philippe,
> 
> The backtrace I get when I run gdb on the target is:
> 
> #0  0x00000000 in ?? ()
> #1  0xb77b617c in do_open (
>     path=path@entry=0xb77bd31d "/dev/rtdm/memdev-private",
>     oflag=oflag@entry=2, mode=0) at rtdm.c:51

It looks like the *libc you are using does not enable the
sysenter/sysexit kernel call convention for x86, you may want to pass
--disable-x86-vsyscall to the configure script, then rebuild from scratch.

Also, I would recommend to pass --disable-smp in the same move, since
Xenomai enables SMP support by default for the x86 architecture, and
although this would still work with a UP kernel (the opposite would
not), there is no point on the Geode.

-- 
Philippe.

