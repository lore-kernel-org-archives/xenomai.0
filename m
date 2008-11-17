Message-ID: <4921748B.7050706@domain.hid>
Date: Mon, 17 Nov 2008 14:41:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <491805AE.1060809@domain.hid> <491C6ED8.6030903@domain.hid>
	<491C8AE3.5080109@domain.hid>
In-Reply-To: <491C8AE3.5080109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switch when using RT heap on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>> +		ptr = (int *)(block + size - sizeof(int));
>>
>> This is not guaranteed to be aligned on an int. Could you try:
>>
>> 		ptr = (int *)(((unsigned long) block + size - sizeof(int)) & ~3);
> 
> With aligned accesses rtheap reports just3 mode switches in both modes,
> 0 and H_NONCACHED. But already one mode switch is too much!

This should be solved by the current versions of branch v2.4.x and trunk.

-- 
                                                 Gilles.

