Message-ID: <54638058.10509@free.fr>
Date: Wed, 12 Nov 2014 16:44:24 +0100
From: Thierry Bultel <tbultel@free.fr>
MIME-Version: 1.0
References: <20141107195807.GD17476@sisyphus.hd.free.fr>
 <545FA90B.4040407@free.fr> <20141110123657.GJ17476@sisyphus.hd.free.fr>
 <54626A2E.6020307@free.fr> <20141111200358.GL17476@sisyphus.hd.free.fr>
 <54635DD7.9090800@free.fr> <20141112133447.GO17476@sisyphus.hd.free.fr>
 <54636E3F.1070207@free.fr> <20141112143026.GT17476@sisyphus.hd.free.fr>
 <54637AD2.3080507@free.fr> <20141112152940.GX17476@sisyphus.hd.free.fr>
In-Reply-To: <20141112152940.GX17476@sisyphus.hd.free.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: nicolas Mabire <nicolas.mabire@basystemes.fr>, xenomai@xenomai.org

Le 12/11/2014 16:29, Gilles Chanteperdrix a écrit :
> On Wed, Nov 12, 2014 at 04:20:50PM +0100, Thierry Bultel wrote:
>> Le 12/11/2014 15:30, Gilles Chanteperdrix a écrit :
>>> On Wed, Nov 12, 2014 at 03:27:11PM +0100, Thierry Bultel wrote:
>>>> Le 12/11/2014 14:34, Gilles Chanteperdrix a écrit :
>>>>> On Wed, Nov 12, 2014 at 02:17:11PM +0100, Thierry Bultel wrote:
>>>>>> Le 11/11/2014 21:03, Gilles Chanteperdrix a écrit :
>>>>>>> On Tue, Nov 11, 2014 at 08:57:34PM +0100, Thierry Bultel wrote:
>>>>>>>> Le 10/11/2014 13:36, Gilles Chanteperdrix a écrit :
>>>>>>>>> You can use printascii in the timer interrupt acknowledge routine to
>>>>>>>>> print a character every HZ ticks, this will give bad latency, but
>>>>>>>>> should work.
>>>>>>>>>
>>>>>>>>
>>>>>>>> For unknown reason, the kernel gets stuck after
>>>>>>>> "console [tty0] enabled, bootconsole disabled" if I use printascii
>>>>>>>> in do_local_timer().
>>>>>>>> earlyprintk seems broken as well.
>>>>>>>
>>>>>>> Without doing this, does earlyprintk work?
>>>>>>
>>>>>> No it does not. In fact, this kernel is strange with early debug.
>>>>>> Namely, even without earlyprintk, when it comes to disable the
>>>>>> bootconsole to use the normal one, it uses then re-prints everything
>>>>>> was printed before, making think that it has restarted from the
>>>>>> beginning.
>>>>>>
>>>>>> I confirm that calling printascii in do_local_timer() leads to a
>>>>>> kernel panic. Same thing if I use __ipipe_serial_debug instead.
>>>>>> I have used a counter (one per cpu) to start logging after 30000
>>>>>> ticks and it crashes after that delay.
>>>>>
>>>>> Having looked at the sources, I do not find a debug-macro.S for
>>>>> imx6. So, I doubt printascii can work at all. Maybe a first step is
>>>>> to implement this missing support.
>>>>
>>>> I think that the implementation is in arch/arm/plat-mxc/include
>>>> /mach/debug-macro.S
>>>
>>> And the debug UART you are using is UART2 ?
>>>
>> Yes,
>> and I have found out why the logs before the console switch were
>> displayed twice. This is because the BSP directly calls
>>
>> early_console_setup(UART2_BASE_ADDR, uart_clk);
>>
>> removing it does not make earlyprintk or printascii work better,
>> unfortunately.
>
> Do you get the "Uncompressing kernel..." message on the console?
>
This is all what I get when adding earlyprintk=serial,ttymxc1,115200 to 
the bootargs:


Uncompressing Linux... done, booting the kernel.
Linux version 3.0.43_4.1.0 (localuser@thierry-desktop) (gcc version 
4.7.3 (Buildroot 2014.02-rc3-g7ebc513) ) #20 SMP PREEMPT Wed Nov 12 
16:10:51 CET 2014
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale i.MX 6Quad VAB-820 Board
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writealloc
CPU identified as i.MX6Q, silicon rev 1.2

<nothing after>

