Message-ID: <504EEC3E.40108@xenomai.org>
Date: Tue, 11 Sep 2012 09:46:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50483A49.5090100@ebus.com>
	<504C7797.8040201@xenomai.org>	<504D3216.7030401@ebus.com>
	<504EBA13.30909@ebus.com>
In-Reply-To: <504EBA13.30909@ebus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Queue corruption from XDDP in Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>
Cc: xenomai@xenomai.org

On 09/11/2012 06:12 AM, Doug Brunner wrote:

> On 09/09/2012 05:19 PM, Doug Brunner wrote:
>> On 09/09/2012 04:03 AM, Philippe Gerum wrote:
>>> On 09/06/2012 07:53 AM, Doug Brunner wrote:
>>>> It looks like the bug I wrote about back in June still exists in 
>>>> Xenomai
>>>> 2.6.1 (with Linux 3.2.21). I ran the same test case (an RT thread opens
>>>> an XDDP socket, then a Linux thread opens its end of the pipe, then the
>>>> RT thread stops, then with the Linux thread still holding its end of 
>>>> the
>>>> pipe another RT thread tries to open an XDDP socket with the same minor
>>>> number). With Xenomai queue and I-pipe debugging enabled, I got a 
>>>> report
>>>> of a corrupted queue. I've attached my config, test case, and serial
>>>> console log.
>>>>
>>>> So far I haven't found anything in the XDDP or underlying xnpipe_* code
>>>> that would suggest why this is happening. However something is
>>>> definitely going wrong, since xnpipe_minor_free should not be called
>>>> until my Linux task closes its end of the pipe, so the call by the
>>>> second RT thread to open the pipe should fail with -EBUSY. Any thoughts
>>>> on why this might be happening?
>>>>
>>> Yes, please have a look at the commit log there:
>>> http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=283c5f6eae1d1d7c65073e2f30fd40abdcf2c1ca 
>>>
>>>
>>> This patch should fix the issue raised by the test case you sent
>>> (actually, it does, it was very useful to spot the problem - thanks for
>>> this).
>> Thanks Philippe--I will patch this in and try it on my test hardware 
>> tomorrow. (Unfortunately my KVM virtual machine will not boot any 3.2 
>> kernel with I-pipe AFAICT; around the time it remounts the root FS 
>> read-write it begins waiting for something that never happens :( )
>>
>>     --Doug Brunner
> Works fine (passes regression test and appears to run my application 
> OK), thanks again.
> 
> I don't suppose anyone has a suggestion for what I might do to debug the 
> hang during boot in KVM? :)


It is likely a timer issue, you have to put some printk around to see if
the timer interrupt is still ticking for xenomai and for linux, and if
it is not ticking try and understand why.

-- 
                                                                Gilles.

