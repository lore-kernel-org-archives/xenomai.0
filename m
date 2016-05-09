References: <E1aybuF-000446-5i@sd-51317.xenomai.org>
 <20160506092248.GE13285@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <573050C3.1080809@siemens.com>
Date: Mon, 9 May 2016 10:56:35 +0200
MIME-Version: 1.0
In-Reply-To: <20160506092248.GE13285@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : boilerplate: Allow for
 enabling Xenomai only in shared libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 2016-05-06 11:22, Gilles Chanteperdrix wrote:
> On Fri, May 06, 2016 at 11:18:43AM +0200, git repository hosting wrote:
>> diff --git a/lib/boilerplate/init/Makefile.am b/lib/boilerplate/init/Makefile.am
>> index 7a58f54..8c09e28 100644
>> --- a/lib/boilerplate/init/Makefile.am
>> +++ b/lib/boilerplate/init/Makefile.am
>> @@ -4,6 +4,7 @@ libbootstrap_a_SOURCES = bootstrap.c
>>  
>>  libbootstrap_a_CPPFLAGS =		\
>>  	@XENO_USER_CFLAGS@		\
>> +	-fPIC				\
>>  	-I$(top_srcdir)/include		\
>>  	-I$(top_srcdir)/lib
> 
> This is not how this should be done.
> 

The patch was just still in my queue when I rebased, as reminder of the
unsolved issue. Now I remember that Philippe and I discussed this a
while back and he had some ideas. They are probably still on the stack
of to-dos.

I'll move this to the top and keep it local - as reminder.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

