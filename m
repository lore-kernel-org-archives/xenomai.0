Message-ID: <4C76775A.4040104@domain.hid>
Date: Thu, 26 Aug 2010 16:16:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C73EC62.80703@domain.hid> <1282703799.2170.4.camel@domain.hid>
	<4C74C059.4090704@domain.hid> <1282748002.1995.2.camel@domain.hid>
	<1282748372.2845.2.camel@domain.hid>
	<1282759231.5566.3.camel@domain.hid> <4C76483C.8080103@domain.hid>
In-Reply-To: <4C76483C.8080103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RFT] ipipe patch for 2.6.35.3-x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Edward Hoffman <quantalgo@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Edward Hoffman wrote:
>> Jan,
>>
>> I reconfigured the linux-2.6.35.3 kernel (32-bit) after applying the
>> adeos kernel patch.  All I get when I reboot is a black screen with a
>> blinking cursor.
>>
>> Any suggestions.
>>
> 
> I'm building a 32-bit kernel in the background. I case that one happens
> to boot, I will come back and ask for your config.

Looks like I do need your .config as I'm only getting a false-positive
warning from lockdep, the 32-bit kernel boots and runs fine otherwise,
at least in UP mode.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

