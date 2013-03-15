Date: Fri, 15 Mar 2013 13:12:52 +0800 (CST)
From: =?GBK?B?zuK9o7fm?= <wu_jianfeng@126.com>
In-Reply-To: <mailman.99.1363213184.1444.xenomai@xenomai.org>
References: <mailman.99.1363213184.1444.xenomai@xenomai.org>
MIME-Version: 1.0
Message-ID: <428b89fe.a57d.13d6c7704d6.Coremail.wu_jianfeng@126.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Digest, Vol 11, Issue 32
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi
 
We have got a memory leak problem . The system config is Ubuntu 11.04 (linux kernel 2.6.38.8) ,Xenoami 2.6.0 and hardware was based on X86 .When we fininshed install the xenomai ,we found a strange  problem that is system memory is leaked . However you open any program the memory will increased ,but close the program the memory will never be free and just a little increased. For exampl(the system memory is 2G ,CPU is intel i7) ,open a Qt IDE ,memory will be increased 60Mbytes then closed it ,but the memory will not be free maybe just 10MB. Ifyou open and closed any software a lot of times ,the valid  system memory will be nothing(maybe 50MB only)  .We don't running any user application by us .
we really have no idea !
 
Our application is high speed Machine vision . We want use a task to check the camera pick imaged done signal by evry task cycle(500us), another Task  is for handle the image and analysis then sent to a signal to hardware . When we running our applicaton program the probelm is same ,system memor will be down again until the computer dead or the our program not working .
 
Please help us ,what is problem ?what is issue?
we have try a lot  in last weeks ,no idea !
 
thanks very much !!!
 
nick




 

