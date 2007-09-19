From: trem <tremyfr@domain.hid>
Date: Wed, 19 Sep 2007 21:40:54 +0200
Message-ID: <fcru06$t2f$1@domain.hid>
References: <fcjrji$dk1$1@domain.hid> <46F04DF0.60500@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <46F04DF0.60500@domain.hid>
Sender: news <news@domain.hid>
Subject: Re: [Xenomai-core] simple example for rtdm
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> trem wrote:
>> Hi
>>
>> I've written a little exemple for rtdm. It uses open, close, read, write
>> ioctl and 3 kind of buffer (local, device, global). This is an alpha
>> release, so I'll be pleased to get some feedback.
>>
>> you can find it here :
>> http://zarb.org/~trem/tut03-skeleton-drv.c
>> http://zarb.org/~trem/tut03-skeleton-app.c
>> http://zarb.org/~trem/Makefile
> 
> Thanks once again for your effort. I'm sorry that I cannot go into
> details soon, so just a minor comment from the first glance: please fix
> the coding style to kernel style.

I've updated the coding style. It should be better now.

> Jan
> 
> PS: Didn't you also once post a patch for the existing tut02? That's
> probably still hanging around in no-man's land, right?

I've done a patch for tut01, but not for tut02. We have say that
we write a complete tut and after we split it.


