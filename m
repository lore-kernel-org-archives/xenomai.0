Message-Id: <DB7A75AE-FD4F-4B02-9D82-41B0D43C3126@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
In-Reply-To: <mailman.33.1396388743.2839.xenomai@xenomai.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Wed, 2 Apr 2014 10:21:34 +0100
References: <mailman.33.1396388743.2839.xenomai@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> Message: 7
> Date: Tue, 1 Apr 2014 17:45:39 -0400
> From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
> To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
> Message-ID: <20140401214539.GD17765@csclub.uwaterloo.ca>
> Content-Type: text/plain; charset=us-ascii
>
> On Tue, Apr 01, 2014 at 10:52:31PM +0200, Gilles Chanteperdrix wrote:
>> On 04/01/2014 09:40 PM, Lennart Sorensen wrote:
>>> On Tue, Apr 01, 2014 at 09:35:24PM +0200, Gilles Chanteperdrix  
>>> wrote:
>>>> On 04/01/2014 03:12 PM, Lennart Sorensen wrote:
>>>>> On Tue, Apr 01, 2014 at 12:52:44PM +0200, Gilles Chanteperdrix  
>>>>> wrote:
>>>>>> The way I test it is by running xeno-regression-test, using  
>>>>>> dohell with
>>>>>> LTP to create a load. Note that the latency result given by
>>>>>> xeno-regression-test should not be taken into account as  
>>>>>> switchtest is
>>>>>> running concurrently and creates large non-preemptible sections,
>>>>>> xeno-regression-test is more a stress test.
>>>>>
>>>>> I will see if I can find the invocation to run that then.
>>>>>
>>>>> I let cyclictest, switchtest and latency running the last 8 hours,
>>>>> and latency test currently says:
>>>>>
>>>>> RTD|     -0.814|      2.441|      7.486|       0|     0|      
>>>>> -2.116|     20.182
>>>>>
>>>>> That seems decent at least.
>>>>>
>>>>
>>>> I use:
>>>> xeno-regression-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
>>>>
>>>> Where the machine with ip 192.168.0.5 has the "discard" service  
>>>> enabled
>>>> (port 9, available in inetd), an usb key is mounted on /mnt, and  
>>>> LTP is
>>>> installed in /ltp.
>>>
>>> I get an error when I use the -s option.
>>
>> Probably because the machine with the IP address you pass after -s  
>> does
>> not have the "discard" service enabled in inetd.conf
>
>

[...]

> d14: 1 != 2
> d15: 1 != 2
> == FPU check routines: OK.
> /usr/bin/xeno-regression-test failed: child 14296 exited with status 2
>
> I was running:
>
> xeno-regression-test xeno-regression-test -l "dohell -s 10.200.19.25  
> -m /mnt -l /mnt" -t 2
>
> Maybe I got something wrong.
>
> ltp is installed to /mnt (which is a USB stick).
>

On my board the directory where 'dohell' resides was not included in  
PATH. Maybe try this:

  xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -s  
10.200.19.25 -m /mnt -l /mnt" -t 2

A.



