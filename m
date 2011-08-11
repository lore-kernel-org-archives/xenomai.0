Message-ID: <4E444102.10206@domain.hid>
Date: Thu, 11 Aug 2011 22:52:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid>	<4E43B7E8.5000302@domain.hid>	<4E43C056.9040007@domain.hid>	<4E43EBC6.10808@domain.hid>	<4E440FAC.5020107@domain.hid>
	<4E4411DB.80009@domain.hid>
In-Reply-To: <4E4411DB.80009@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] gcc-4.6 issue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: 637425@domain.hid, xenomai@xenomai.org

On 08/11/2011 07:31 PM, Gilles Chanteperdrix wrote:
> On 08/11/2011 07:21 PM, Roland Stigge wrote:
>> Hi,
>>
>> On 08/11/2011 04:48 PM, Daniele Nicolodi wrote:
>>> I compiled linux 2.6.38.8 and xenomai-head with gcc-4.6. The obtained
>>> kernel boots fine but xenomai services do not: latency hangs right after
>>> the sched_setscheduler system call. With the same kernel I compiled user
>>> space with gcc-4.4 and xenomia services work just fine.
>>
>> I can confirm this now for Debian. Sorry for the delay.
>>
>> Will use gcc-4.4 for building the Debian package for now.
>>

The gcc 4.6 version is compiled with frame pointer disabled, whereas the
4.4 version is compiled with frame pointers. Enabling the
-fomit-frame-pointer option with gcc 4.4 seems to cause issues as well.

With gcc 4.4, the difference is very visible in rt_task_start. The
correct syscall chunk is:

  11:	0d 2b 02 00 02	     	or     $0x200022b,%eax

Computes the syscall number, put the result in eax.

  16:	89 45 fc	     	mov    %eax,-0x4(%ebp)

Move the result from eax to temporary space on stack.

  19:	8b 45 08	     	mov    0x8(%ebp),%eax

Load syscall first argument value into eax

  1c:	53		     	push   %ebx
  1d:	89 c3		     	mov    %eax,%ebx

Push ebx, move syscall first argument from eax to ebx

  1f:	8b 45 fc	     	mov    -0x4(%ebp),%eax

Reload the syscall number from its temporary storage to eax.

  22:	65 ff 15 10 00 00 00 	call   *%gs:0x10
  29:	5b		     	pop    %ebx

Syscall done.

The version without frame pointer:
    4e3d:	8b 00		     	mov    (%eax),%eax
    4e3f:	0d 2b 02 00 02	     	or     $0x200022b,%eax
    4e44:	89 44 24 0c	     	mov    %eax,0xc(%esp)
    4e48:	8b 44 24 18	     	mov    0x18(%esp),%eax
    4e4c:	53		     	push   %ebx
    4e4d:	89 c3		     	mov    %eax,%ebx
    4e4f:	8b 44 24 0c	     	mov    0xc(%esp),%eax
    4e53:	65 ff 15 10 00 00 00 	call   *%gs:0x10
    4e5a:	5b		     	pop    %ebx

This is essentially the same sequence, except that the temporary storage
used to store the syscall number is obtained via a relative offset of
the stack pointer (esp) instead of a relative offset of the frame
pointer, since we are compiling without frame pointers, the problem is
that between the time this value is stored, and the time it is restored,
the stack pointer changed since we pushed %ebx.

So, I do not really know what to make of it. The simple solution seems
to me to continue compiling with frame pointers. I.e. add
-fno-omit-frame-pointer with gcc 4.6.

-- 
                                                                Gilles.

