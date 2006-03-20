Message-ID: <441EC906.3050104@domain.hid>
Date: Mon, 20 Mar 2006 16:23:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid> <441E9698.5080506@domain.hid>
	<441EAD78.3030007@domain.hid>
	<200603201137.12548.rosenfeld@domain.hid>
In-Reply-To: <200603201137.12548.rosenfeld@domain.hid>
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
To: Rodrigo Rosenfeld Rosas <rosenfeld@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
> Philippe Gerum wrote:
> 
>>...
>>Given the description above, just that some skin might return either
>>nucleus ticks or corrected timestamps to the applications, which would
>>in turn do some arithmetics for converting values they got from the skin
>>between both scales internally, and mistakenly use the result while
>>assuming that both scales are always in sync. In this situation, and
>>during a fraction of the time (i.e. the jitter), both scales might not
>>be in sync, and the result would be unusable.
> 
> 
> But I still can't find a real situation where the user would need these values 
> to be in sync...

It's not a matter of dealing with users always doing The Right Thing, 
but preferably preventing people from doing the wrong one.

-- 

Philippe.

