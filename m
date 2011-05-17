Message-ID: <4DD280F1.3060109@domain.hid>
Date: Tue, 17 May 2011 16:06:41 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>	<4DCD2EE8.2010904@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>	<4DD102DA.9080206@domain.hid>	<4DD107AD.5000307@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910F@ontex.i.omicron.de>	<4DD13882.8000708@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B9110@domain.hid>	<4DD22053.5030502@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B9111@domain.hid>	<4DD23F8A.5000107@domain.hid>
	<4DD257F5.7010408@domain.hid>
	<89B30389DB4AE240AC1227F3FDBB7CCF029B9115@domain.hid>
In-Reply-To: <89B30389DB4AE240AC1227F3FDBB7CCF029B9115@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Koenig, Florian" <F.Koenig@domain.hid>
Cc: xenomai@xenomai.org

On 05/17/2011 03:21 PM, Koenig, Florian wrote:
> Hi,
> in linux-2.6.36 menuconfig is in Real-time syste/nucleus/machine only "Enable
> unlocked context switch" to choose, no hw-fpu ?
> 
> 
>> You can set CONFIG_XENO_HW_FPU, it is located in the "Real-time
>> system"/"nucleus"/"Machine" menu.

I had a closer look:

Symbol: XENO_HW_FPU [=n]
   Type  : boolean
   Prompt: Enable FPU support
     Defined at arch/powerpc/xenomai/Kconfig:24
     Depends on: XENO_OPT_NUCLEUS [=y] && PPC_FPU [=n]
     Location:
       -> Real-time sub-system
         -> Nucleus (XENO_OPT_NUCLEUS [=y])
           -> Machine

It depends on PPC_FPU and therefore the option is not selectable
for a system without FPU. I'm really surprised that it is on
for your 405GP board. Maybe your BSP is broken.

Wolfgang.

