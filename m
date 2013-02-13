Message-ID: <511C010F.4030304@xenomai.org>
Date: Wed, 13 Feb 2013 22:09:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPeEhaoS1dLW0VfiGVVsyEcGokO8zDNP-yg_2SFMRxzXD5a6Rw@mail.gmail.com>	<511B5190.3070800@xenomai.org>	<CAPeEhaq-oMmhntc3rYDt-e1=qEorjkVj8G+qYKcNSxOggjGH7A@mail.gmail.com>
	<CAPeEharzL54WkK2TCBmQo7ec8Aa1-t1dyBKuHBeZ0hLzGgCiwQ@mail.gmail.com>
In-Reply-To: <CAPeEharzL54WkK2TCBmQo7ec8Aa1-t1dyBKuHBeZ0hLzGgCiwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd:  Porting IPIPE to SUN5I (Allwinner A13)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: uMinded Strikes Again <iceblu3710@gmail.com>
Cc: xenomai@xenomai.org

On 02/13/2013 09:30 PM, uMinded Strikes Again wrote:

> Ok so I am on my way with kernel version 3.4.29 however my sun5i directory
> is quite lacking. If I compare /arch/arm/omap2/ their are dozens of files
> to the SOC features and a complete Kconfig file as well but in my
> /arch/arm/sun5i/ their are just the basics for the clock to run and no
> Kconfig at all!
> 
> Is their a drivers patch out there for the sunxi chipsets or will I be
> writing my own for this whole architecture??


If you have a support for the 3.0 kernel, you may adapt it to a newer
kernel. Or indeed use the 3.0 kernel as a base for Xenomai. In this
case, the guide is:

http://xenomai.org/index.php/I-pipe:ArmPorting

Is what we have to help you. But:
- it seems the I-pipe core patches are a bit easier to port to new ARM
boards (we already had 3 new ports since the first I-pipe core patch for
3.2);
- this document is quite outdated, you would have to use the new version
explanations about GPIOs demuxing or tsc emulation;
- getting the full support for the processor you are intereseted in
merged into the mainline kernel may be more future proof than getting
stuck with Linux 3.0.

-- 
                                                                Gilles.

