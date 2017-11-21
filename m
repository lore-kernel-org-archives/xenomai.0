From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
References: <6c55f15a-66ea-a9cd-943b-ed568f229984@xenomai.org>
 <85bfdeed-375d-7073-a53f-d9d5d22f8778@alaxarxa.net>
 <62be2b45-b6f7-30b9-b3ee-891acd75ac60@xenomai.org>
 <4651e006-d67f-d442-bc12-d634ec78f897@alaxarxa.net>
 <f7f0cc07-b729-e116-82d1-fe1caecbe5c8@alaxarxa.net>
Message-ID: <7d1be9ab-9ba9-9724-375d-928731213673@alaxarxa.net>
Date: Tue, 21 Nov 2017 10:16:47 +0100
MIME-Version: 1.0
In-Reply-To: <f7f0cc07-b729-e116-82d1-fe1caecbe5c8@alaxarxa.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3.0.6 doesn't build the patched kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 20/11/17 17:26, Leopold Palomo-Avellaneda wrote:
> On 20/11/17 17:25, Leopold Palomo-Avellaneda wrote:
>> On 20/11/17 14:38, Philippe Gerum wrote:
>>> On 11/20/2017 01:14 PM, Leopold Palomo-Avellaneda wrote:
>>>> Hi,
>>>>
>>>> trying to build the new Xenomai version (3.0.6), after have prepared the linux
>>>> sources, I got this error:
>>>>
>>>> In file included from arch/x86/xenomai/machine.c:22:0:
>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function
>>>> ‘__xn_get_syscall_nr’:
>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h:46:31: error: implicit
>>>> declaration of function ‘__COBALT_CALL32_SYSNR’
>>>> [-Werror=implicit-function-declaration]
>>>>   #define __xn_syscall(regs)    __COBALT_CALL32_SYSNR(__xn_reg_sys(regs) \
>>>>                                 ^
>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:32: note: in expansion of
>>>> macro ‘__xn_syscall’
>>>>    return __xn_syscall_p(regs) ? __xn_syscall(regs) :
>>>>                                  ^~~~~~~~~~~~
>>>> cc1: some warnings being treated as errors
>>>>
>>>> I have used the prepare-kernel script and built the Debian packages. The
>>>> platform is a Debian Stretch (amd64) with the default compiler.
>>>>
>>>> linux version linux-4.9.51 and
>>>>
>>>> http://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.9.51-x86-4.patch
>>>>
>>>> as a patch.
>>>>
>>>>
>>>>
>>>
>>> As a work around, drop CONFIG_IA32_EMULATION if you don't need it.
>>>

Hi,

trying to compile again I found some ugly warnings (gcc-6)

############################################
drivers/xenomai/analogy/buffer.c: In function ‘a4l_ioctl_bufcfg’:
drivers/xenomai/analogy/buffer.c:611:38: warning: ‘*((void *)&buf_cfg+8)’ may be
used uninitialized in this function [-Wmaybe-uninitialized]
   cxt->dev->transfer.default_bufsize = buf_cfg.buf_size;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~


############################################
drivers/xenomai/can/sja1000/rtcan_adv_pci.c: In function ‘rtcan_adv_pci_add_chan’:
drivers/xenomai/can/sja1000/rtcan_adv_pci.c:163:3: warning: this ‘else’ clause
does not guard... [-Wmisleading-indentation]
   else
   ^~~~
