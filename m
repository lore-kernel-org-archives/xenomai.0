Message-ID: <4FBE6113.9070202@xenomai.org>
Date: Thu, 24 May 2012 18:25:55 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <mailman.12.1337871081.15349.xenomai@xenomai.org>
	<COL115-W475E9F301660B2C796E3CFE2000@phx.gbl>
	<4FBE4F70.6030708@xenomai.org>
In-Reply-To: <4FBE4F70.6030708@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] help: Latency of xenomai on Portwell NANO 8044 with
 Atom Z530
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai MailingList <xenomai@xenomai.org>

On 05/24/2012 05:10 PM, Gilles Chanteperdrix wrote:
> On 05/24/2012 04:54 PM, 孙伯杰 wrote:
>> Hello everyone,
>>
>> I'm doing tests of Real-time Java on my target board: Portwell NANO
>> 8044 with Atom Z530 1.6 GHz. I've already installed xenomai on it and
>> run some example tests like "Latency" and "Wakeup-time" in
>> /usr/xenomai/bin. When I start the latency test, just get a quit good
>> average latency but at the same time a  very big max. latency.
>>
>> I run it in user-mode and the period should be 100 us. Then I get an
>> average latency around 1 or 2 us, but a max. latency around 400 us.
>> After several minutes running, the latency can get to be negative in
>> worst-case. Actually I don't know how to switch to kernel mode
>> because I'm really new in compiling the linux-kernel.
>
> In order to know where the big latency comes from, you should try and
> use the I-pipe tracer. See:
> http://www.xenomai.org/index.php/I-pipe:Tracer
>
> negative latencies simply are a calibration issue. In order to avoid
> them, you should reduce the value of /proc/xenomai/latency. A simple way
> to do this is to set it to 0 with:
> echo 0>  /proc/xenomai/latency
>
> Run the latency test. Then echo the minimal latency you found with the
> latency test to /proc/xenomai/latency.
>
>>
>> However, when I start the periodic-test in examples, the performance
>> is still quite fine. So I'm confused about that.
>>
>> By the way, I've already made the configuration carefully several
>> times. The probable reasons (like
>> CONFIG_CPU_FREQ,APM,ACPI_PROCESSOR,INTEL_IDLE,SMI, usb UHCI HW driver
>> ) listed in troubleshooting on the wiki have been all checked by
>> myself in the menuconfig.
>
> Actually, you should not disable USB. What you should disable is USB
> legacy in BIOS configuration and keep USB enabled in kernel configuration.
>

Yes, 400 us latency spots is very typical of USB related SMIs.

>>
>> And What I'm not sure is whether the performance of my Real-time Java
>> VM will be affected by this Latency of xenomai? The VM uses the POSIX
>> Timer and if I use the POSIX skin in xenomai, I'm not sure whether
>> the performance can be different from on standard linux kernel.
>
> In order to get POSIX applications to use xenomai posix skin, you have
> to at least recompile the application with the correct options. For more
> details see:
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
>


-- 
Philippe.

