Message-ID: <48775817.7090108@domain.hid>
Date: Fri, 11 Jul 2008 14:54:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48760BCD.3080505@domain.hid> <48761DC0.3080901@domain.hid>
In-Reply-To: <48761DC0.3080901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] Provide owner name
	via	rt_mutex_inquire
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Another possibility would be to use snprintf instead of strncpy in 
> xnobject_copy_name, and use xnobject_copy_name here.

Yet another possibility would be to use strlcpy, available in 
kernel-space. But it is funny, glibc people does not seem to like 
strlcpy for reasons I do not quite understand...

http://sources.redhat.com/ml/libc-alpha/2000-08/msg00053.html

-- 
                                                  Gilles.