drivers/xenomai/can/sja1000/rtcan_adv_pci.c:165:4: note: ...this statement, but
the latter is misleadingly indented as if it is guarded by the ‘else’
    if (!base_addr) {
    ^~

############################################

drivers/xenomai/net/stack/rtwlan.c:171:2: warning: this ‘if’ clause does not
guard... [-Wmisleading-indentation]
  if (mutex_lock_interruptible(&rtdev->nrt_lock))
  ^~



and some erros with 'debug'

./arch/x86/include/asm/traps.h:13:17: error: ‘debug’ redeclared as different
kind of symbol
 asmlinkage void debug(void);
                 ^~~~~
drivers/xenomai/net/drivers/eepro100.c:55:12: note: previous definition of
‘debug’ was here
 static int debug = -1; /* The debug level */
            ^~~~~
In file included from ./include/linux/module.h:18:0,
                 from drivers/xenomai/net/drivers/eepro100.c:85:
drivers/xenomai/net/drivers/eepro100.c: In function ‘__check_debug’:
./include/linux/moduleparam.h:146:27: error: return from incompatible pointer
type [-Werror=incompatible-pointer-types]
  param_check_##type(name, &(value));       \
                           ^
./include/linux/moduleparam.h:344:68: note: in definition of macro ‘__param_check’
  static inline type __always_unused *__check_##name(void) { return(p); }
                                                                    ^
./include/linux/moduleparam.h:146:2: note: in expansion of macro ‘param_check_int’
  param_check_##type(name, &(value));       \
  ^~~~~~~~~~~~
./include/linux/moduleparam.h:126:2: note: in expansion of macro
‘module_param_named’
  module_param_named(name, name, type, perm)
  ^~~~~~~~~~~~~~~~~~
drivers/xenomai/net/drivers/eepro100.c:123:1: note: in expansion of macro
‘module_param’
 module_param(debug, int, 0444);
 ^~~~~~~~~~~~
drivers/xenomai/net/drivers/eepro100.c: In function ‘eepro100_init_module’:
drivers/xenomai/net/drivers/eepro100.c:1832:8: error: lvalue required as left
operand of assignment
  debug = speedo_debug; /* touch debug variable */
        ^
At top level:
drivers/xenomai/net/drivers/eepro100.c:55:12: warning: ‘debug’ defined but not
used [-Wunused-variable]
 static int debug = -1; /* The debug level */
            ^~~~~


######################################################


drivers/xenomai/net/drivers/natsemi.c:199:12: error: ‘debug’ redeclared as
different kind of symbol
 static int debug = -1;
            ^~~~~
In file included from arch/x86/xenomai/include/asm/xenomai/thread.h:25:0,
                 from include/xenomai/cobalt/kernel/thread.h:35,
                 from include/xenomai/cobalt/kernel/sched.h:24,
                 from include/xenomai/rtdm/driver.h:37,
                 from drivers/xenomai/net/stack/include/rtnet.h:99,
                 from drivers/xenomai/net/stack/include/rtskb.h:32,
                 from drivers/xenomai/net/stack/include/rtdev.h:37,
                 from drivers/xenomai/net/stack/include/rtnet_port.h:32,
                 from drivers/xenomai/net/drivers/natsemi.c:175:
./arch/x86/include/asm/traps.h:13:17: note: previous declaration of ‘debug’ was here
 asmlinkage void debug(void);
                 ^~~~~


######################################################

drivers/xenomai/net/drivers/pcnet32.c:1458:12: error: ‘debug’ redeclared as
different kind of symbol
 static int debug = -1;
            ^~~~~
In file included from arch/x86/xenomai/include/asm/xenomai/thread.h:25:0,
                 from include/xenomai/cobalt/kernel/thread.h:35,
                 from include/xenomai/cobalt/kernel/sched.h:24,
                 from include/xenomai/rtdm/driver.h:37,
                 from drivers/xenomai/net/stack/include/rtnet.h:99,
                 from drivers/xenomai/net/stack/include/rtskb.h:32,
                 from drivers/xenomai/net/stack/include/rtdev.h:37,
                 from drivers/xenomai/net/stack/include/rtnet_port.h:32,
                 from drivers/xenomai/net/drivers/pcnet32.c:60:
./arch/x86/include/asm/traps.h:13:17: note: previous declaration of ‘debug’ was here
 asmlinkage void debug(void);
                 ^~~~~


it's strange to me because 3.0.5 built without any problems. Probably I activate
something in the kernel that provoke the errors. Any idea?.


Best regards,

Leopold


-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

