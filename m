Message-ID: <548B477F.1020500@nta-inc.net>
Date: Fri, 12 Dec 2014 13:52:31 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <5489E65F.6000905@nta-inc.net>
 <20141211213710.GH27793@hermes.click-hack.org>
In-Reply-To: <20141211213710.GH27793@hermes.click-hack.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai-3.git next branch build failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 12/11/2014 03:37 PM, Gilles Chanteperdrix wrote:
> On Thu, Dec 11, 2014 at 12:45:51PM -0600, Jeff Webb wrote:
>> When trying to compile the 'next' branch of xenomai-3.git under Ubuntu=
 14.04, I get this error:
>>
>> Making all in autotune
>> make[2]: Entering directory `/home/webb-ja/deb/xenomai-3.git.test/util=
s/autotune'
>> gcc -DHAVE_CONFIG_H -I. -I../../include  -I/home/webb-ja/deb/xenomai-3=
.git.test/lib/cobalt/arch/x86/include -I/home/webb-ja/deb/xenomai-3.git.t=
est/kernel/cobalt/arch/x86/include -DNDEBUG -O2 -D_GNU_SOURCE -D_REENTRAN=
T -pipe -fstrict-aliasing -Wall -Wstrict-prototypes -Wmissing-prototypes =
-Wno-long-long -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__ -I/=
home/webb-ja/deb/xenomai-3.git.test/include/cobalt -I../../include    -MT=
 autotune-autotune.o -MD -MP -MF .deps/autotune-autotune.Tpo -c -o autotu=
ne-autotune.o `test -f 'autotune.c' || echo './'`autotune.c
>> autotune.c: In function =E2=80=98main=E2=80=99:
>> autotune.c:298:9: error: ignoring return value of =E2=80=98daemon=E2=80=
=99, declared with attribute warn_unused_result [-Werror=3Dunused-result]
>>     daemon(0, 0);
>>           ^
>> cc1: all warnings being treated as errors
>> make[2]: *** [autotune-autotune.o] Error 1
>> make[2]: Leaving directory `/home/webb-ja/deb/xenomai-3.git.test/utils=
/autotune'
>> make[1]: *** [all-recursive] Error 1
>> make[1]: Leaving directory `/home/webb-ja/deb/xenomai-3.git.test/utils=
'
>> make: *** [all-recursive] Error 1
>>
>> I see this sort of thing often due to Ubuntu's default compiler flags =
settings.  I applied the attached patch to fix it.
>
> Yes, thanks. I think Jorge already proposed a similar fix, but I can
> not find where I put it. So, I will take your patch. Just a note, is
> the "error" function defined for uclibc ?
>

Thans, Gilles.  I haven't used uclibc, but it looks like it is defined:

   http://git.uclibc.org/uClibc/tree/include/error.h

I just assumed that error() was okay, since it was used elsewhere in the =
file.

-Jeff


