References: <tencent_2252D90437AFCF6B48706C45@qq.com>
 <e1bd3510-58dc-7ed2-ac0a-a0010eb43d73@alaxarxa.net>
 <20171121090129.5cc3e2a6@md1em3qc>
 <3bba77df-c130-b9d3-191b-3a7336b929d1@foxmail.com>
 <b68ddd18-e2e1-de26-c26e-8564bf8c1509@alaxarxa.net>
From: Jack Lee <jacklee11@foxmail.com>
Message-ID: <5e9304d5-16db-2bbf-2cb5-ce33f48054a4@foxmail.com>+40277C8B3484861C
Date: Thu, 23 Nov 2017 08:35:44 +0800
MIME-Version: 1.0
In-Reply-To: <b68ddd18-e2e1-de26-c26e-8564bf8c1509@alaxarxa.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] 3.0.6 with linux 4.9.51 on x86_64 Intel(R) Atom(TM)
 CPU N2800 compilation failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai <xenomai@xenomai.org>



On 11/22/2017 03:13 PM, Leopold Palomo-Avellaneda wrote:
> On 22/11/17 02:44, Jack Lee wrote:
>>
>> On 11/21/2017 04:01 PM, Henning Schild wrote:
>>> Am Tue, 21 Nov 2017 08:28:11 +0100
>>> schrieb Leopold Palomo-Avellaneda <leo@alaxarxa.net>:
>>>
>>>> On 21/11/17 06:52, Jack Lee wrote:
>>>>> Hello,
>>>>>
>>>>>     My board cpu is Intel Atom CPU N2800. I am using xenomai 3.0.6
>>>>> with linux 4.9.51. I get the following error when compiling the
>>>>> kernel. Can anyone give me some help? Thanks!
>>>>>
>>>>>     CC      arch/x86/xenomai/machine.o
>>>>> In file included from arch/x86/xenomai/machine.c:22:0:
>>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function
>>>>> ‘__xn_get_syscall_nr’:
>>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h:46:31: error:
>>>>> implicit declaration of function
>>>>> ‘__COBALT_CALL32_SYSNR’ [-Werror=implicit-function-declaration]
>>>>> #define __xn_syscall(regs)
>>>>> __COBALT_CALL32_SYSNR(__xn_reg_sys(regs) \ ^
>>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:32: note: in
>>>>> expansion of macro ‘__xn_syscall’ return __xn_syscall_p(regs) ?
>>>>> __xn_syscall(regs) :
>>>> I had the same problem yesterday and Philippe Gerum answered:
>>>>
>>>>>> As a work around, drop CONFIG_IA32_EMULATION if you don't need
>>>>>> it.
>> I tried it, but got another error.
>>
>> rivers/xenomai/net/drivers/eepro100.c: In function ‘eepro100_init_module’:
>> drivers/xenomai/net/drivers/eepro100.c:1832:8: error: lvalue required as left
>> operand of assignment
>>    debug = speedo_debug; /* touch debug variable */
>>          ^
> Please,
>
> cloud you check the lists emails of yesterday?. Robert Lange sent a patch to
> solve this, at least in the intel cards.
>
> Leopold
Sorry, I did find the solutions posted after I sent the two emails and 
too late to call back.
I found that you have a tough time with this project these days. I also 
appreciate
that many people responded to the email Philippe sent out. Hope you will 
conquer this and
have a bright future.

Have a nice day!




