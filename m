MIME-Version: 1.0
References: <CAAvDm6YgEyJuX98RzioWFTrWdY2zGDPGdptLnL9oivVHmsCZsg@mail.gmail.com>
 <CAAvDm6aoKx65CcipLG9t4MgmzKLhzkEtzAX_z23B5VUnw7iTUg@mail.gmail.com>
 <MN2PR11MB42859CE34F2CD706F90946D4F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB42857ACE5AA3060BC17341A2F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAAvDm6aRtpbcjqOuucPfxkGP=KNw+GSfTUfTu8e03=GRz4-qxA@mail.gmail.com>
 <MN2PR11MB42854BE231D5F7080F514DF0F25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB42850F0D987538BF443EFF98F25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAAvDm6ZJh_DGF07Pwsi0y8ft4Lw64sSC8kMGA0uBPzaT8h2-3Q@mail.gmail.com>
In-Reply-To: <CAAvDm6ZJh_DGF07Pwsi0y8ft4Lw64sSC8kMGA0uBPzaT8h2-3Q@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Thu, 20 Jan 2022 15:12:03 +0800
Message-ID: <CAAvDm6YCxbErHvjz-pr-u8OO1_hhqxNQ88yhUnF6sYQAXmC=_g@mail.gmail.com>
Subject: Re: About the kernel configuration(CONFIG_CPU_FREQ and
 CONFIG_CPU_IDLE.)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>>Let us go back to what you found with disabling CPU_IDLE and CPU_FREQ. I
do not know if you already disable C-state in BIOS.
>>But on my side, I found the similiar result with yours that cpu_freq is
non-constant even if I disable CPUIDLE and CPUFREQ but
>>with enabling C-State in BIOS for my i7-8665U board. After I disable C
state of BIOS , it became constant according to my test.
>
>I will disable C state in BIOS and try today.
I can't find the suitable menu to disable C-State in BIOS indeed.
I can see there are menus about "Deep S4/S5"=E3=80=81"PCIe ASPM Support" an=
d
"Native ACPI OS PCIe Support"(for details, see the image at
https://ibb.co/jgw7b19,).
Since there is no menu to disable C-State, I have tried to disable all
the aforementioned menus which have some relation with power management,
but the frequency of CPU(i.e. I7-8665U) is still not constant(seen at
https://ibb.co/DkKZ2mZ).

On Thu, Jan 20, 2022 at 2:24 PM =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong <sun=
shilong369@gmail.com>
wrote:

> >Let us go back to what you found with disabling CPU_IDLE and CPU_FREQ. I
> do not know if you already disable C-state in BIOS.
> >But on my side, I found the similiar result with yours that cpu_freq is
> non-constant even if I disable CPUIDLE and CPUFREQ but
> >with enabling C-State in BIOS for my i7-8665U board. After I disable C
> state of BIOS , it became constant according to my test.
>
> I will disable C state in BIOS and try today.
>
> >Let me correct something to avoid confusing.  Actually it is not constan=
t
> in my test , the cpu freq is about 1900Mhz keeping range
> >from 1899.* to 1900.* and having minor change.
> Yes, I also noticed such phenomenon with different CPU(i.e.
> UNO-2372G-J021AE) one and a half years ago.
> For this board with  i7-8565U, I really can't figure out why the
> frequency of the CPU is not constant.
> Thank you so much, you save me a lot of time.
>
>
> >
>
> On Thu, Jan 20, 2022 at 11:16 AM Chen, Hongzhan <hongzhan.chen@intel.com>
> wrote:
>
>>
>> >
>> >From: ??? sunshilong sunshilong369@gmail.com<mailto:
>> sunshilong369@gmail.com>
>> >>Sent: Wednesday, January 19, 2022 5:01 PM
>> >>To: Chen, Hongzhan hongzhan.chen@intel.com<mailto:
>> hongzhan.chen@intel.com>
>> >>Subject: Re: About the kernel configuration(CONFIG_CPU_FREQ and
>> CONFIG_CPU_IDLE.)
>> >>
>> >>> Did you use registers for computing the current frequency?
>> >>No, by cat /proc/cpuinfo.
>> >>How to use registers for computing the current frequency? Could you
>> please explain that in more detail for me?
>> >>
>> >>>In addition, x86 systems will no longer try to export their current
>> CPU frequency to /proc/cpuinfo since
>> >>Kernel 4.13.
>> >>But it seems still work because the value of the output of `cat
>> /proc/cpuinfo | grep -i mhz` is bigger when the system is busy,i.e:
>> >
>> >Yes , the output can be trusted because there is new patch
>> 7d5905dc14a87805a59f3c5bf70173aac2bb18f8 after 4.15 to make
>> >use of APERF/MPERF again to get cpu freq.
>> >
>> >Let us go back to what you found with disabling CPU_IDLE and CPU_FREQ. =
I
>> do not know if you already disable C-state in BIOS.
>> >But on my side, I found the similiar result with yours that cpu_freq is
>> non-constant even if I disable CPUIDLE and CPUFREQ but
>> >with enabling C-State in BIOS for my i7-8665U board. After I disable C
>> state of BIOS , it became constant according to my test.
>>
>> Let me correct something to avoid confusing.  Actually it is not constan=
t
>> in my test , the cpu freq is about 1900Mhz keeping range
>> from 1899.* to 1900.* and having minor change.
>>
>> Regards
>>
>> Hongzhan Chen
>>
>> >Please also disable Intel(R) SpeedStep which may also be related to
>> power saving/cpu scaling.
>> >
>> >Regards
>> >
>> >Hongzhan Chen
>> >
>> >>
>> >>
>> >>The output looks like this when idle:
>> >>model name      : Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz
>> >>cpu MHz         : 799.193
>> >>
>> >>When busy:
>> >>model name      : Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz
>> >>cpu MHz         : 3600.628
>>
>
