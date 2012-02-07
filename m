Message-ID: <4F315329.9050302@domain.hid>
Date: Tue, 07 Feb 2012 17:36:57 +0100
From: Gregory CLEMENT <gregory.clement@domain.hid>
MIME-Version: 1.0
References: <4F312091.5080001@domain.hid>
	<4F314970.5040904@domain.hid>
In-Reply-To: <4F314970.5040904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Port to AT91SAM9G45
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Petazzoni <thomas.petazzoni@domain.hid>, Maxime Ripard <maxime.ripard@domain.hid>, Nicolas Ferre <nicolas.ferre@domain.hid>, xenomai@xenomai.org

On 02/07/2012 04:55 PM, Gilles Chanteperdrix wrote:
> On 02/07/2012 02:01 PM, Gregory CLEMENT wrote:
>> Hello,
>>
>> I've done the port for AT91SAM9G45 on a AT91SAM9M10G45-EK board. The
>> following patch have to be applied on top of the
>> adeos-ipipe-2.6.38.8-arm-1.18-04.patch patch.
>>
>> I also ran latency test under heavy stress using:
>> - hackbench to stress the scheduler
>> - netcat to stress the Ethernet interface and generate a lot of interrupts
>> - ls and dd( reading a /dev/mtdblock and writing on a tmpfs) for global stress
>>
>> I join the results I had after running each latency test during 10 hours.
>>
>> If the results I get seem the correct could you apply this patch in
>> Xenomai?
>>
>> Should I also submit this patch to adeos project?
> 
> We will merge this patch in the adeos patch, yes. Thanks. Note that
> xenomai-2.6.0 provides a "dohell" command in order to generate some
> load, and a "xeno-test" script which runs latency under dohell load.
> 


Thanks for the pointer. Theses scripts cover almost all I've done,
expect the case involving 'dd'. I chose to read the flash and no to
write on a mount point located in flash to no "wear" it.
Next time I will use these scripts and just tune them for my need.

> Are the results obtained with or without the FCSE option enabled?
> 

They are obtained with the FCSE option enabled. Do you want the kernel
config file ?

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044

