Message-ID: <5176DC86.7010300@xenomai.org>
Date: Tue, 23 Apr 2013 21:09:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5176410F.1060100@gmail.com> <51764473.2020800@xenomai.org>
In-Reply-To: <51764473.2020800@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai "does not" ISO C, C99 and C++ standard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
Cc: xenomai@xenomai.org

On 04/23/2013 10:21 AM, Gilles Chanteperdrix wrote:

> On 04/23/2013 10:06 AM, Victor Hiairrassary wrote:
> 
>> Hello all,
>>
>> We use xenomai 2.6.2.1 with g++ 4.7.2 from buildroot on a Armadeus apf27
>> board. This works really fine, but if we add "-W -Werror -Wall -pedantic
>> -pedantic-errors" in compiler command line, g++ detects some warnings for
>> a code as simple as :
>>
>> #include <native/task.h>
>> int main() {
>>      return 0;
>> }
>>
>> The complete log of the compilation is attached with this email.
>>
>> The compiler complains about various things, in differents files. I have 
>> not
>> tested other xenomai's headers like native/queue.h, etc. yet.
>>
>> Do you have any plans to fix them?
> 
> 
> What you could do to fix them is to move the functions implemented in
> trace.h to an src/skins/common/trace.c, this would allow to remove
> asm/xenomai/syscall.h from nucleus/trace.h, and would solve most of the
> warnings you are showing us. When you are done and it works for you,
> please submit a patch.
> 
> As for the variadic macros, I believe they exist in C99, so perhaps you
> are not compiling with the right flag, or perhaps we do not use the C99
> syntax, which probably could be fixed too.
> 


It is a bit more complicated than that, removing asm/syscall.h from
nucleus headers breaks __xn_rdtsc for instance. We will keep this change
for later.

-- 
                                                                Gilles.

