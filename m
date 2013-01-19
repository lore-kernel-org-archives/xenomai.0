Message-ID: <50FB24E6.3020001@zultron.com>
Date: Sat, 19 Jan 2013 16:57:42 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50FAFF77.8020803@zultron.com> <50FB1A58.5040307@zultron.com>
	<50FB1AB9.30604@xenomai.org> <50FB1B41.6050001@xenomai.org>
	<50FB231B.2050004@zultron.com> <50FB23AF.5000508@xenomai.org>
In-Reply-To: <50FB23AF.5000508@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 32-bit regression tests:  CLOCK_REALTIME wonkiness
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 01/19/2013 04:52 PM, Gilles Chanteperdrix wrote:
> On 01/19/2013 11:50 PM, John Morris wrote:
> 
>>
>>
>> On 01/19/2013 04:16 PM, Gilles Chanteperdrix wrote:
>>> On 01/19/2013 11:14 PM, Gilles Chanteperdrix wrote:
>>>
>>>> On 01/19/2013 11:12 PM, John Morris wrote:
>>>>
>>>>> On 01/19/2013 02:17 PM, John Morris wrote:
>>>>>> Hi list,
>>>>>>
>>>>>> These are the final tests on 32-bit before the initial RedHat packages
>>>>>> can be released for wider testing.
>>>>>>
>>>>>> On this host, a Dell Celeron with ICH5 chipset, the CLOCK_REALTIME
>>>>>> numbers look funny.  All other tests run correctly.
>>>>>
>>>>> Whoops, how embarrassing, I reported the wrong thing:  it's the
>>>>> native/tsc numbers that look funny.
>>>>>
>>>>> ++ /usr/lib/xenomai/regression/native/tsc
>>>>> Checking tsc for 1 minute(s)
>>>>> min: 4294967295, max: 0, avg: -nan
>>>>> min: 4294967295, max: 0, avg: -nan
>>>>> min: 4294967295, max: 0, avg: -nan
>>>>> min: 4294967295, max: 0, avg: -nan
>>>>> min: 4294967295, max: 0, avg: -nan
>>>>> min: 4294967295, max: 0, avg: -nan
>>>>> [...]
>>>>> min: 4294967295, max: 0, avg: -nan -> -nan us
>>>>
>>>>
>>>> You are probably missing --enable-x86-tsc on configure command line.
>>>>
>>>
>>> (or rather have passed --disable-x86-tsc as --enable-x86-tsc should be
>>> the default).
>>>
>>
>> --enable-x86-tsc is in there, and configure finds TSC support:
>>
>> + ./configure --build=i686-koji-linux-gnu --host=i686-koji-linux-gnu
>> --target=i686-redhat-linux-gnu --program-prefix= --prefix=/usr
>> --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin
>> --sysconfdir=/etc --datadir=/usr/share
>> --includedir=/usr/include/xenomai/ --libdir=/usr/lib
>> --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib
>> --mandir=/usr/share/man --infodir=/usr/share/info --enable-x86-tsc
>> --enable-dlopen-skins --with-testdir=/usr/lib/xenomai
>> [...]
>> checking for x86 TSC support... y
>>
>> Build log follows.  What else can I check?
> 
> 
> Could you send me the "tsc" program?
> 

http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/tsc.gz

	John

