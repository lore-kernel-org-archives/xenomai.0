Message-ID: <50803AC8.6080604@nta-inc.net>
Date: Thu, 18 Oct 2012 12:22:16 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <507C93B6.30304@nta-inc.net> <507D0712.9070305@xenomai.org>
	<507F2D28.4090600@nta-inc.net> <507F8477.2070005@xenomai.org>
In-Reply-To: <507F8477.2070005@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Still having problems running Xenomai on an Intel
 X5650 x86_64 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 10/17/2012 11:24 PM, Gilles Chanteperdrix wrote:
> On 10/18/2012 12:11 AM, Jeff Webb wrote:
>
>> On 10/16/2012 02:04 AM, Gilles Chanteperdrix wrote:
>>> On 10/16/2012 12:52 AM, Jeff Webb wrote:
>>>
>>>> I'm back to trying to get Xenomai running on a dual 6-core Intel
>>>> X5650 desktop machine.  I reported my previous attempts a few
>>>> months ago:
>>>>
>>>> On ubuntu 10.04 with 2.6.38.8:
>>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000546.html
>>>>
>>>> On ubuntu 10.04 with 3.2.21:
>>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000577.html
>>>>
>>>> I am now using ubuntu 12.04 instead of 10.04, and I'm using the
>>>> xenomai-2.6.git branch.  I am still not having any success.  The
>>>> kernel boots, but hangs as the GUI login box is coming up.  This
>>>> is similar to what happened under ubuntu 10.04/3.2.21, but the
>>>> call trace seems a little different.  I have attached my kernel
>>>> config and the console output, which was captured via a serial
>>>> connection.  This exact kernel package seems to run fine (with
>>>> very limited testing) on a 4-core Intel X9650 desktop machine
>>>> running the same OS, for what it's worth.  Any help in debugging
>>>> this would be appreciated.  What's my next step?
>>>
>>>
>>> I am afraid that is another known issue fixed in the 3.4 branch.
>>> Please try the I-pipe git; git://git.denx.de, branch core-3.4.
>>>
>>
>> Thanks again, Gilles.
>>
>> I just rebuilt the kernel using the core-3.4 branch of ipipe.git with
>> xenomai-2.6.git.  I started with the same kernel config as before and
>> then disabled a few drivers to get everything to compile without
>> errors.
>
>
> If you do not need to disable these drivers to compile the kernel
> without Xenomai, then it is not normal, please be more specific.

I started with a 3.2-series kernel config (posted earlier) that compiled with Xenomai.  I then copied that config over into the ipipe-core-3.4 build directory before running menuconfig.  When I tried to compile the kernel, I encountered some section mismatch errors.  To get those to go away, I ended up disabling the following options:

#  Device Drivers
#    GPIO Support
#      Intel EG20T PCH/LAPIS Semiconductor IOH(ML7223/ML7831)...
#    USB Support
#      USB Gadget Support
#    Staging drivers
#      Data acquisition support (comedi)

It wasn't quite clear to me which comedi module was giving me trouble, so I disabled all of it, although it probably wasn't necessary.  I'm pretty sure that these problems were a result of migrating my kernel config from 3.2 to 3.4, and don't have anything to do with Xenomai.  I did not try to compile a vanilla 3.4 kernel, so I can't be certain.  I apologize for the confusion.  I only mentioned that so you would know that the config was very slightly different from what I posted last time.

>>   The system still crashes, but now it seems to happen several
>> seconds after the login box has appeared.  The console output is
>> shown below.
>
>
> This does not look like the same issue, right? As usual, could you
> disassemble __ipipe_dispatch_irq, or run addr2line for the error address
> (0xffffffff810ac055)?

It appears to be a different issue.  Since I have a bzImage in my boot directory, I ran:

  addr2line -i -e vmlinux ffffffff810ac055
  
