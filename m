Message-ID: <473AC972.8070209@domain.hid>
Date: Wed, 14 Nov 2007 11:09:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4739E07B.1000608@domain.hid> <200711141056.06083.lepalom@domain.hid>
In-Reply-To: <200711141056.06083.lepalom@domain.hid>
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
To: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>

Leopold Palomo-Avellaneda wrote:
> A Dimarts 13 Novembre 2007, Philippe Gerum va escriure:
>> Here is the sixth candidate release for the v2.4.x branch.
> [....]
>> 	[i386, x86_64 => x86]
>>
>> 	* Merge i386 and x86_64 arch-dep support as x86.
>>  	* Update Adeos/i386 support for 2.6.20, 2.6.22 and 2.6.23.
> 
> [...]
> 
> this has break the creation of the debian packages. I can understand that 
> conceptually they are the same arch (one with 32bits and another with 64 and 
> more extensions) in general _all_ the distros treat them as two different 
> arch.

How long do you think this is going to be that way, with 2.6.24 actually
merging those supports at kernel level?

 So this changes break things. I don't think that it's a good idea do it
> in a release candidate, IMHO.

We discussed this issue and the reason for doing this change asap in
length on the mailing list two weeks ago or so. Please have a look at
the archive for more. You will also find some significant patches
already exploiting the new common tree in order to streamline the code,
and ease maintenance on our side. Few resources, large work, we have to
be efficient, and maintaining two closely related archs sharing bits in
separate code bases is pointless, and a loss of time for the project.

> 
> Regards,
> 
> Leo
> 


-- 
Philippe.

