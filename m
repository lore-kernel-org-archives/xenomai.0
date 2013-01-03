Message-ID: <50E60EE9.9060909@xenomai.org>
Date: Fri, 04 Jan 2013 00:06:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>	<50E60647.5090309@xenomai.org>	<CAD1EtoiFivw1qesTzEUF9Scb-uMwMaJpnw18cJJ79DJQ3tejLw@mail.gmail.com>	<50E608CF.3020606@xenomai.org>	<CAD1EtoiHmA1YnRcoc-vHLT6BO1A61VuP9Ey+WWnoZS_7aOmYmQ@mail.gmail.com>	<50E60994.8010903@xenomai.org>	<CAD1Etohn+D9+8XebcRFj09hb=tbu_PgC_Tsx0bxLwMJ8w1xAzA@mail.gmail.com>	<50E60A3B.7040501@xenomai.org>	<CAD1EtojxM6PajHda1V4DZ0OqUMd-EtutiPmgtkYPnwKWG5Z30g@mail.gmail.com>	<50E60B67.7060401@xenomai.org>	<CAD1Etoi=F2Ds7hUCKZD7M2j2CT3FKo_5vkqY2O3mLwjBVHYG=A@mail.gmail.com>	<CAD1Etojxz1tt9wDxjO7ghQE95p8vbuT9r0b3DeuqmwEZRyLnxw@mail.gmail.com>
	<50E60E32.4060704@xenomai.org>
In-Reply-To: <50E60E32.4060704@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] make devices not run from deb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 01/04/2013 12:03 AM, Gilles Chanteperdrix wrote:

> On 01/04/2013 12:00 AM, Daniel M. Drucker, Ph.D. wrote:
> 
>>>
>>> You have to check if Xenomai is started correctly, see the
>>> TROUBLESHOOTING guide.
>>>
>>>
>> imt@imtrobot:~$ dmesg|grep -i xeno
>> [    0.000000] Linux version 3.5.3-xenomai.2.6.git.imt.20130103.1357.thu
>> (root@rossum) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1 SMP
>> Thu Jan 3 14:10:49 EST 2013
>> [    0.000000] Kernel command line:
>> BOOT_IMAGE=/boot/vmlinuz-3.5.3-xenomai.2.6.git.imt.20130103.1357.thu
>> root=UUID=1eb41f5a-ea91-4772-8e91-acfcc80dcbca ro quiet splash vt.handoff=7
>>
>> It doesn't appear that xenomai is starting at all.
>> I built the kernel using scripts/prepare-kernel.sh.
> 
> 
> It does not matter, what matters is that CONFIG_XENOMAI is enabled. You
> can also try removing "quiet" from the kernel command line.


Or try /var/log/syslog or /var/log/messages
-- 
                                                                Gilles.