on the vmlinux file I found in my kernel build directory.  I'm assuming that is the right thing to do.  Here is the result:

   linux-3.4.6-ipipe-core-3.4.git.2012.10.09/include/linux/ipipe.h:342
   linux-3.4.6-ipipe-core-3.4.git.2012.10.09/kernel/ipipe/core.c:1211

The code looks like this:

ipipe.h:

static inline int ipipe_chained_irq_p(struct irq_desc *desc)
{
	void __ipipe_chained_irq(unsigned irq, struct irq_desc *desc);

-->	return desc->handle_irq == __ipipe_chained_irq;
}

core.c:
	if (unlikely(irq >= NR_IRQS)) {
		desc = NULL;
		chained_irq = 0;
	} else {
		desc = irq_to_desc(irq);
-->		chained_irq = ipipe_chained_irq_p(desc);
	}


Here is the output of:

   objdump -drS vmlinux --start-address=0xffffffff810ac020


ffffffff810ac020 <__ipipe_dispatch_irq>:
ffffffff810ac020:	55                   	push   %rbp
ffffffff810ac021:	48 89 e5             	mov    %rsp,%rbp
ffffffff810ac024:	48 83 ec 40          	sub    $0x40,%rsp
ffffffff810ac028:	81 ff ff 40 00 00    	cmp    $0x40ff,%edi
ffffffff810ac02e:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffffffff810ac032:	4c 89 65 e0          	mov    %r12,-0x20(%rbp)
ffffffff810ac036:	89 fb                	mov    %edi,%ebx
ffffffff810ac038:	4c 89 6d e8          	mov    %r13,-0x18(%rbp)
ffffffff810ac03c:	4c 89 75 f0          	mov    %r14,-0x10(%rbp)
ffffffff810ac040:	41 89 f4             	mov    %esi,%r12d
ffffffff810ac043:	4c 89 7d f8          	mov    %r15,-0x8(%rbp)
ffffffff810ac047:	0f 87 25 02 00 00    	ja     ffffffff810ac272 <__ipipe_dispatch_irq+0x252>
ffffffff810ac04d:	45 31 f6             	xor    %r14d,%r14d
ffffffff810ac050:	e8 cb 4b ff ff       	callq  ffffffff810a0c20 <irq_to_desc>
ffffffff810ac055:	48 81 b8 80 00 00 00 	cmpq   $0xffffffff810a3cc0,0x80(%rax)
ffffffff810ac05c:	c0 3c 0a 81
ffffffff810ac060:	41 0f 94 c6          	sete   %r14b
ffffffff810ac064:	41 f6 c4 01          	test   $0x1,%r12b
ffffffff810ac068:	41 89 dd             	mov    %ebx,%r13d
ffffffff810ac06b:	75 38                	jne    ffffffff810ac0a5 <__ipipe_dispatch_irq+0x85>
ffffffff810ac06d:	48 8b 0d 0c 92 97 00 	mov    0x97920c(%rip),%rcx        # ffffffff81a25280 <ipipe_head_domain>
ffffffff810ac074:	49 8d 55 01          	lea    0x1(%r13),%rdx
ffffffff810ac078:	48 c7 c6 80 88 c6 81 	mov    $0xffffffff81c68880,%rsi
ffffffff810ac07f:	48 c1 e2 06          	shl    $0x6,%rdx
ffffffff810ac083:	f6 04 11 01          	testb  $0x1,(%rcx,%rdx,1)
ffffffff810ac087:	48 0f 44 ce          	cmove  %rsi,%rcx
ffffffff810ac08b:	48 8b 54 11 08       	mov    0x8(%rcx,%rdx,1),%rdx
ffffffff810ac090:	48 85 d2             	test   %rdx,%rdx
ffffffff810ac093:	74 07                	je     ffffffff810ac09c <__ipipe_dispatch_irq+0x7c>
ffffffff810ac095:	48 89 c6             	mov    %rax,%rsi
ffffffff810ac098:	89 df                	mov    %ebx,%edi
ffffffff810ac09a:	ff d2                	callq  *%rdx
ffffffff810ac09c:	45 85 f6             	test   %r14d,%r14d
ffffffff810ac09f:	0f 85 7b 01 00 00    	jne    ffffffff810ac220 <__ipipe_dispatch_irq+0x200>
ffffffff810ac0a5:	49 c7 c6 90 15 05 00 	mov    $0x51590,%r14
ffffffff810ac0ac:	65 48 8b 14 25 b0 cc 	mov    %gs:0xccb0,%rdx
ffffffff810ac0b3:	00 00
ffffffff810ac0b5:	4c 89 f0             	mov    %r14,%rax
ffffffff810ac0b8:	4c 8b 3c 02          	mov    (%rdx,%rax,1),%r15
ffffffff810ac0bc:	49 8d 45 01          	lea    0x1(%r13),%rax
ffffffff810ac0c0:	48 c1 e0 06          	shl    $0x6,%rax
ffffffff810ac0c4:	49 8b bf 98 1c 02 00 	mov    0x21c98(%r15),%rdi
ffffffff810ac0cb:	f6 04 07 02          	testb  $0x2,(%rdi,%rax,1)
ffffffff810ac0cf:	0f 85 e2 00 00 00    	jne    ffffffff810ac1b7 <__ipipe_dispatch_irq+0x197>
ffffffff810ac0d5:	48 8b 3d a4 91 97 00 	mov    0x9791a4(%rip),%rdi        # ffffffff81a25280 <ipipe_head_domain>
ffffffff810ac0dc:	48 81 ff 80 88 c6 81 	cmp    $0xffffffff81c68880,%rdi
ffffffff810ac0e3:	48 8b 04 07          	mov    (%rdi,%rax,1),%rax
ffffffff810ac0e7:	0f 84 ca 00 00 00    	je     ffffffff810ac1b7 <__ipipe_dispatch_irq+0x197>
ffffffff810ac0ed:	a8 01                	test   $0x1,%al
ffffffff810ac0ef:	0f 84 bb 00 00 00    	je     ffffffff810ac1b0 <__ipipe_dispatch_irq+0x190>
ffffffff810ac0f5:	41 83 e4 02          	and    $0x2,%r12d
ffffffff810ac0f9:	0f 85 7d 01 00 00    	jne    ffffffff810ac27c <__ipipe_dispatch_irq+0x25c>
ffffffff810ac0ff:	49 c7 c4 e8 f8 02 00 	mov    $0x2f8e8,%r12
ffffffff810ac106:	49 01 d4             	add    %rdx,%r12
ffffffff810ac109:	49 8b 0c 24          	mov    (%r12),%rcx
ffffffff810ac10d:	49 8b 84 24 98 1c 02 	mov    0x21c98(%r12),%rax
ffffffff810ac114:	00
ffffffff810ac115:	83 e1 01             	and    $0x1,%ecx
ffffffff810ac118:	0f 85 6a 01 00 00    	jne    ffffffff810ac288 <__ipipe_dispatch_irq+0x268>
ffffffff810ac11e:	4d 39 fc             	cmp    %r15,%r12
ffffffff810ac121:	74 0f                	je     ffffffff810ac132 <__ipipe_dispatch_irq+0x112>
ffffffff810ac123:	48 c7 c1 40 dc 00 00 	mov    $0xdc40,%rcx
ffffffff810ac12a:	4c 89 a4 0a 50 39 04 	mov    %r12,0x43950(%rdx,%rcx,1)
ffffffff810ac131:	00
ffffffff810ac132:	4b 83 84 ec 98 10 00 	addq   $0x1,0x1098(%r12,%r13,8)
ffffffff810ac139:	00 01
ffffffff810ac13b:	41 0f ba 2c 24 00    	btsl   $0x0,(%r12)
ffffffff810ac141:	49 83 c5 01          	add    $0x1,%r13
ffffffff810ac145:	89 df                	mov    %ebx,%edi
ffffffff810ac147:	49 c1 e5 06          	shl    $0x6,%r13
ffffffff810ac14b:	49 01 c5             	add    %rax,%r13
ffffffff810ac14e:	49 8b 75 18          	mov    0x18(%r13),%rsi
ffffffff810ac152:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffffffff810ac156:	41 ff 55 10          	callq  *0x10(%r13)
ffffffff810ac15a:	fa                   	cli
ffffffff810ac15b:	41 0f ba 34 24 00    	btrl   $0x0,(%r12)
ffffffff810ac161:	65 48 8b 0c 25 b0 cc 	mov    %gs:0xccb0,%rcx
ffffffff810ac168:	00 00
ffffffff810ac16a:	4e 3b 24 31          	cmp    (%rcx,%r14,1),%r12
ffffffff810ac16e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffffffff810ac172:	75 18                	jne    ffffffff810ac18c <__ipipe_dispatch_irq+0x16c>
ffffffff810ac174:	4d 39 fc             	cmp    %r15,%r12
ffffffff810ac177:	0f 84 e3 00 00 00    	je     ffffffff810ac260 <__ipipe_dispatch_irq+0x240>
ffffffff810ac17d:	48 c7 c2 40 dc 00 00 	mov    $0xdc40,%rdx
ffffffff810ac184:	4c 89 bc 11 50 39 04 	mov    %r15,0x43950(%rcx,%rdx,1)
ffffffff810ac18b:	00
ffffffff810ac18c:	48 89 c7             	mov    %rax,%rdi
ffffffff810ac18f:	e8 3c fb ff ff       	callq  ffffffff810abcd0 <__ipipe_do_sync_pipeline>
ffffffff810ac194:	0f 1f 40 00          	nopl   0x0(%rax)
ffffffff810ac198:	48 8b 5d d8          	mov    -0x28(%rbp),%rbx
ffffffff810ac19c:	4c 8b 65 e0          	mov    -0x20(%rbp),%r12
ffffffff810ac1a0:	4c 8b 6d e8          	mov    -0x18(%rbp),%r13
ffffffff810ac1a4:	4c 8b 75 f0          	mov    -0x10(%rbp),%r14
ffffffff810ac1a8:	4c 8b 7d f8          	mov    -0x8(%rbp),%r15
ffffffff810ac1ac:	c9                   	leaveq
ffffffff810ac1ad:	c3                   	retq
ffffffff810ac1ae:	66 90                	xchg   %ax,%ax
ffffffff810ac1b0:	48 c7 c7 80 88 c6 81 	mov    $0xffffffff81c68880,%rdi
ffffffff810ac1b7:	89 de                	mov    %ebx,%esi
ffffffff810ac1b9:	e8 42 ec ff ff       	callq  ffffffff810aae00 <__ipipe_set_irq_pending>
ffffffff810ac1be:	41 83 e4 02          	and    $0x2,%r12d
ffffffff810ac1c2:	75 d4                	jne    ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac1c4:	65 48 8b 14 25 b0 cc 	mov    %gs:0xccb0,%rdx
ffffffff810ac1cb:	00 00
ffffffff810ac1cd:	4c 89 f0             	mov    %r14,%rax
ffffffff810ac1d0:	48 8b 04 02          	mov    (%rdx,%rax,1),%rax
ffffffff810ac1d4:	48 81 b8 98 1c 02 00 	cmpq   $0xffffffff81c68880,0x21c98(%rax)
ffffffff810ac1db:	80 88 c6 81
ffffffff810ac1df:	74 0f                	je     ffffffff810ac1f0 <__ipipe_dispatch_irq+0x1d0>
ffffffff810ac1e1:	48 c7 c0 e8 f8 02 00 	mov    $0x2f8e8,%rax
ffffffff810ac1e8:	48 83 7c 10 08 00    	cmpq   $0x0,0x8(%rax,%rdx,1)
ffffffff810ac1ee:	74 a8                	je     ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac1f0:	65 48 8b 04 25 b0 cc 	mov    %gs:0xccb0,%rax
ffffffff810ac1f7:	00 00
ffffffff810ac1f9:	4a 8b 14 30          	mov    (%rax,%r14,1),%rdx
ffffffff810ac1fd:	48 8b 3d 7c 90 97 00 	mov    0x97907c(%rip),%rdi        # ffffffff81a25280 <ipipe_head_domain>
ffffffff810ac204:	48 3b ba 98 1c 02 00 	cmp    0x21c98(%rdx),%rdi
ffffffff810ac20b:	74 2b                	je     ffffffff810ac238 <__ipipe_dispatch_irq+0x218>
ffffffff810ac20d:	e8 be fa ff ff       	callq  ffffffff810abcd0 <__ipipe_do_sync_pipeline>
ffffffff810ac212:	e9 81 ff ff ff       	jmpq   ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac217:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
ffffffff810ac21e:	00 00
ffffffff810ac220:	41 83 e4 02          	and    $0x2,%r12d
ffffffff810ac224:	49 c7 c6 90 15 05 00 	mov    $0x51590,%r14
ffffffff810ac22b:	74 c3                	je     ffffffff810ac1f0 <__ipipe_dispatch_irq+0x1d0>
ffffffff810ac22d:	e9 66 ff ff ff       	jmpq   ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac232:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
ffffffff810ac238:	48 63 0f             	movslq (%rdi),%rcx
ffffffff810ac23b:	48 c7 c2 40 dc 00 00 	mov    $0xdc40,%rdx
ffffffff810ac242:	48 01 d0             	add    %rdx,%rax
ffffffff810ac245:	48 01 c8             	add    %rcx,%rax
ffffffff810ac248:	48 8b 00             	mov    (%rax),%rax
ffffffff810ac24b:	a8 01                	test   $0x1,%al
ffffffff810ac24d:	0f 85 45 ff ff ff    	jne    ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac253:	e8 08 f9 ff ff       	callq  ffffffff810abb60 <__ipipe_do_sync_stage>
ffffffff810ac258:	e9 3b ff ff ff       	jmpq   ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac25d:	0f 1f 00             	nopl   (%rax)
ffffffff810ac260:	49 83 7c 24 08 00    	cmpq   $0x0,0x8(%r12)
ffffffff810ac266:	0f 84 2c ff ff ff    	je     ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac26c:	0f 1f 40 00          	nopl   0x0(%rax)
ffffffff810ac270:	eb e1                	jmp    ffffffff810ac253 <__ipipe_dispatch_irq+0x233>
ffffffff810ac272:	45 31 f6             	xor    %r14d,%r14d
ffffffff810ac275:	31 c0                	xor    %eax,%eax
ffffffff810ac277:	e9 e8 fd ff ff       	jmpq   ffffffff810ac064 <__ipipe_dispatch_irq+0x44>
ffffffff810ac27c:	89 de                	mov    %ebx,%esi
ffffffff810ac27e:	e8 7d eb ff ff       	callq  ffffffff810aae00 <__ipipe_set_irq_pending>
ffffffff810ac283:	e9 10 ff ff ff       	jmpq   ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac288:	89 de                	mov    %ebx,%esi
ffffffff810ac28a:	48 89 c7             	mov    %rax,%rdi
ffffffff810ac28d:	e8 6e eb ff ff       	callq  ffffffff810aae00 <__ipipe_set_irq_pending>
ffffffff810ac292:	e9 01 ff ff ff       	jmpq   ffffffff810ac198 <__ipipe_dispatch_irq+0x178>
ffffffff810ac297:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
ffffffff810ac29e:	00 00

Thanks,

Jeff


