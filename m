Message-ID: <4DBA5F5C.9030607@domain.hid>
Date: Fri, 29 Apr 2011 08:49:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>	<4DB94BA0.1020503@domain.hid>	<4DB94C9C.7080904@domain.hid>	<4DB991E6.90403@domain.hid>	<4DB99E47.7000904@domain.hid>	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>	<4DB9B978.2010200@domain.hid>	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>	<4DB9C0D3.4030003@domain.hid>	<BANLkTikpH78xQ9Qx4sn=Hyeicfu3v9SP9w@domain.hid>
	<4DBA5E66.3000806@domain.hid>
In-Reply-To: <4DBA5E66.3000806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after
	switching	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

Gilles Chanteperdrix wrote:
> Alexey Galakhov wrote:
>> 2011/4/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>>> Maybe you can try booting with MMC disabled, to see if the I-pipe is
>>> working? Not permanently, just to confirm that you are not chasing the
>>> wrong bug.
>>>
>> Sure, that's exactly what I want to do. Unfortunately, I cannot boot to a
>> working system in that mode since I have root on SD card, but "Kernel panic
>> - unable to mount root fs" would indicate successful boot. I think also
>> about moving root somewhere else to be able to run tests ans examine /proc
>> and /sys under ipipe kernel.
> 
> Just made a rootfs for s3c, you can find it as a tar archive here:
> http://xenomai.org/~gch/rootfs-s3c.tar.bz2
> 
> or as a cpio archive to be used as an initramfs here:
> http://xenomai.org/~gch/initramfs-s3c.tar.bz2

s/.bz2/.gz/

-- 
                                                                Gilles.

