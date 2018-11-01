Subject: Re: [I-PIPE] ipipe-core-4.14.71-x86-1 released
References: <20181101175938.D29167FB@centrum.cz>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <33f0bc4d-f8ef-9950-74ac-8b62bca6f015@xenomai.org>
Date: Thu, 1 Nov 2018 18:38:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181101175938.D29167FB@centrum.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On 11/1/18 5:59 PM, Petr Červenka wrote:
> Hello.
>  
> Is it really finished?
> I have problems to compile the patched kernel.
>  
> At first, when it compiles machine.c, there is such error:
>   CC      arch/x86/xenomai/machine.o
> In file included from ./include/asm-generic/xenomai/syscall.h:23:0,
>                  from arch/x86/xenomai/include/asm/xenomai/syscall.h:24,
>                  from arch/x86/xenomai/machine.c:22:
> ./arch/x86/include/asm/uaccess.h: In function ‘set_fs’:
> ./arch/x86/include/asm/uaccess.h:33:9: error: dereferencing pointer to incomplete type ‘struct task_struct’
>   current->thread.addr_limit = fs;
>          ^~
>  
> After an ad-hoc fix, there are some other errors for example during compiling of thread.c, mostly connected to fpu:
> fpu.fpregs_active, fpu.active_state, __fpregs_deactivate(), __fpregs_activate(), clts(), stts(), SLAB_NOTRACK, ...
>  
> Am I doing something wrong?
>  

You are likely not using the proper Xenomai branch, you need -next.

-- 
Philippe.

