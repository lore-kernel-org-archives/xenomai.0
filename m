Message-ID: <44ED56C0.2030904@domain.hid>
Date: Thu, 24 Aug 2006 01:35:28 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ndiswrapper fails to 'ifup' on ipipe-1.3.10
References: <44ECCA1E.1010707@domain.hid> <1156403232.4832.7.camel@domain.hid>
In-Reply-To: <1156403232.4832.7.camel@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Wed, 2006-08-23 at 15:35 -0600, Jim Cromie wrote:
>   
>> any off-hand guesses as to what might have caused this ?
>> ndiswrapper-1.x has worked fine with 1.3.9 and previous.
>>
>>     
>
> Anything in dmesg?
>   

Oops.  I tried and failed with 1.24rc1, then backed up to working 1.23, 
which failed.
Bonehead probly forgot to rmmod before re ifup'g it. :-}

1.23 works fine here, on ipipe-1.3.10.  Ill do a debug build of ndiswrapper,
and see what it shows me.

Sorry for the noise.

