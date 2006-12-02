Message-ID: <4571491D.502@domain.hid>
Date: Sat, 02 Dec 2006 10:36:29 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>	<4569E699.6050003@domain.hid>	<20061127092143.e633cd91.benjamin.zores@domain.hid>	<456ACA35.8030206@domain.hid>	<20061127125419.3852edd9.benjamin.zores@domain.hid>	<456AD5EB.5040901@domain.hid>	<20061130133745.272ab4b1.benjamin.zores@domain.hid>	<456EDA4B.3060809@domain.hid>
	<1165013200.4952.177.camel@domain.hid>
	<1165014875.4952.199.camel@domain.hid>
In-Reply-To: <1165014875.4952.199.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2006-12-01 at 23:46 +0100, Philippe Gerum wrote:
>> On Thu, 2006-11-30 at 14:19 +0100, Jan Kiszka wrote:
>>
>>> Anyway, there is an unreleased work-in-progress patch for x86 over -rc6
>>> by Philippe. I recently had the chance to test it and hack a bit on the
>>> SMP IO-APIC part. It seems to work fine under UP, but SMP had some
>>> issues that are identified, but still need to be addressed - thanks to
>>> genirq, now in a widely arch-independent way.
>>>
>>> Philippe, I know you are very busy, but shouldn't we make a pre-release
>>> available already, also to discuss further how to deal best with genirq
>>> on other platforms beyond x86?
>> Actually, the draft patch I sent you did not boot on my SMP box today,
>> so qemu seems to have been a bit too friendly. Knowing that, issuing a
>> half-baked patch would have made no sense, so I finally refrained from
>> doing that. Since I'm now basically in love with the genirq layer (at
>> least for x86) compared to the utter mess that we had to endure
>> previously, I've decided to tackle the issue completely, and rewrite the
>> I-pipe interrupt flow in order to leverage it. Will post something asap.
>>
> 
> Ok, here we are. I've just merged 2.6.19-ipipe-1.6-00. It has been
> tested on a low-end classic Pentium 90Mhz, a dusty two-way Celeron
> 750Mhz, and on a terrible Celeron 1GHz oldish laptop. Looks ok so far,
> and even passed the horrid "dohell" test on the SMP box, just smiling.
> However, I don't have the required hw at hand to check if our friend the
> MSI support is not killing us once more. This said, the MSI support in
> 2.6.19 also conforms to the genirq specs, so there's hope.
> 
> The patch is available from the Adeos download area, and I've also
> committed it to the SVN trunk/.
> 
> Feedback welcome,
> 
> PS: I have the corresponding quilt-managed patches available upon
> request, to the people who want to use this work as a reference for
> porting to other archs.

You mean that you have separate patches for the common and arch 
dependent part. That would be nice. I'm interested! As a consequence we 
could provide separated patches in general and prepare-kernel.sh applies 
them in sequence. Just an idea for the future.

Wolfgang.


