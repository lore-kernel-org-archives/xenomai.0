Message-ID: <4926D453.9070900@domain.hid>
Date: Fri, 21 Nov 2008 16:31:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4926D312.3050707@domain.hid> <4926D3F4.3040207@domain.hid>
In-Reply-To: <4926D3F4.3040207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] nodiv xnarch_ns_to_tsc for x86-64
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi Gilles,
>>
>> I assumed you armed nodiv ns-to-tsc for x86-64, given that the services
>> are in place now. But my test case just crashed another box even though
>> latest SVN was installed. Any reason for not converting yet?
> 
> Yes, I only tested the routine performance, not tested xenomai running
> on it.  I am in the middle of a reorganization of my test boxes, which
> is taking more time than I initially thought, so could not test the
> routine as soon as I would have liked.

Ah, ok. What's the rough schedule (few days, a week, ...)? And will you
also take care of the 32-bit case or should I have a look?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

