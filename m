References: <CAOuPNLjGFNwaCNa1zGQY4gZpLC7J=5M4EzGNS-YiK1UOx=+t0w@mail.gmail.com>
 <1522224881.2732.2.camel@sprinte.eu>
 <CAOuPNLiMyXRLBOcLSbpVtuSKc=2tkM+mQXQoXH79GXBjhz8Zsw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ae78651b-e931-5292-03df-b39131162acb@xenomai.org>
Date: Wed, 28 Mar 2018 15:29:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLiMyXRLBOcLSbpVtuSKc=2tkM+mQXQoXH79GXBjhz8Zsw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Problem with rt_cond_wait and rt_cond_signal
 combination
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, Julien Blanc <julien.blanc@sprinte.eu>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/28/2018 12:04 PM, Pintu Kumar wrote:
> On Wed, Mar 28, 2018 at 1:44 PM, Julien Blanc <julien.blanc@sprinte.eu> wrote:
>> Le mercredi 28 mars 2018 à 13:24 +0530, Pintu Kumar a écrit :
>>> Hi,
>>>
>>> We are facing one issue on Xenomai-3 on x86_64 system.
>>> Kernel: 4.9.51
>>> ipipe version: 4
>>> # /usr/xenomai/sbin/version
>>> Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20 12:13:33 +0100)
>>>
>>> Its a very simple API level test.
>>> We create a condition variable and wait for the condition inside a
>>> task.
>>> Then, we immediately signal the condition from the main thread, and
>>> simply
>>> wait for the test to finish.
>>
>> Looks like you're signalling the condition variable before it is even
>> begin waited by the newly created thread, so i would say the behaviour
>> is normal.
>>
>> If this is just for test purpose, you can for example add a sleep
>> inside your main thread so that you make sure that the child thread
>> reaches the rt_cond_wait call before the main thread executes
>> rt_cond_signal.
>>
> 
> Oh yes, I already tried by adding 1 second sleep before signal, but still the
> condition task hangs.
> 
> This test case works fine on Xenomai 2.6
> 

If you believe there is a bug, can you try to debug this? Some help from
users would not harm. (make sure to build with --enable-debug=full if
you intend to do so).

Thanks,

-- 
Philippe.

