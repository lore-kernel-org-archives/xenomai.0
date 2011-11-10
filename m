Message-ID: <4EBC3D9A.5050508@domain.hid>
Date: Thu, 10 Nov 2011 22:09:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2AB71B0EA2424A6C953F1BA9E4D51A79@domain.hid>	<4EBB9104.2040203@domain.hid>	<11B729797A9E4CD7AF3075EF6A450D57@domain.hid>
	<4EBC3043.7080001@domain.hid>
In-Reply-To: <4EBC3043.7080001@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai test progs segfault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 11/10/2011 09:12 PM, Gilles Chanteperdrix wrote:
> On 11/10/2011 09:09 PM, Terry Fryar wrote:
>> 2.6.0 worked fine with 2.6.38, although I did get this:
>>
>> [    4.900113] WARNING: at kernel/lockdep.c:2321 omap3_pm_idle+0x78/0x84()
>> [    4.907076] Modules linked in:
>> [    4.910532] [<c00572ac>] (unwind_backtrace+0x0/0xe0) from [<c0081164>]
>> (warn_slowpath_common+0x4c/0x64)
>> [    4.920564] [<c0081164>] (warn_slowpath_common+0x4c/0x64) from
>> [<c0081194>] (warn_slowpath_null+0x18/0x1c)
>> [    4.930865] [<c0081194>] (warn_slowpath_null+0x18/0x1c) from [<c0064268>]
>> (omap3_pm_idle+0x78/0x84)
>> [    4.940508] [<c0064268>] (omap3_pm_idle+0x78/0x84) from [<c005241c>]
>> (cpu_idle+0x6c/0xe4)
>> [    4.949116] [<c005241c>] (cpu_idle+0x6c/0xe4) from [<c00088bc>]
>> (start_kernel+0x2b0/0x30c)
>> [    4.957941] [<c00088bc>] (start_kernel+0x2b0/0x30c) from [<80008034>]
>> (0x80008034) 
>>
>> Not sure what's up here, but the xenomai kernel stuff loaded and the xenomai
>> test programs work just fine now.  I'm partially wondering if there were
>> mis-matched floating point compiler flags involved as well (2.6.0 doesn't
>> force any flags now).
>>
>> Thanks Gilles...your help is MUCH appreciated!
> 
> You should disable whatever option causes omap3_pm_idle to be called, as
> this will give bad latencies.
> 

You can not avoid omap3_pm_idle with a configuration option.
Fortunately, it does not enter deep sleep states, if you do not mount
debugfs and do not set sleep_while_idle to 1.

-- 
                                                                Gilles.

