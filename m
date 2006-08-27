Message-ID: <44F19754.6040808@domain.hid>
Date: Sun, 27 Aug 2006 15:00:04 +0200
From: Steve Kreyer <steve.kreyer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Timer problems?
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid> <44EF37BE.70207@domain.hid>
	<44F0B06B.6050102@domain.hid> <44F17616.9080701@domain.hid>
	<44F196A0.2030006@domain.hid>
In-Reply-To: <44F196A0.2030006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: steve.kreyer@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Jan Kiszka wrote:
>> ...but you have configured your processor to be from the pre-Pentium era
>> (CONFIG_M586). Suboptimal because TSC support is disabled, TSC emulation
>> is enabled.
>>
>> Moreover, and that's likely another reason for troubles here, you have
>> CONFIG_VT on. This normally unproblematic features collides with the TSC
>> emulation of Xenomai. SVN head warns you about this conflict, 2.2 not
>> yet. Solution: pick a more appropriate processor type.
>>   
this was the point... I have now recompiled the kernel with an updated 
version and set the processor type option to "pentium 4",
and now the tsc work like expected...

You guys helped me to get out from big trouble :) Thank you!

Regards,
Steve

