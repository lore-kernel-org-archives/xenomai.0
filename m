Message-ID: <436A7F1C.9040107@domain.hid>
Date: Thu, 03 Nov 2005 22:20:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Dev branch 2.1
References: <4368A088.9070906@domain.hid> <43693662.3080601@domain.hid>
	<4369C3C1.2040302@domain.hid>
	<4369E251.8070802@domain.hid> <436A6493.9020107@domain.hid>
	<436A654A.5050805@domain.hid> <436A6B3F.1090309@domain.hid>
In-Reply-To: <436A6B3F.1090309@domain.hid>
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

Hannes Mayer wrote:
> Philippe Gerum wrote:
> [...]
> 
>> The surprise is that xeno_native is statically built-in by default. 
>> You can change that selecting the proper tristate position in the 
>> kernel config for the native skin.
> 
> 
> So everything (even the 16550 driver) is compiled in by default ?
> I didn't look that closely last night - I like that! No more insmodding :-)
> 
> I just tried two of my programs, but each says:
> 
> Xenomai: native skin or user-space support unavailable.
> (did you load the xeno_native.ko module?)
> 
> kern.log says:
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> Xenomai: real-time nucleus v2.1 (Surfing With The Alien) loaded.
> Xenomai: starting native API services.
> Xenomai: starting RTDM services.
> 
> What am I missing ?
>

The feature set between user-space and kernel support is likely mismatching. Try 
passing --enable-x86-tsc to configure. More explicit messages will be printed 
out in later versions since we do have appropriate return codes passed back 
internally to distinguish the cases.

> Thanks and best regards,
> Hannes.
> 


-- 

Philippe.