At 2013-03-14 06:19:44,xenomai-request@xenomai.org wrote:
>Send Xenomai mailing list submissions to
>	xenomai@xenomai.org
>
>To subscribe or unsubscribe via the World Wide Web, visit
>	http://www.xenomai.org/mailman/listinfo/xenomai
>or, via email, send a message with subject or body 'help' to
>	xenomai-request@xenomai.org
>
>You can reach the person managing the list at
>	xenomai-owner@xenomai.org
>
>When replying, please edit your Subject line so it is more specific
>than "Re: Contents of Xenomai digest..."
>
>
>Today's Topics:
>
>   1. Re: about Xenomai in Debian and Ubuntu (Leopold Palomo-Avellaneda)
>   2. SMI handling on x86 (Jeroen Van den Keybus)
>   3. Re: [PATCH] Do not overwrite pre-existing SIGDEBUG handler in
>      xeno_skin_bind (Gilles Chanteperdrix)
>   4. Re: about Xenomai in Debian and Ubuntu (Gilles Chanteperdrix)
>   5. Re: about Xenomai in Debian and Ubuntu (Gilles Chanteperdrix)
>   6. Re: about Xenomai in Debian and Ubuntu (Gilles Chanteperdrix)
>   7. linkage problem under 2.6.2.1 (Tom Z)
>   8. Re: linkage problem under 2.6.2.1 (Gilles Chanteperdrix)
>   9. Re: SMI handling on x86 (Gilles Chanteperdrix)
>  10. Re: SMI handling on x86 (Jeroen Van den Keybus)
>  11. Re: SMI handling on x86 (Jeroen Van den Keybus)
>
>
>----------------------------------------------------------------------
>
>Message: 1
>Date: Wed, 13 Mar 2013 16:47:58 +0100
>From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
>To: xenomai@xenomai.org
>Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
>Message-ID: <201303131647.58842.leo@alaxarxa.net>
>Content-Type: Text/Plain;  charset="iso-8859-1"
>
>Hi, (I think that I always put Hi or Bones (in catalan ..),
>
>I would like to put some comments to this thread:
>
><Roland>
>I really understand that you will take care of the debian directory of the 
>upstream code. Probably I misunderstand something reading your posts ... I 
>understand Gilles mail.
>
>I propose to have two branches in the upstream tree, one with the necessary 
>stuff to create a kernel package for the debian stable tree (with their 
>kernel) and another for the sid/testing. This stuff could be the same of the 
>official ones. Maybe some submodules or another hyper-special characteristic 
>of git could help.
>
>I don't understand your tone in your last mails. I think that it has been a 
>misunderstanding problem. Please, _we_ can do it better.
></Roland>
>
><Gilles/Jan>
>Yes, I understand to St?phane. However as I'm in several projects, a lot of 
>mails and to much things and a few time to do it. I have had the same feeling, 
>but, well, maybe I begin to be a bit old and ....
>
>I send to patch to UPSTREAM not to debian packagers. The script belongs to 
>upstream. I had a bad feeling because no answer to the patch, no push. I had 
>to insist because the stupid error. But, rereading the mail I think that I 
>post it in a wrong and confusing way: mea culpa.
></Gilles/Jan>
>
>Regards,
>
>Leo
>-- 
>--
>Linux User 152692
>Catalonia
>
>
>
>------------------------------
>
>Message: 2
>Date: Wed, 13 Mar 2013 20:43:11 +0100
>From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>To: xenomai@xenomai.org
>Subject: [Xenomai] SMI handling on x86
>Message-ID:
>	<CAPRPZsBh=5TkR93kiQR8yg0ABfJZtwJ_piBQKAOznEWMppgCyw@mail.gmail.com>
>Content-Type: text/plain; charset=ISO-8859-1
>
>Hi,
>
>
>We have configured Linux 3.5.7 / Xenomai 2.6.2.1 on an MSI-7514 mainboard
>with a Core 2 Duo CPU.
>
>This configuration suffers from excessive worst-case latencies during the
>'latency' test (on average: 2.6 ?s, worst-case around 1900 ?s, around 10
>overruns per second). I believe these overruns are due to the CPUs entering
>SM mode (SMI). As soon as the ACPI BIOS SMI is disabled (when
>xeno_nucleus/native are loaded as a module), the computer shuts down in 5
>secs. or so. Presumably some power supply watchdog on the mainboard isn't
>triggered.
>
>- Has someone also observed this behaviour and maybe solved it in some way ?
>- I looked around in the Intel manuals and I don't think it's possible to
>have only 1 CPU handle these SMIs. Is that correct ? If it were possible,
>we could run RT tasks on the other one, obviously, but currently latency
>shows overruns on both CPUs.
>- Would it somehow be possible/sensible to leave the SMI disabled and
>generically call the SMI handler directly from within (a task in) the OS ?
>There's probably going to be issues, the least of which would be proper
>handling of the RSM instruction outside SM mode. But still...
>
>
>Jeroen.
>
>
>------------------------------
>
>Message: 3
>Date: Wed, 13 Mar 2013 21:53:09 +0100
>From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>To: Jan Kiszka <jan.kiszka@siemens.com>
>Cc: Xenomai <xenomai@xenomai.org>
>Subject: Re: [Xenomai] [PATCH] Do not overwrite pre-existing SIGDEBUG
>	handler in	xeno_skin_bind
>Message-ID: <5140E735.5050603@xenomai.org>
>Content-Type: text/plain; charset=UTF-8
>
>On 03/13/2013 03:53 PM, Jan Kiszka wrote:
>
>> In case the application already set a SIGDEBUG handler, let that one
>> handle any potential SIGDEBUG_NOMLOCK events and keep our handler
>> (xeno_handle_mlock_alert) out of the loop. This helps in scenarios where
>> skin libraries are loaded belatedly via dlopen.
>
>
>Another option would be to save the previous handler, and call it when
>we detect the signal is not due to an mlock alert.
>
>-- 
>                                                                Gilles.
>
>
>
>------------------------------
>
>Message: 4
>Date: Wed, 13 Mar 2013 22:06:35 +0100
>From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>To: St?phane LOS <slos@hilscher.com>
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
>Message-ID: <5140EA5B.5030809@xenomai.org>
>Content-Type: text/plain; charset=UTF-8
>
>On 03/13/2013 10:40 AM, St?phane LOS wrote:
>
>> Hi,
>
>
>Hi,
>
>I have nothing to add to Jan's answer, except an answer to this specific
>remark:
>
>> I understand that FLOSS projects need to sell training and development 
>> but the cost would have cancelled the project since we don't think we 
>> could generate the cash to cover the expenses. So the driver is done on 
>> our free time.
>
>
>For what it is worth, there is no intention of selling anything when we
>do support. Just like you, I answer your questions during my free time.
>
>Regards.
>
>-- 
>                                                                Gilles.
>
>
>
>
>------------------------------
>
>Message: 5
>Date: Wed, 13 Mar 2013 22:12:22 +0100
>From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
>Message-ID: <5140EBB6.20205@xenomai.org>
>Content-Type: text/plain; charset=UTF-8
>
>On 03/13/2013 04:47 PM, Leopold Palomo-Avellaneda wrote:
>
>> Hi, (I think that I always put Hi or Bones (in catalan ..),
>> 
>> I would like to put some comments to this thread:
>> 
>> <Roland>
>> I really understand that you will take care of the debian directory of the 
>> upstream code. Probably I misunderstand something reading your posts ... I 
>> understand Gilles mail.
>> 
>> I propose to have two branches in the upstream tree, one with the necessary 
>> stuff to create a kernel package for the debian stable tree (with their 
>> kernel) and another for the sid/testing. This stuff could be the same of the 
>> official ones. Maybe some submodules or another hyper-special characteristic 
>> of git could help.
>> 
>> I don't understand your tone in your last mails. I think that it has been a 
>> misunderstanding problem. Please, _we_ can do it better.
>> </Roland>
>
>
>> 
>> <Gilles/Jan>
>> Yes, I understand to St?phane. However as I'm in several projects, a lot of 
>> mails and to much things and a few time to do it. I have had the same feeling, 
>> but, well, maybe I begin to be a bit old and ....
>> 
>> I send to patch to UPSTREAM not to debian packagers. The script belongs to 
>> upstream. I had a bad feeling because no answer to the patch, no push. I had 
>> to insist because the stupid error. But, rereading the mail I think that I 
>> post it in a wrong and confusing way: mea culpa.
>> </Gilles/Jan>
>
>
>Hi Leopold,
>
>Yes, there was a misunderstanding, but ultimately, I am the one who did
>the release, so, I could have tried to fix things. The truth is that I
>simply forgot the issue you reported. So, mea culpa.
>
>As for maintaing two debian directories, this is a bad idea, as long as
>we can make one which works for all releases, this is simply less work.
>So, let us keep it that way.
>
>Regards.
>
>-- 
>                                                                Gilles.
>
>
>
>
>------------------------------
>
>Message: 6
>Date: Wed, 13 Mar 2013 22:17:35 +0100
>From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>To: Roland Stigge <stigge@antcom.de>
>Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
>Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
>Message-ID: <5140ECEF.4050008@xenomai.org>
>Content-Type: text/plain; charset=UTF-8
>
>On 03/13/2013 01:53 PM, Roland Stigge wrote:
>> Hi Gilles,
>
>Hi Roland,
>
>> 
>>> I am not trying to blame you, I am trying to get a clear answer.
>>                                                      ^^^^^^^^^^^^
>> OK, under those circumstances of slightly diverging (i.e. minor but
>> conflicting in terms of project management) goals[1] I propose you commit
>> Xenomai's debian/* changes yourself without the need to wait for my comment.
>
>
>Ack.
>
>As a side note, each xenomai branch really is a "stable" branch, any
>kernel/user combinations of any two releases in the same branch are API
>and binary compatible, so, it would seem possible to consider every
>release as a security fix for the previous.
>
>Regards.
>
>-- 
>                                                                Gilles.
>
>
>
>------------------------------
>
>Message: 7
>Date: Wed, 13 Mar 2013 16:26:02 -0500
>From: Tom Z <tomz30@yahoo.com>
>To: xenomai@xenomai.org
>Subject: [Xenomai] linkage problem under 2.6.2.1
>Message-ID: <5140EEEA.2080209@yahoo.com>
>Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
>Hi,
>
>First I would like to sincerely thank all the people here that kindly 
>helped me with my previous problems regarding Xenomai installation.
>Now I got Xenomai 2.6.2.1 running on Ubuntu 12.04 (Linux-3.5.7) . I 
>added 
>"/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/include:/usr/local/lib" 
>to my $PATH, and can run "xeno latency" and "xeno-test".
>However, when I tried to compile this toy program found at 
>http://www.cs.ru.nl/lab/xenomai/ , I got some linage problems as follows:
>/tmp/ccwl2tpg.o: In function `main':
>ex01.c:(.text+0x8a): undefined reference to `rt_print_auto_init'
>ex01.c:(.text+0xa2): undefined reference to `rt_printf'
>ex01.c:(.text+0xe3): undefined reference to `rt_task_create'
>ex01.c:(.text+0xff): undefined reference to `rt_task_start'
>collect2: ld returned 1 exit status
>
>The above source code can be compiled & linked under Xenomai 2.4.3 
>smoothly, and I understand that the rtdk library had been moved to 
>libxenomai, so I changed the build flags accordingly. Below is what I 
>used to build the above toy program:
>gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
>-lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt -lxenomai ex01.c -o 
>ex01
>
>On my system, running "xeno-config --skin=native --cflags" gets 
>"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__",
>and running "xeno-config --skin=native --ldflags" gets "-lnative 
>-L/usr/xenomai/lib -lxenomai -lpthread -lrt".
>Under "/usr/xenomai/lib", I can find libnative.[a|la|so], 
>libxenomai.[a|la|so], and other libs.
>
>I don't understand why there are still undefined reference to 
>`rt_print_auto_init', etc. Did I miss something while building this program?
>
>With many thanks,
>Tom
>
>
>
>------------------------------
>
>Message: 8
>Date: Wed, 13 Mar 2013 22:39:06 +0100
>From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>To: Tom Z <tomz30@yahoo.com>
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai] linkage problem under 2.6.2.1
>Message-ID: <5140F1FA.6060205@xenomai.org>
>Content-Type: text/plain; charset=UTF-8
>
>On 03/13/2013 10:26 PM, Tom Z wrote:
>
>> Hi,
>
>
>Hi,
>
>> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
>> -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt -lxenomai ex01.c -o 
>> ex01
>
>
>The link order seems wrong.
>
>-- 
>                                                                Gilles.
>
>
>
>------------------------------
>
>Message: 9
>Date: Wed, 13 Mar 2013 22:40:27 +0100
>From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai] SMI handling on x86
>Message-ID: <5140F24B.7080900@xenomai.org>
>Content-Type: text/plain; charset=UTF-8
>
>On 03/13/2013 08:43 PM, Jeroen Van den Keybus wrote:
>
>> Hi,
>
>
>Hi,
>
>> 
>> 
>> We have configured Linux 3.5.7 / Xenomai 2.6.2.1 on an MSI-7514 mainboard
>> with a Core 2 Duo CPU.
>> 
>> This configuration suffers from excessive worst-case latencies during the
>> 'latency' test (on average: 2.6 ?s, worst-case around 1900 ?s, around 10
>> overruns per second). I believe these overruns are due to the CPUs entering
>> SM mode (SMI). As soon as the ACPI BIOS SMI
>
>
>Do you have ACPI enabled in the kernel configuration?
>
>-- 
>                                                                Gilles.
>
>
>
>
>------------------------------
>
>Message: 10
>Date: Wed, 13 Mar 2013 22:59:12 +0100
>From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>To: xenomai@xenomai.org
>Subject: Re: [Xenomai] SMI handling on x86
>Message-ID:
>	<CAPRPZsCBku_sq49cBorxQXd1_TkZks17dE_iVkA03m=Z6b32EQ@mail.gmail.com>
>Content-Type: text/plain; charset=ISO-8859-1
>
>I don't have the .config at hand, but I believe so, yes. I did disable
>processor ACPI though.
>
>
>
>2013/3/13 Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>
>> I don't have the .config at hand, but I believe so, yes. I did disable
>> processor ACPIm though.
>>
>> Jeroen.
>>
>>
>
>
>------------------------------
>
>Message: 11
>Date: Wed, 13 Mar 2013 23:19:41 +0100
>From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>To: xenomai@xenomai.org
>Subject: Re: [Xenomai] SMI handling on x86
>Message-ID:
>	<CAPRPZsBCXx+qjLU18irLuLME3r3QpeMMrUjjbAnqfsZpQS3qrg@mail.gmail.com>
>Content-Type: text/plain; charset=ISO-8859-1
>
>Ok, I managed to get hold of the .config. I only retained those entries
>that seemed obviously relevant to ACPI.
>
>
># Power management and ACPI options
>#
># CONFIG_SUSPEND is not set
># CONFIG_HIBERNATION is not set
># CONFIG_PM_RUNTIME is not set
>CONFIG_ACPI=y
># CONFIG_ACPI_PROCFS is not set
># CONFIG_ACPI_PROCFS_POWER is not set
>CONFIG_ACPI_EC_DEBUGFS=m
># CONFIG_ACPI_PROC_EVENT is not set
># CONFIG_ACPI_AC is not set
># CONFIG_ACPI_BATTERY is not set
>CONFIG_ACPI_BUTTON=y
>CONFIG_ACPI_FAN=y
># CONFIG_ACPI_DOCK is not set
># CONFIG_ACPI_PROCESSOR is not set
>CONFIG_ACPI_CUSTOM_DSDT_FILE=""
># CONFIG_ACPI_CUSTOM_DSDT is not set
>CONFIG_ACPI_BLACKLIST_YEAR=0
># CONFIG_ACPI_DEBUG is not set
># CONFIG_ACPI_PCI_SLOT is not set
>CONFIG_X86_PM_TIMER=y
>CONFIG_ACPI_CONTAINER=y
># CONFIG_ACPI_SBS is not set
># CONFIG_ACPI_HED is not set
># CONFIG_ACPI_CUSTOM_METHOD is not set
># CONFIG_ACPI_BGRT is not set
># CONFIG_ACPI_APEI is not set
># CONFIG_SFI is not set
>
>CONFIG_HOTPLUG_PCI_ACPI=m
>CONFIG_HOTPLUG_PCI_ACPI_IBM=m
>
>CONFIG_PNPACPI=y
>
>CONFIG_ATA_ACPI=y
>
># CONFIG_PATA_ACPI is not set
>
># ACPI drivers
>#
>CONFIG_I2C_SCMI=m
>
># ACPI drivers
>#
># CONFIG_SENSORS_ACPI_POWER is not set
># CONFIG_SENSORS_ATK0110 is not set
>CONFIG_THERMAL=y
>CONFIG_THERMAL_HWMON=y
># CONFIG_WATCHDOG is not set
>CONFIG_SSB_POSSIBLE=y
>
># CONFIG_THINKPAD_ACPI is not set
>CONFIG_ACPI_WMI=m
># CONFIG_ACPI_CMPC is not set
>
>
>2013/3/13 Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>
>> I don't have the .config at hand, but I believe so, yes. I did disable
>> processor ACPI though.
>>
>>
>>
>>
>> 2013/3/13 Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
>>
>>> I don't have the .config at hand, but I believe so, yes. I did disable
>>> processor ACPIm though.
>>>
>>> Jeroen.
>>>
>>>
>>
>
>
>------------------------------
>
>_______________________________________________
>Xenomai mailing list
>Xenomai@xenomai.org
>http://www.xenomai.org/mailman/listinfo/xenomai
>
>
>End of Xenomai Digest, Vol 11, Issue 32
>***************************************
