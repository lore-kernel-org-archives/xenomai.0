Message-ID: <46FA26ED.4070505@domain.hid>
Date: Wed, 26 Sep 2007 11:31:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>
In-Reply-To: <1190756271.26427.0.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Non-APIC setup broken for 2.4-SVN?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2007-09-25 at 16:09 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> to make it short has anyone or could anyone try latest SVN over kernel 
>> 2.6.20 (i-pipe for 2.6.22 is instable) _without_ LAPIC? It works for me, 
>> but exposes milliseconds of latencies. Same setup with LAPIC enabled is 
>> fine and obviously stable. Before digging into this (time is short 
>> anyway), I would like to exclude problems of my notebook hardware.
>>
> 
> Not confirmed here. Everything looks ok.

Yes, I found a second box working fine with a comparable (though not 
identical) config. I suspect some hw issue of my notebook now, but I 
will try to look into this a bit deeper once time permits.

More important is to understand and fix the consistent 2.6.22 issues I 
see. Only works in qemu for me, all real i386 boxes lock up sooner or 
later. :-/

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

