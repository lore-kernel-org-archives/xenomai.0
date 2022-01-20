MIME-Version: 1.0
References: <CAAvDm6YgEyJuX98RzioWFTrWdY2zGDPGdptLnL9oivVHmsCZsg@mail.gmail.com>
 <CAAvDm6aoKx65CcipLG9t4MgmzKLhzkEtzAX_z23B5VUnw7iTUg@mail.gmail.com>
 <MN2PR11MB42859CE34F2CD706F90946D4F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB42857ACE5AA3060BC17341A2F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAAvDm6aRtpbcjqOuucPfxkGP=KNw+GSfTUfTu8e03=GRz4-qxA@mail.gmail.com>
 <MN2PR11MB42854BE231D5F7080F514DF0F25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB42850F0D987538BF443EFF98F25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAAvDm6ZJh_DGF07Pwsi0y8ft4Lw64sSC8kMGA0uBPzaT8h2-3Q@mail.gmail.com>
 <CAAvDm6YCxbErHvjz-pr-u8OO1_hhqxNQ88yhUnF6sYQAXmC=_g@mail.gmail.com>
 <MN2PR11MB4285FCBABC019AC49797554FF25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4285FCBABC019AC49797554FF25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Thu, 20 Jan 2022 16:25:52 +0800
Message-ID: <CAAvDm6akW-cZEdxz-i-qxibHZqyJ+9mV6vqPOa=7noYb2KUSAw@mail.gmail.com>
Subject: Re: About the kernel configuration(CONFIG_CPU_FREQ and
 CONFIG_CPU_IDLE.)
Content-Type: text/plain; charset="UTF-8"
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

> Please try if can enter into  advanced->power & performance -> CPU -
Power Management Control
>There should be C States items.

Thank you for your detailed explanation.
Though I have carefully checked every submenu, it's a pity that I really
can't find the
C-state items in the BIOS.

I think this BIOS may does not support to manually disable C-STATE.
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here are the menus that I can see.
Menu for advanced, see https://ibb.co/CMyNB6G
Menu for advanced->onboard devices, see https://ibb.co/tctP127
Menu for  performance&cooling, see https://ibb.co/vvnwzB1
Also, there no such menu items in main menu indeed.

On Thu, Jan 20, 2022 at 3:32 PM Chen, Hongzhan <hongzhan.chen@intel.com>
wrote:

> >From: ??? sunshilong <sunshilong369@gmail.com>
> >Sent: Thursday, January 20, 2022 3:12 PM
> >To: Chen, Hongzhan <hongzhan.chen@intel.com>
> >Cc: xenomai@xenomai.org
> >Subject: Re: About the kernel configuration(CONFIG_CPU_FREQ and
> CONFIG_CPU_IDLE.)
> >
> >>>Let us go back to what you found with disabling CPU_IDLE and CPU_FREQ.
> I do not know if you already disable C-state in BIOS.
> >>>But on my side, I found the similiar result with yours that cpu_freq is
> non-constant even if I disable CPUIDLE and CPUFREQ but
> >>>with enabling C-State in BIOS for my i7-8665U board. After I disable C
> state of BIOS , it became constant according to my test.
> >>
> >>I will disable C state in BIOS and try today.
> >I can't find the suitable menu to disable C-State in BIOS indeed.
> >I can see there are menus about "Deep S4/S5"?"PCIe ASPM Support" and
> >"Native ACPI OS PCIe Support"(for details, see the image at
> https://ibb.co/jgw7b19,).
> >Since there is no menu to disable C-State, I have tried to disable all
> >the aforementioned menus which have some relation with power management,
> >but the frequency of CPU(i.e. I7-8665U) is still not constant(seen at
> https://ibb.co/DkKZ2mZ).
> >
>
> Please try if can enter into  advanced->power & performance -> CPU - Power
> Management Control
>
> There should be C States items.
>
> Regards
>
> Hongzhan Chen
>
