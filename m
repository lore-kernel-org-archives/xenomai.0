Message-ID: <52F35972.4020208@siemens.com>
Date: Thu, 06 Feb 2014 10:44:18 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52F27AAD.8050809@siemens.com> <52F2983E.5080505@xenomai.org>
 <52F355E1.4010709@xenomai.org>
In-Reply-To: <52F355E1.4010709@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] forge: --enable-pshared broken?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-02-06 10:29, Philippe Gerum wrote:
> On 02/05/2014 08:59 PM, Gilles Chanteperdrix wrote:
>> On 02/05/2014 06:53 PM, Jan Kiszka wrote:
>>> Hi,
>>>
>>> trying to test a --enable-pshared build gives me this linker error:
>>>
>>> libtool: link: ../../../scripts/wrap-link.sh gcc -g -o .libs/check-vdso
>>> check_vdso-check-vdso.o  ../../lib/cobalt/.libs/libcobalt.so -lfuse
>>> -lpthread -lrt -lm -Wl,-rpath -Wl,/data/xenomai-forge/inst64/lib
>>> ../../lib/cobalt/.libs/libcobalt.so: undefined reference to
>>> `__main_heap'
>>>
>>> Is this known/reproducible?
>>
>> I get the same issue with cobalt, when linking the "latency" test, which
>> in my tree uses the posix api.
>>
> 
> This one may help:
> 
> http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=ba1f4b636a490e42af332e0c1f079e67b96255d5

Confirmed, it builds.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

