Message-ID: <51431C55.8050304@hilscher.com>
Date: Fri, 15 Mar 2013 14:04:21 +0100
From: Jerome Poncin <JPoncin@hilscher.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>	<51361281.20307@hilscher.com>	<51364A61.3090002@xenomai.org>	<5136F9E9.9030604@hilscher.com>	<5136FC1E.6060608@xenomai.org>	<51371B89.4020103@hilscher.com>	<513730CE.2070102@xenomai.org>	<51374B98.7030103@hilscher.com>	<51376093.7060701@siemens.com>	<5137AF89.1020009@xenomai.org>	<5138B33C.1060506@hilscher.com>	<5139BABA.8010602@hilscher.com>	<5139D7F5.2090904@xenomai.org>
	<513EF0F0.4070705@hilscher.com>	<513F1DBD.5090603@xenomai.org>
	<513F4944.9010202@hilscher.com> <513F8434.6070405@xenomai.org>
	<51405E4A.9010607@hilscher.com> <5142E55E.4090705@hilscher.com>
	<51430107.3060600@siemens.com>
In-Reply-To: <51430107.3060600@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 15/03/2013 12:07, Jan Kiszka a écrit :
> On 2013-03-15 10:09, Jerome Poncin wrote:
>> Le 13/03/2013 12:08, Jerome Poncin a écrit :
>>> Le 12/03/2013 20:38, Gilles Chanteperdrix a écrit :
>>>> On 03/12/2013 04:27 PM, Jerome Poncin wrote:
>>>>
>>>>> Le 12/03/2013 13:21, Gilles Chanteperdrix a écrit :
>>>>>> On 03/12/2013 10:10 AM, Jerome Poncin wrote:
>>>>>>
>>>>>>> Le 08/03/2013 13:22, Gilles Chanteperdrix a écrit :
>>>>>>>> On 03/08/2013 11:17 AM, Jerome Poncin wrote:
>>>>>>>>
>>>>>>>>> Le 07/03/2013 16:33, Jerome Poncin a écrit :
>>>>>>>>>> Le 06/03/2013 22:05, Gilles Chanteperdrix a écrit :
>>>>>>>>>>> On 03/06/2013 04:28 PM, Jan Kiszka wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Also here: Do not misuse write(), define an IOCTL that contains
>>>>>>>>>>>> something like "MMAP" and another one with MUNMAP in its name
>>>>>>>>>>>> - that's
>>>>>>>>>>>> the purpose of this service, no?
>>>>>>>>>>> A lot of drivers probably have to reinvent a way to pass all the
>>>>>>>>>>> parameters for an mmap, why not adding an "mmap" method to
>>>>>>>>>>> RTDM drivers?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> I  re factored my code with all your remarks (I think and I hope).
>>>>>>>>>>
>>>>>>>>>> Could you say me if it's correct now ?
>>>>>>>>>>
>>>>>>>>>> Jan, you're right, It's possible to use Xenomai with UIO
>>>>>>>>>> driver, but I
>>>>>>>>>> would like to use more real time possibilities of Xenomai in
>>>>>>>>>> future
>>>>>>>>>> (like IRQ).
>>>>>>>>>> My first goal is to have a code compliant.
>>>>>>>>>> I added IRQ, and my next step will be to understand why the kernel
>>>>>>>>>> crash after IRQ registration.
>>>>>>>>>>
>>>>>>>>>> Thank you for your help,
>>>>>>>>>>
>>>>>>>>>> Jerome
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> I have good news because, I arrived to validated driver with IRQ
>>>>>>>>> support. I changed position of cifx on my motherboard in my PC
>>>>>>>>> and the
>>>>>>>>> IRQ affected is not shared ;-) !
>>>>>>>>>
>>>>>>>>> I have now a question about IRQ. What is the good method to
>>>>>>>>> signal to
>>>>>>>>> user-land that there is an IRQ. Is there an example ?
>>>>>>>> Almost every "read" call is an example... ;-)
>>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> I'm finishing my driver with IRQ. I saw that there is two mode, Real
>>>>>>> time and Non real time for RTDM driver function.
>>>>>>> My driver should run in the two mode. When I compile my User Space
>>>>>>> Shared library that call Xenomai Kernel driver,
>>>>>>> I saw that library call every time Non real time function and no real
>>>>>>> time function...
>>>>>>> I use a shared library with posix skin with makefile in attached
>>>>>>> file. I
>>>>>>> read explanation for static library with posix skin :
>>>>>>>
>>>>>>> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
>>>>>>>
>>>>>>>
>>>>>>> What must I do with shared library for using rt mode ?
>>>>>> Use the LDLIBS variable when linking the library?
>>>>>>
>>>>> Gilles,
>>>>>
>>>>> you're right ;-), I didn't use LDLIBS for linking the library,
>>>>> therefore
>>>>> I corrected this.
>>>>>
>>>>> Now I have this as link line for my library :
>>>>>
>>>>> gcc -shared -Xlinker -rpath -Xlinker /usr/xenomai/lib
>>>>> -I/usr/xenomai/include/include/xenomai
>>>>> -I/usr/xenomai/include/include/xenomai/compat
>>>>> -I/usr/xenomai/include/include/xenomai/posix -I./ -I.//Toolkit
>>>>> -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
>>>>> -lxenomai -lpthread -lrt -o libcifx.so .//cifXDownload.o
>>>>> .//cifXEndianess.o .//cifXFunctions.o .//cifXHWFunctions.o
>>>>> .//cifXInit.o
>>>>> .//cifXInterrupt.o .//md5.o   .//cifx_xenomai.o .//OS_xenomai.o
>>>>> .//USER_xenomai.o
>>>>>
>>>>> and this for the application :
>>>>>
>>>>> gcc -DCONSUMER -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
>>>>> -D__XENO__ -I/usr/xenomai/include/posix -I../libcifx
>>>>> -I../libcifx/Toolkit -O2   -lcifx -lpciaccess -lrtdm -Xlinker -rpath
>>>>> -Xlinker /usr/xenomai/lib  cifx_xenomai_sample.c
>>>>> -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt
>>>>> -lxenomai -lpthread -lrt -lcifx -lpciaccess -lrtdm -o
>>>>> cifx_xenomai_sample
>>>>>
>>>>> with
>>>>>
>>>>> mlockall(MCL_CURRENT | MCL_FUTURE);
>>>>>
>>>>>
>>>>> first line in main
>>>>>
>>>>> I have a new log :
>>>>>
>>>>> [ 4700.073616] cifx 0000:04:01.0: PCI INT A -> GSI 16 (level, low)
>>>>> -> IRQ 16
>>>>> [ 4700.073643] cifx 0000:04:01.0: DPM at FEBF0000
>>>>> [ 4700.073654] cifx 0000:04:01.0: registered CifX card
>>>>> [ 4734.146888] NRT mode
>>>>> [ 4751.104009] rt
>>>>> [ 4751.388002] Xenomai: Posix: destroying mutex f8419600.
>>>>>
>>>>> But as you see It seems I'm always in Non Real Time mode...
>>>> I do not see anything, as I do not see the sources for either your
>>>> driver or application.
>>>>
>>>>> Do you have an idea about my problem ?
>>>>>
>>>>> The log "rt" and " Xenomai: Posix: destroying mutex f8419600." is
>>>>> normal ?
>>>> It depends if you consider normal leaving an application with a mutex
>>>> created but not destroyed.
>>> Hello Gilles,
>>>
>>> First, I checked mutex Creation and Destroy and all is correct all
>>> created are destroyed... I will continue to investigate, it's very
>>> strange !
>>> Secondly, I read that if a program use file or stdio library "causes
>>> switches to secondary mode".
>>> In my shared library, I have read file and fprintf at start
>>> (initialization), therefore I think that's why the library run in NRT
>>> mode.
>>> But is possible to switch in RT mode after, or must I do two thread ?
>>>
>>> thank you for your help,
>>>
>>> Jerome
>> Hello,
>>
>> I found why I have the log :
>>
>> Xenomai: Posix: destroying mutex f8419600.
>>
>> My application seems stop by the watchdog :
>>
>> Temps UCT limite expiré (core dumped)
>>
>> I tried to disable Xenomai watchdog without success, and I try to
>> increase "ulimit" without success too.
>>
>> How to disable CPU time watchdog for real time mode ?
> The problem is not the watchdog but some bug in your application or
> driver. It causes a real-time task to run for multiple seconds without
> sleeping. That is what the watchdog triggers. Check what is causing this
> endless loop and resolve it.
>
> Jan
>
Hello Jan,

Yes you're right. I have 1 thread for test (main) application and the 
driver create one or two thread if IRQ or polling is enable.
The driver thread are loop waiting event with delay.
At Driver start it take few second to download firmware and configuration.
My question is why it's a problem to have a real time that that run few 
second.
If this task have the bigger priority, it's normal to not release hand 
and to not sleep, I'm right or not ?

Thank you for your help,

Jerome






