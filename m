Message-ID: <4FEB32B2.6080700@xenomai.org>
Date: Wed, 27 Jun 2012 18:20:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <009c01cd539e$e9f81420$bde83c60$@com>	<4FE9BDA9.3000209@xenomai.org>
	<013901cd547a$50179b00$f046d100$@com>
In-Reply-To: <013901cd547a$50179b00$f046d100$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM, exception #0 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: xenomai@xenomai.org

On 06/27/2012 05:34 PM, George Pontis wrote:
> 
>> On 06/26/2012 03:23 PM, George Pontis wrote:
>>> Running Xenomai 2.6.0 on an ARM at91sam9g45. I recently updated
>>> from
>> Adeos
>>> patch adeos-ipipe-3.0.13-arm-1.18-05 to
>>> adeos-ipipe-3.0.13-arm-1.18-
>> 09. Then
>>> built a new kernel and gave it to the application developers for
>>> a
>> test.
>>> There were other changes in the root FS and a few tweaks in the
>> kernel, but
>>> none that looked (to me) like they would affect Xenomai. They
>>> report
>> this
>>> new error:
>>> 
>>>> Xenomai: Switching ADC Task to secondary mode after exception
>>>> #0
>> from
>>>> user-space at 0xffff0fbc (pid 723)
>>> 
>>> And then nothing about the app works any more. What does this
>>> mean ?
>> 
>> It means there is a fault, when the PC is around 0xffff0fbc, that
>> is in the tsc emulation kernel helper. Could you try reverting this
>> commit ?
>> 
> 
> I tried reverting to adeos-ipipe-3.0.13-arm-1.18-05 without any other
> changes, and this error still occurs. The address of the exception is
> exactly the same. So I did some experiments to try to narrow this
> down. First thing, it does not happen with any Xenomai user app. I
> wrote a different app some time ago that runs without error on all
> the Xenomai-enabled kernels.
> 
> I also went back to a previous kernel where this app runs without
> causing the error. That kernel was the same 3.0.13 with
> adeos-ipipe-3.0.13-arm-1.18-05.patch and the same Xenomai 2.6.0. The
> root FS was identical. Everything was built with the same GCC 4.5.3.
> What was different about it were some other features that were
> enabled or disabled in the kernel. Possibly it is one or more of
> these changes that is aggravating the problem with this one app:
> 
> 1) Turned off JFFS2, IDE 2) Turned on ext4 support 3) Enabled Atmel
> FB and SPI-based touchscreen controller 4) Disabled shmem 5) Disabled
> UID16 and "sysctl syscall"
> 
> Do any of these seem like they could be a factor ? I should emphasize
> that we are still pretty new to Xenomai. It is more likely that we
> have made a mistake in the app than that there is a Xenomai bug that
> nobody else has caught yet. Any suggestions where to go next to get
> to the bottom of this ?

Try enabling CONFIG_DEBUG_USER, and adding user_debug=29 to the boot
arguments. This way, you will get a kernel trace when the fault happens
giving you more details (registers values and binary code). It would
also help if you could send me your vmlinux.

-- 
					    Gilles.

