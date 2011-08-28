Message-ID: <4E5A61DA.7000006@domain.hid>
Date: Sun, 28 Aug 2011 17:42:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKvQZ_06JKNPsiGeXOC1PEnc1Je5zSDSnX9AdOHT4eraggv7Eg@domain.hid>	<4E5A294C.1060205@domain.hid>
	<CAKvQZ_0mw_WT4s29_1_BBvm0fpqAzw-gDNYj3Jk3UQKQbmc8yw@domain.hid>
In-Reply-To: <CAKvQZ_0mw_WT4s29_1_BBvm0fpqAzw-gDNYj3Jk3UQKQbmc8yw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CPU frequency of 0 in a Vmware with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org

On 08/28/2011 05:00 PM, Willy Lambert wrote:
> 2011/8/28 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> On 08/28/2011 12:28 PM, Willy Lambert wrote:
>>> Hi all,
>>>
>>> I am trying to make xenomai running into a Debian Squeeze 32b with a
>> custom
>>> 2.6.38.8 kernel with xenomai among other things. I am running this into a
>>> Vmware for testing this before going on my real target.
>>>
>>> I have a "CPU frequency of 0" Error at boot, which I think is "classic"
>> with
>>> Vmwares :
>>> http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632
>>>
>>> ard@domain.hid:~$ dmesg | grep Xenomai
>>> [    0.559923] Xenomai has detected a CPU frequency of 0. Aborting.
>>> [    0.560923] Xenomai: system init failed, code -19.
>>> [    0.560923] Xenomai: native skin init failed, code -19.
>>> [    0.560923] Xenomai: starting POSIX services.
>>> [    0.561923] Xenomai: POSIX skin init failed, code -19.
>>> [    0.561923] Xenomai: RTDM skin init failed, code -19.
>>>
>>> But search didn't help me for this. See inclosed my .config (sorry it's a
>>> default-full option with initrd because I am failing on the "allnoconfig"
>>> little kernel for now). See below some extra informations about my system
>>
>> Well, there is not much we can do except telling you to use another
>> emulator than vmware. Such as qemu-kvm.
>>
>> You can try passing hardcoded frequencies to xenomai too, for instance,
>> passing on the kernel command line:
>>
>> xeno_hal.clockfreq=1600000000 xeno_hal.cpufreq=1600000000
>>
>>
> FYI, I tried this with 266666666 (my CPU is supposed to be 2.67 Ghz).  And
> it seems to work :
> 
> ard@domain.hid:~$ dmesg | grep -i xenomai
> [    0.551139] I-pipe: Domain Xenomai registered.
> [    0.551925] Xenomai: hal/i386 started.
> [    0.551925] Xenomai: scheduling class idle registered.
> [    0.551925] Xenomai: scheduling class rt registered.
> [    0.556205] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
> [    0.556782] Xenomai: debug mode enabled.
> [    0.557343] Xenomai: starting native API services.
> [    0.557880] Xenomai: starting POSIX services.
> [    0.557924] Xenomai: starting RTDM services.
> 
> then a latency test, seems very poor but I don't have crashes or freezes of
> my vm, so it's maybe enougth for the little tests we do here

No, it does not work. If it worked you would see large positive
latencies. But large negative latencies are a sign that the frequence
you chose is not correct.

-- 
                                                                Gilles.

