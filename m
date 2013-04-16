Message-ID: <516CFE78.1030903@xenomai.org>
Date: Tue, 16 Apr 2013 09:32:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1U2RE9-0007Zc-Em@xenomai.org> <516983AF.2000909@xenomai.org>
	<516C78FD.1090002@web.de> <516CFC95.4000305@web.de>
In-Reply-To: <516CFC95.4000305@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : switchtest: Add SSE and
	AVX check
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

On 04/16/2013 09:24 AM, Jan Kiszka wrote:

> On 2013-04-16 00:02, Jan Kiszka wrote:
>> On 2013-04-13 18:11, Gilles Chanteperdrix wrote:
>>> This routine causes a warning from gcc and looks indeed wrong: if the
>>> "vec" variable is used as an output variable of the inline assembly, it
>>> should be in the output section of the inline assembly, not the input
>>> section.
>>>
>>
>> Yes, seems wrong. Will try to look into it the next days.
> 
> Done, you can find the obvious fix in my for-upstream queue.


Hi Jan,

yes the fix is obvious, however the fact that machines with AVX support
still pass xeno-regression-test is not, have you checked that?

Regards.

-- 
                                                                Gilles.

