Message-ID: <4F8DED15.4020101@domain.hid>
Date: Tue, 17 Apr 2012 17:22:13 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
References: <4F3BD76C.1040703@domain.hid> <4F3BDC1E.9090707@domain.hid>
	<4F46B792.8070204@domain.hid> <4F46BD22.60404@domain.hid>
	<4F46C6A2.5060905@domain.hid> <4F8B0881.8090404@domain.hid>
In-Reply-To: <4F8B0881.8090404@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Real-time printf in Xenomai 2.6.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On 04/15/2012 12:42 PM, Gilles Chanteperdrix wrote:
> On 02/24/2012 12:07 AM, Jeff Webb wrote:
>> On 02/23/2012 04:26 PM, Gilles Chanteperdrix wrote:
>>> On 02/23/2012 11:02 PM, Jeff Webb wrote:
>>>> I was happy to see that printf now works from real-time POSIX
>>>> threads in Xenomai 2.6.0.  Unfortunately, I'm seeing some strange
>>>> behavior that surfaces when I try to print the string "\n" by
>>>> itself.  When I run the attached example program, I get:
>>>>
>>>> $ ./printf_test start CPU time limit exceeded $
>>>>
>>>> IfI replace the two printf calls with rt_printf calls and
>>>> #include<rtdk.h>,I get the expected result:
>>>>
>>>> $ ./rt_printf_test start 1 2 3 4 ^C $
>>>>
>>>> The original example also works if these two lines:
>>>>
>>>> printf("%d", count); printf("\n");
>>>>
>>>> are replaced with:
>>>>
>>>> printf("%d\n", count);
>>>>
>>>> Can someone confirm if this a bug in Xenomai 2.6.0, something
>>>> specific to my HW/SW installation, or some mistake in my test
>>>> program?
>>>
>>> I would bet the call to printf is replaced with something else
>>> (such as putchar). Could you disassemble the test to check this?
>>
>> Yes, it appears that putchar is called indeed.
>>
>>> Note that I have fixed similar issues in xenomai-2.6 current
>>> repository, so you could give it a try.
>>
>> I may give that a try.  Now that I have confirmed that putchar is the
>> issue, do you think xenomai-2.6 current will fix the problem?  Is
>> putchar now wrapped as well?  I noticed that puts appears to be
>> wrapped from the disassembly output.
>
> It should now be fixed in xenomai-2.6 repository.
>

Thanks for following up, Gilles.

-Jeff

