Message-ID: <47ED5472.8000204@domain.hid>
Date: Fri, 28 Mar 2008 21:26:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080328190310.GB9009@domain.hid>
	<47ED4C7A.8070809@domain.hid>
In-Reply-To: <47ED4C7A.8070809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH][SOLO] add more warnings
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
To: Robert Schwebel <r.schwebel@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Robert Schwebel wrote:

[snip]

>> I've looked into the first ones only yet and it looks to me like the
>> type definitions have to be reviewed carefully. For example, TASK_ID is
>> defined to be unsigned long, whereas the vxworks documentation [1] looks
>> more like if we need 'int' there. Which also makes me wonder if vxworks
>> has a special idea about what 'int' is;
> 
> VxWorks assumes 32bit and sizeof(void *) == sizeof(int), unfortunately. See
> taskSpawn() for instance.
>

Sorry: s,taskSpawn,taskInit,

-- 
Philippe.

