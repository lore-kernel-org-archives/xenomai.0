Message-ID: <45B87AAB.9070804@domain.hid>
Date: Thu, 25 Jan 2007 10:38:51 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Patching latest Denx 2.4.25-devel kernel with
	xenomai-2.3.0 fails
References: <DD39B5C3F4963040ADC9768BE7E430CB0198DDF9@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0198DDF9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Daniel Schnell wrote:
> Wolfgang Grandegger wrote:
>> The attached patch fixes the problem by replacing "^" with "-1" for
>> "previous line". It works now with FC4 and FC6. Likely it's an
>> incompatibility issue between ed-0.2-3 ed-0.3-0.fc6.  
>>
>> Wolfgang.
> 
> Yes this fixes the problem for me. I can successfully patch the kernel
> now.
> 
> Thanks for the quick fix.

The change is also documented:

  FC4: man ed
  -
  ^       The  previous  line.   This  is  equivalent  to  -1  and may be
          repeated with cumulative effect.

  FC6: man ed
  -       The  previous  line.   This  is  equivalent  to  -1  and may be
          repeated with cumulative effect.

The "^" disappeared obviously with ed v0.3.0 :-(.

Wolfgang.


