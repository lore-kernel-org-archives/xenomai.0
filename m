Message-ID: <48AFED54.6040608@domain.hid>
Date: Sat, 23 Aug 2008 12:58:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AFCB3F.6070902@domain.hid> <48AFE9E9.3050509@domain.hid>
	<48AFEBB9.9080108@domain.hid>
In-Reply-To: <48AFEBB9.9080108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Racy pse51_mutex_check_init?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Hi Gilles,
>>>
>>> trying to understand the cb_read/write lock usage, some question came up
>>> here: What prevents that the mutexq iteration in pse51_mutex_check_init
>>> races against pse51_mutex_destroy_internal?
>>>
>>> If nothing, then I wonder if we actually have to iterate over the whole
>>> queue to find out whether a given object has been initialized and
>>> registered already or not. Can't this be encoded differently?
>> We actually iterate over the queue only if the magic happens to be
>> correct, which is not the common case.
> 
> However, there remains a race window with other threads removing other
> mutex objects in parallel, changing the queue - risking a kernel oops.
> And that is what worries me. It's unlikely. but possible. It's unclean.

Ok. This used to be protected by the nklock. We should add the nklock again.

-- 
					    Gilles.

