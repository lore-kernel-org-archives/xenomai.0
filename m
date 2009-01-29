Message-ID: <4981D1AA.7050308@domain.hid>
Date: Thu, 29 Jan 2009 16:56:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20090129152206.A82B71C066@domain.hid>
	<4981CDB7.5090905@domain.hid>
In-Reply-To: <4981CDB7.5090905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] interrupt service routine issue
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> stefano.franzoni@domain.hid wrote:
>> Thanks Gilles,
>>
>> with your suggestion, setting the special mode bit T_WARNSW for the
>> incriminated task, we found two critical functions that caused switches to
>> secondary mode.
>>
>> I report them for documentation:
>>
>> 1. We used mmap function used to map a file into memory. The access to the
>> memory caused sometimes the switch to secondary mode.
> 
> damn, this should not happen, we use mlockall and some additional tricks
> in the I-pipe patch to avoid that.

Mmmh, I don't think we can cure (/wrt RT) access to memory mapped files.
That's just the same no-go for RT threads as other Linux I/O.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

