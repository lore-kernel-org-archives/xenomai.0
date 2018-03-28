MIME-Version: 1.0
In-Reply-To: <1522224881.2732.2.camel@sprinte.eu>
References: <CAOuPNLjGFNwaCNa1zGQY4gZpLC7J=5M4EzGNS-YiK1UOx=+t0w@mail.gmail.com>
 <1522224881.2732.2.camel@sprinte.eu>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 28 Mar 2018 15:34:16 +0530
Message-ID: <CAOuPNLiMyXRLBOcLSbpVtuSKc=2tkM+mQXQoXH79GXBjhz8Zsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Mar 28, 2018 at 1:44 PM, Julien Blanc <julien.blanc@sprinte.eu> wro=
te:
> Le mercredi 28 mars 2018 =C3=A0 13:24 +0530, Pintu Kumar a =C3=A9crit :
>> Hi,
>>
>> We are facing one issue on Xenomai-3 on x86_64 system.
>> Kernel: 4.9.51
>> ipipe version: 4
>> # /usr/xenomai/sbin/version
>> Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20 12:13:33 +0100)
>>
>> Its a very simple API level test.
>> We create a condition variable and wait for the condition inside a
>> task.
>> Then, we immediately signal the condition from the main thread, and
>> simply
>> wait for the test to finish.
>
> Looks like you're signalling the condition variable before it is even
> begin waited by the newly created thread, so i would say the behaviour
> is normal.
>
> If this is just for test purpose, you can for example add a sleep
> inside your main thread so that you make sure that the child thread
> reaches the rt_cond_wait call before the main thread executes
> rt_cond_signal.
>

Oh yes, I already tried by adding 1 second sleep before signal, but still t=
he
condition task hangs.

This test case works fine on Xenomai 2.6


> Regards,
>
> Julien
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

