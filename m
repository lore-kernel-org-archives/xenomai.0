Message-ID: <4E4411DB.80009@domain.hid>
Date: Thu, 11 Aug 2011 19:31:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid>	<4E43B7E8.5000302@domain.hid>	<4E43C056.9040007@domain.hid>	<4E43EBC6.10808@domain.hid>
	<4E440FAC.5020107@domain.hid>
In-Reply-To: <4E440FAC.5020107@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] gcc-4.6 issue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: 637425@domain.hid, xenomai@xenomai.org

On 08/11/2011 07:21 PM, Roland Stigge wrote:
> Hi,
> 
> On 08/11/2011 04:48 PM, Daniele Nicolodi wrote:
>> I compiled linux 2.6.38.8 and xenomai-head with gcc-4.6. The obtained
>> kernel boots fine but xenomai services do not: latency hangs right after
>> the sched_setscheduler system call. With the same kernel I compiled user
>> space with gcc-4.4 and xenomia services work just fine.
> 
> I can confirm this now for Debian. Sorry for the delay.
> 
> Will use gcc-4.4 for building the Debian package for now.
> 
> Attached is a patch you might like to integrate into the GIT repository
> for the build environment. 

Thanks for the patch.

> BTW: You further don't need all the
> Makefile.in's under revision control when there's also a Makefile.am.
> Similarly regarding aclocal.m4 and configure.

Old debate, we want users to avoid having to install the autotools in
order to compile from git, so, we put these files under revision
control. It becomes more and more the sanest solution, as versions of
the autotools are released which break backward compatibility.

-- 
                                                                Gilles.

