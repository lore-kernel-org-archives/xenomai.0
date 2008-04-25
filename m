Message-ID: <4811E3EC.80504@domain.hid>
Date: Fri, 25 Apr 2008 16:00:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4811D596.8070109@domain.hid>	<2ff1a98a0804250612k6ba655f5mc92cb47a12f01d@domain.hid>	<4811E04A.2060205@domain.hid>
	<2ff1a98a0804250646j42be0c69q76ca2a4bde382dba@domain.hid>
In-Reply-To: <2ff1a98a0804250646j42be0c69q76ca2a4bde382dba@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [2.4.x PATCH] POSIX: Remove
 mutex/cond_init	locking, fix NULL attribute
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Fri, Apr 25, 2008 at 3:44 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>  > On Fri, Apr 25, 2008 at 2:59 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>  >> Hi,
>>  >>
>>  >>  trunk check-in #3369 did not just remove some "questionable critical
>>  >>  sections", it also happen to fix two ugly bugs in the POSIX skin: The
>>  >>  user was not able to pass NULL attributes down to mutex_init and
>>  >>  cond_init. Find a backport of that patch for 2.4.x attached.
>>  >
>>  > I am using pthread_mutex_init and pthread_cond_init from user-space
>>  > with NULL attributes with pre 2.4 versions all the time, and never had
>>  > any problem.
>>
>>  Maybe a x86-64 issue: __xn_access_ok() triggers here when you stuff in a
>>  NULL pointer.
> 
> Ok. I had a look at the code now, and understood your patch. We simply
> have been lucky until now that xn_access_ok did not fail with NULL
> pointers.
> 

Unlike other ports, x86_64 specifically tests for page zero pointers...

#define __xn_access_ok(task,type,addr,size)    ((unsigned long)(addr) >=
PAGE_SIZE && \
						__xn_range_ok(task, addr, size))
-- 
Philippe.

