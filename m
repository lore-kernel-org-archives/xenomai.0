Message-ID: <49760E4A.2040102@domain.hid>
Date: Tue, 20 Jan 2009 18:47:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD384F9@domain.hid>
	<4975F2DA.30701@domain.hid> <4975F6F3.1080707@domain.hid>
In-Reply-To: <4975F6F3.1080707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] uClibc compile failure
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Fillod Stephane wrote:
>>> Hi,
>>>
>>> I haven't seen a reply to this patch, maybe it has been missed?
>>>
>> Actually, it was on queue but delayed by the inlined patch.
>> The shm_open/unlink should be fixed by now in both the v2.4.x and trunk
> 
> You mean mmap64/ftruncate64, right?
> 

No, errno=-ENOBRAIN. I just answered a question that was not asked, confusing
both issues. I will merge that part then.

-- 
Philippe.

