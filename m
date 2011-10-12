Message-ID: <4E957769.4000402@domain.hid>
Date: Wed, 12 Oct 2011 13:18:01 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4E95618B.6010709@domain.hid>
	<4E957322.6090101@domain.hid>	<4E957434.4060406@domain.hid>
	<4E957527.3080504@domain.hid>
In-Reply-To: <4E957527.3080504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH xenomai-head] testsuite: fix compiler
 error 'SIGALRM, undeclared'
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 10/12/2011 01:08 PM, Gilles Chanteperdrix wrote:
> On 10/12/2011 01:04 PM, Daniele Nicolodi wrote:
>> On 12/10/11 12:59, Gilles Chanteperdrix wrote:
>>> On 10/12/2011 11:44 AM, Wolfgang Grandegger wrote:
>>>> Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
>>>> ---
>>>>  src/testsuite/regression/posix/leaks.c |    1 +
>>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/src/testsuite/regression/posix/leaks.c b/src/testsuite/regression/posix/leaks.c
>>>> index 7326572..f9dd34d 100644
>>>> --- a/src/testsuite/regression/posix/leaks.c
>>>> +++ b/src/testsuite/regression/posix/leaks.c
>>>> @@ -6,6 +6,7 @@
>>>>  #include <fcntl.h>
>>>>  #include <sys/mman.h>
>>>>  #include <semaphore.h>
>>>> +#include <signal.h>
>>>>  #include <mqueue.h>
>>>>  
>>>>  #include <nucleus/heap.h>
>>>
>>> Applied, thanks.
>>>
>>
>> Wans't that the same error fixed by commit
>> aa44db3d5ee270c3b92a1017f7c136ffa1e2cc4d?
> 
> Indeed.

Argh, my tree was already more than a week old. Sorry for the noise.

Wolfgang.


