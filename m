Message-ID: <5215D350.8060201@siemens.com>
Date: Thu, 22 Aug 2013 11:01:04 +0200
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
References: <521364EF.8050006@siemens.com> <5213B23C.6000507@xenomai.org>
	<5213E453.6020304@xenomai.org>
In-Reply-To: <5213E453.6020304@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno-regression-test returns SUCCESS when Xenomai not
 available
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi!

Am 20.08.2013 23:49, schrieb Gilles Chanteperdrix:
> On 08/20/2013 08:15 PM, Gilles Chanteperdrix wrote:
>> On 08/20/2013 02:45 PM, Gernot Hillier wrote:
>>> Hi there!
>>>
>>> I'm currently working on an automatic test environment for Xenomai
>>> kernels. Sometimes, Xenomai integration into my kernel fails completely
>>> and I expected this to be detected in a xeno-regression-test run - however:
>>>
>>> root@localhost:~# xeno-regression-test && echo Worked.
>>> Started child 28231: /bin/bash
>>> /usr/lib/xenomai/testsuite/xeno-test-run-wrapper
>>> /usr/bin/xeno-regression-test
>>> ++ echo 0
>>> /usr/bin/xeno-regression-test: line 38: /proc/xenomai/latency: No such
>>> file or directory
>>> ++ :
>>> ++ /usr/lib/xenomai/testsuite/arith
>>> Xenomai: /dev/rtheap is missing
>>> (chardev, major=10 minor=254)
>>> Worked.
>>>
>>> Looking into xeno-test-run.c, I see that a dead script child is not
>>> causing an error exit of xeno-test-run in handle_script_child().
>>>
>>> Is there any special reason for that behaviour or could we just add a
>>> comparable EXIT_FAILURE branch as in handle_checked_child(), something
>>> like
>>
>> No, some piece is missing, but we can not exit right away, we have to
>> send a SIGTERM to all children, then return to the main loop which will
>> wait a bit, then send a SIGKILL if children are not answering, then
>> finally exit. And we have to take note somewhere of the child exit
>> status to call exit with the same exit status. Will send a patch shortly.
>>
>>
>
> Please try the following patch:

[...]

Seems to work perfectly for my use case. Thanks!!

-- 
Regards,
Gernot Hillier

Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


