MIME-Version: 1.0
In-Reply-To: <542B148E.1000301@xenomai.org>
References: <CABVE6k1dDnGUBQSRCDCAcgbnY-eFP422WCwTzZWQPKiD997E-w@mail.gmail.com>
 <2193EAD1-45DF-4E12-8FFD-34AC726315E9@mah.priv.at>
 <CABVE6k1OG+SyDBJuUzJfS8sXi3PO8E2VuHcF6HF126A7j-yLYg@mail.gmail.com>
 <542A97C7.8000701@xenomai.org>
 <CABVE6k2L1Rh5R0E7L6TPFJ8ri7yFX02HGaRR+7WYSReZM9xKFQ@mail.gmail.com>
 <542AC724.5010406@xenomai.org>
 <CABVE6k3PZFRCvvSK+=ZKoU6MPdCZHT0E_4h7WqPzACBLSd-Udg@mail.gmail.com>
 <542ADE09.2020008@xenomai.org>
 <CABVE6k22eS8PXUKHRhAy3wTtbMqFrA7Vy+AyjUT9ipqAmLwckQ@mail.gmail.com>
 <542AF7CF.1090600@xenomai.org>
 <CABVE6k33e1SAa4J0QL5p4Z3vs5DZDhH9zQ4ZxX6+1pPodsd4iw@mail.gmail.com>
 <542B11DB.6050904@xenomai.org>
 <CABVE6k2+rvZiFA26X4_4EtJSax1q9BGryMUauBVR=jsav9de-g@mail.gmail.com>
 <542B148E.1000301@xenomai.org>
From: =?UTF-8?Q?Hasret_Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Date: Tue, 30 Sep 2014 23:39:54 +0300
Message-ID: <CABVE6k3ftTyZ0rgfZTZ9RQNHSUmjAKR2MQT2vVomoGiM0omhCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai: binding failed: Operation not permitted.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

2014-09-30 23:37 GMT+03:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On 09/30/2014 10:34 PM, Hasret Sar=C4=B1yer wrote:
> > I did  configuration like this guide.
> > <
> http://xenomai.org/2014/06/building-debian-packages/#patch_and_configure_=
the_kernel
> >
> > When
> > I run "*echo "<gid>" > /sys/module/xeno_nucleus/parameters/xenomai_gid"
> *as
> > root*,*the error was Invalid argument. As not root, the error was
> *"Permission
> > denied".*
>
> Are you for real? <gid> should be replaced with the gid of a group of
> your choice, as per the first sentence of the documentation:
> "As of Xenomai release 2.3.2, you can allow non-root users to access
> Xenomai services from user space. You only have to provide the ID of a
> unix group whose members shall obtain this right plus additional Linux
> capabilities required to work with Xenomai.
>
> And of course you need to be root to pass this argument.
>
> --
>                                                                 Gilles.
>


sorry, I am newbie.
