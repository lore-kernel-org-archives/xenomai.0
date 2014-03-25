MIME-Version: 1.0
In-Reply-To: <532F0BCF.5080603@xenomai.org>
References: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5326AE7E.3050201@xenomai.org>
 <1395076680.34261.YahooMailNeo@web171604.mail.ir2.yahoo.com>
 <1395582539.27462.YahooMailNeo@web171602.mail.ir2.yahoo.com>
 <532F0BCF.5080603@xenomai.org>
Date: Tue, 25 Mar 2014 11:08:20 +0100
Message-ID: <CAKc2HpbToN72M49_6kFo=qys=qvUdT7TRBQi-TC2AehtWVPv+A@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Issue suspending threads on mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

2014-03-23 17:29 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:
> On 03/23/2014 02:48 PM, Matthias Schneider wrote:
>>
>> If I understand correctly, the desired behavior, i.e. sending a signal to
>> a
>> specific thread, would just be achieved up to Linux 2.6.12. Note that I
>> also
>> stumbled over some manpages that did not include the paragraph above...
>>
>
> This makes sense, as the notifier logic was written many moons ago.
>
>
>> Using F_SETOWN_EX like in the attached patch solves my problem (at least
>> the
>> described one) with the misdirected signals. However I still do not
>> understand
>> why the signal seems to have been delivered sometimes to the correct
>> thread and
>> sometimes not, but the answer can probably be found studying the kernel
>> sources..
>>
>
> wants_signal() probably diverts the signal to another thread, because the
> original target is either traced (gdb) or already received a signal which is
> still pending delivery.
>

That would explain what I noticed when using gdb.
I have tested the patch on my setup and the problem is indeed solved.
The signal is now always diverted to correct thread, also when
debugging. Thanks for figuring this out!

