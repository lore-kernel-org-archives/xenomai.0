Message-ID: <4444E330.60709@domain.hid>
Date: Tue, 18 Apr 2006 15:01:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] CONFIG_PREEMPT doesn't work with ADEOS
References: <20060418131428.31f735e9@domain.hid>
In-Reply-To: <20060418131428.31f735e9@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Bernhard Walle <bernhard.walle@domain.hid>
Cc: adeos-main@gna.org

Bernhard Walle wrote:
> Hello,
> 
> I have a kernel 2.6.15.6 with
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.15-i386-1.2-03.patch
> patch. In this configuration, CONFIG_PREEMPT doesn't work any more,
> i.e. the kernel is not preempted.
> 
> With the kernel without ADEOS patch, it works fine. A test program is
> at http://www.bwalle.de/temp/kern-preempt.tar.bz2.
> 
> Do you know what's wrong?
> 
> 

Ok, bug confirmed and spotted. It's an x86 specific issue that impacts 
Adeos back in the pre-Ipipe times. An updated patch will follow once I 
made sure that the fix does not cause any regression, especially on SMP 
systems. Thanks for reporting this way, the quality of your testcase 
made a real difference to locate the issue rapidly.

-- 

Philippe.

