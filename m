Message-ID: <43D51EE6.1050400@domain.hid>
Date: Mon, 23 Jan 2006 10:22:30 -0800
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Unresolved
	symbols	tickGet/wind_current_context_errno using libvxworks.a
References: <200601222117.01895.niklaus.giger@domain.hid>
In-Reply-To: <200601222117.01895.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

> Linking my vxworks application library (about 180 C++ files) against xenomai 
> 2.1 gives me now the following errors...
> Is this the result that tickGet is defined as xnticks_t tickGet(void) in 
> xenomai but as int tickGet(void) under vxWorks?

Hmm, that should not matter since the symbol would be the same (only C++ 
  which mangles names would have a different signature).

More likely the library containing the symbols is mentioned before the 
library needing the symbols. Look for that or send along the actual call 
to the linker...

hth

                                 - Tom

-- 
Thomas Lockhart
Supervisor, Realtime Software Group
Interferometry and Large Optical Systems
Caltech/JPL

