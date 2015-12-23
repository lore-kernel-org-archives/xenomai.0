Date: Wed, 23 Dec 2015 13:39:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151223123902.GB29038@hermes.click-hack.org>
References: <tencent_037A0D5E4214FC1A288A3CBA@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_037A0D5E4214FC1A288A3CBA@qq.com>
Subject: Re: [Xenomai] Question about syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?44OL44Oj44Oz5pif5Lq6?= <1173264124@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Wed, Dec 23, 2015 at 12:01:03PM +0800, ニャン星人 wrote:
> Hi, I am reading the source code about xenomai syscall. And I have
> some question about xenomai syscall. For example, when I call
> function open which is defined in file rtdm.c,it would call
> xenomai syscall by using "fd = XENOMAI_SYSCALL2( sc_cobalt_open,
> path, oflag);". sc_cobalt_open is a macro like "#define
> sc_cobalt_open 75" defined in file syscall.h. After interrupt
> requested, system would handle the irq. By using 75 and array
> cobalt_syscalls which is defined in
> \kernel\cobalt\posix\syscall.c, the irq handle function could be
> found in cobalt_syscalls[75]. After reading source code, I found
> cobalt_syscalls[75] is a function pointer. cobalt_syscalls[75] and
> cobalt_open point to the same function.

Hi,

Strictly speaking, cobalt_open is not a pointer, so it does not
point to anything. cobalt_syscall[75] is indeed a pointer to
cobalt_open.

>   
>      At this point, it is clear that function pointer
>      cobalt_##name initialize the array cobalt_syscalls. But I
>      can't find where cobalt_##name like cobalt_open defined in.
>   
>      All in all, I just want to figure out the map about syscall
>      from user-function to kernel-function, like open->fd =
>      XENOMAI_SYSCALL2( sc_cobalt_open, path, oflag);->static
>      inline int rtdm_open(const char *path, int oflag, ...)

cobalt_open is implemented in kernel/cobalt/posix/io.c

The macro COBALT_SYSCALL generates the "cobalt_open" name from the
declaration COBALT_SYSCALL(open, ...)

Regards.

-- 
					    Gilles.
https://click-hack.org

