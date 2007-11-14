Message-ID: <473B3536.3000709@domain.hid>
Date: Wed, 14 Nov 2007 18:49:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4739E07B.1000608@domain.hid> <200711141056.06083.lepalom@domain.hid>
	<200711141637.30166.paul_c@domain.hid>
In-Reply-To: <200711141637.30166.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai v2.4-rc6
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>, Leopold Palomo-Avellaneda <lepalom@domain.hid>

Paul wrote:
> On Wednesday 14 November 2007 09:56, Leopold Palomo-Avellaneda wrote:
>> A Dimarts 13 Novembre 2007, Philippe Gerum va escriure:
>>> Here is the sixth candidate release for the v2.4.x branch.
>> [....]
>>
>>> 	[i386, x86_64 => x86]
>>>
>>> 	* Merge i386 and x86_64 arch-dep support as x86.
>>>  	* Update Adeos/i386 support for 2.6.20, 2.6.22 and 2.6.23.
>> [...]
>>
>> this has break the creation of the debian packages. I can understand that
>> conceptually they are the same arch (one with 32bits and another with 64
>> and more extensions) in general _all_ the distros treat them as two
>> different arch. So this changes break things. I don't think that it's a
>> good idea do it in a release candidate, IMHO.
> 
> I'm right in the middle of looking at the packaging scripts, so expect a patch 
> within the next few days.
> 
> Giles/Philippe: Is there likely to be a 2.6.24 ipipe patch out before Xenomai 
> reaches 2.4.0 ?
> 
> 

I don't think so, at least for 2.6.26/x86*. Even if we do have an
experimental patch for 2.6.24-rc1/x86, it would make sense to go for a
combo x86_32/64 bit support patch for 2.6.24 directly. To get that, I'd
rather take the needed time to properly merge both I-pipe branches
without any release deadline pressure, and since we already have the
proper infrastructure available in 2.4-rc to run over the latest x86*
kernels, we may provide support for 2.6.24 during the Xenomai 2.4
maintenance cycle anyway.

-- 
Philippe.

