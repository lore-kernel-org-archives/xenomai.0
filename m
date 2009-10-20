Message-ID: <4ADDE047.2090100@domain.hid>
Date: Tue, 20 Oct 2009 18:07:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000AE71.4ADDA6F7@domain.hid> <4ADDDEDA.2010200@domain.hid>
In-Reply-To: <4ADDDEDA.2010200@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] :: rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "oliver.schlenker@domain.hid" <oliver.schlenker@domain.hid>

Gilles Chanteperdrix wrote:
> oliver.schlenker@domain.hid wrote:
>> +	while (*pbuffer) {
>> +		if (*pbuffer == my_buffer)
>> +			pbuffer = &(*pbuffer)->next;
>> +		else
>> +			cleanup_buffer(*pbuffer);
>> +	}
> 
> Looks like an infinite loop if *pbuffer != my_buffer, no?
> 

No, cleanup_buffer is shrinking the list until it's NULL (or only
my_buffer).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

