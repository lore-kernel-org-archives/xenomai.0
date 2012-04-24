Message-ID: <4F9665A5.3010902@domain.hid>
Date: Tue, 24 Apr 2012 10:34:45 +0200
From: Michael Trimarchi <michael@domain.hid>
MIME-Version: 1.0
References: <4F965F04.3060403@domain.hid>
	<4F965FB0.7030609@domain.hid>
In-Reply-To: <4F965FB0.7030609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 1/3] Fix hwtimer_uaccess in IMX architecture
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, b.morelli@domain.hid

On 04/24/2012 10:09 AM, Gilles Chanteperdrix wrote:
> On 04/24/2012 10:06 AM, Michael Trimarchi wrote:
>> Fix the code for IMX architectures in order to call the software
>> workaround to clear the off platform peripheral modules Supervisor
>> Protect clear the off platform peripheral modules Supervisor Protect
>> bit for the SDMA to access them.
>>
>> Signed-off-by: Michael Trimarchi <michael@domain.hid>
>> Signed-off-by: Bruno Morelli <b.morelli@domain.hid>
>> ---
>>  arch/arm/plat-mxc/devices.c |   14 +++++++-------
>>  1 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/plat-mxc/devices.c b/arch/arm/plat-mxc/devices.c
>> index 253b711..a2c0e66 100644
>> --- a/arch/arm/plat-mxc/devices.c
>> +++ b/arch/arm/plat-mxc/devices.c
>> @@ -93,19 +93,19 @@ err:
>>  
>>  static int post_cpu_init(void)
>>  {
>> -#ifdef CONFIG_MACH_MX27
>> +#ifdef CONFIG_ARCH_MX27
> 
> What kernel version are we talking about? In version 3.2.1, MACH_MX27 is
> still there and has not been replacced with ARCH_MX27
> 

Yes, it is strange. In linux 3.4.0

git grep ARCH_MX25 arch/arm/
arch/arm/mach-imx/Kconfig:config ARCH_MX25
arch/arm/mach-imx/Kconfig:      select ARCH_MX25
arch/arm/plat-mxc/devices/Kconfig:      default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX50 || SOC_IMX51 || SOC_IMX53

But it is different for the MX27

arch/arm/mach-imx/Kconfig:config MACH_MX27
arch/arm/mach-imx/Kconfig:      select MACH_MX27

I will fix

Michael

