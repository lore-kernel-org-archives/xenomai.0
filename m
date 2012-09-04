MIME-Version: 1.0
In-Reply-To: <50460BCE.8010505@xenomai.org>
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>
	<50460BCE.8010505@xenomai.org>
Date: Tue, 4 Sep 2012 16:28:08 +0200
Message-ID: <CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Sep 4, 2012 at 4:10 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/04/2012 03:42 PM, Henri Roosen wrote:
>> Hi,
>>
>> I'm using the bleeding edge of Xenomai (0590cb45adce468f619) and Ipipe
>> (d21e8cdbdcf21ade) on a x86 multicore system and kernel 3.4.6.
>> I reserved one cpu (kernel param isolcpus=1).
>>
>> Our application triggers the following NULL pointer dereference when I
>> set the affinity of some tasks to cpu 0 and other tasks to cpu 1.
>> The application does not trigger this when all tasks have the same
>> affinity (set via /proc/xenomai/affinity).
>>
>> I was able to reproduce this also under QEMU and will do some
>> debugging, but maybe someone knows what is wrong already by seeing the
>> stacktrace below:
>
> Could you try to reduce the bug to a simple testcase which we would try
> and run to reproduce?
>
>> [  108.013023] BUG: unable to handle kernel NULL pointer dereference
> at 00000294
>> [  108.013550] IP: [<c0126a91>] __lock_task_sighand+0x53/0xc3
>
> Or send us a disassembly of the function __lock_task_sighand?

Please find the disassembly of the __lock_task_sighand below:

00000e3a <__lock_task_sighand>:
     e3a:       55                      push   %ebp
     e3b:       89 e5                   mov    %esp,%ebp
     e3d:       57                      push   %edi
     e3e:       89 d7                   mov    %edx,%edi
     e40:       56                      push   %esi
     e41:       53                      push   %ebx
     e42:       83 ec 08                sub    $0x8,%esp
     e45:       89 45 ec                mov    %eax,-0x14(%ebp)
     e48:       05 94 02 00 00          add    $0x294,%eax
     e4d:       89 45 f0                mov    %eax,-0x10(%ebp)
     e50:       9c                      pushf
     e51:       fa                      cli
     e52:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
     e58:       8d 80 00 00 00 00       lea    0x0(%eax),%eax
     e5e:       0f ba 20 00             btl    $0x0,(%eax)
     e62:       19 d2                   sbb    %edx,%edx
     e64:       9d                      popf
     e65:       83 fa 01                cmp    $0x1,%edx
     e68:       19 d2                   sbb    %edx,%edx
     e6a:       81 e2 00 02 00 00       and    $0x200,%edx
     e70:       9c                      pushf
     e71:       fa                      cli
     e72:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
     e78:       8d 80 00 00 00 00       lea    0x0(%eax),%eax
     e7e:       0f ba 28 00             btsl   $0x0,(%eax)
     e82:       9d                      popf
     e83:       89 17                   mov    %edx,(%edi)
     e85:       e8 fc ff ff ff          call   e86 <__lock_task_sighand+0x4c>
     e8a:       8b 45 f0                mov    -0x10(%ebp),%eax
     e8d:       8b 30                   mov    (%eax),%esi
     e8f:       85 f6                   test   %esi,%esi
     e91:       75 1c                   jne    eaf <__lock_task_sighand+0x75>
     e93:       e8 fc ff ff ff          call   e94 <__lock_task_sighand+0x5a>
     e98:       8b 07                   mov    (%edi),%eax
     e9a:       f6 c4 02                test   $0x2,%ah
     e9d:       75 07                   jne    ea6 <__lock_task_sighand+0x6c>
     e9f:       b8 01 00 00 00          mov    $0x1,%eax
     ea4:       eb 02                   jmp    ea8 <__lock_task_sighand+0x6e>
     ea6:       31 c0                   xor    %eax,%eax
     ea8:       e8 fc ff ff ff          call   ea9 <__lock_task_sighand+0x6f>
     ead:       eb 45                   jmp    ef4 <__lock_task_sighand+0xba>
     eaf:       8d 9e 04 05 00 00       lea    0x504(%esi),%ebx
     eb5:       89 d8                   mov    %ebx,%eax
     eb7:       e8 fc ff ff ff          call   eb8 <__lock_task_sighand+0x7e>
     ebc:       8b 45 ec                mov    -0x14(%ebp),%eax
     ebf:       3b b0 94 02 00 00       cmp    0x294(%eax),%esi
     ec5:       75 07                   jne    ece <__lock_task_sighand+0x94>
     ec7:       e8 fc ff ff ff          call   ec8 <__lock_task_sighand+0x8e>
     ecc:       eb 26                   jmp    ef4 <__lock_task_sighand+0xba>
     ece:       89 d8                   mov    %ebx,%eax
     ed0:       e8 fc ff ff ff          call   ed1 <__lock_task_sighand+0x97>
     ed5:       e8 fc ff ff ff          call   ed6 <__lock_task_sighand+0x9c>
     eda:       8b 07                   mov    (%edi),%eax
     edc:       f6 c4 02                test   $0x2,%ah
     edf:       75 07                   jne    ee8 <__lock_task_sighand+0xae>
     ee1:       b8 01 00 00 00          mov    $0x1,%eax
     ee6:       eb 02                   jmp    eea <__lock_task_sighand+0xb0>
     ee8:       31 c0                   xor    %eax,%eax
     eea:       e8 fc ff ff ff          call   eeb <__lock_task_sighand+0xb1>
     eef:       e9 5c ff ff ff          jmp    e50 <__lock_task_sighand+0x16>
     ef4:       59                      pop    %ecx
     ef5:       89 f0                   mov    %esi,%eax
     ef7:       5b                      pop    %ebx
     ef8:       5b                      pop    %ebx
     ef9:       5e                      pop    %esi
     efa:       5f                      pop    %edi
     efb:       5d                      pop    %ebp
     efc:       c3                      ret


>
> --
>                                             Gilles.

