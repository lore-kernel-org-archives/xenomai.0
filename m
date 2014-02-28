Message-ID: <5310AEDE.9050501@control.lth.se>
Date: Fri, 28 Feb 2014 16:44:30 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <53107B01.2000103@control.lth.se> <5310A51F.8080607@xenomai.org>
In-Reply-To: <5310A51F.8080607@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3 and native RTDM question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>
Cc: comedi_list@googlegroups.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2014-02-28 16:02, Philippe Gerum wrote:
> On 02/28/2014 01:03 PM, Anders Blomdell wrote:
>> With Xenomai-3, will it be possible to use the native RTDM an a
>> vanilla kernel, or only on PREEMPT_RT kernels?
> 
> Any kernel will do, provided it fits the user requirements in terms
> of response and execution time. PREEMPT_RT is not a pre-requisite for
> x3, it's an option, just like the Cobalt co-kernel is. There are
> projects currently based on x3 over plain 3.x kernels, only to
> leverage the legacy RTOS emulation capabilities.
> 
> The reason that I ask, is that I need to upgrade the
>> software in our labs (vanilla kernels, mostly) and would like to
>> get comedi (www.comedi.org) to work with RTDM (so I get all the
>> drivers from comedi, the analogy double effort seems like a bad
>> idea to me).
> 
> In all fairness, Alex - the Analogy author - tried hard to contribute
> to Comedi at a time when the project was stalled, and also to avoid
> duplicate effort: http://osdir.com/ml/comedi/2006-04/msg00017.html 
> https://lkml.org/lkml/2009/5/6/543
> 
> The intent was to port Comedi over RTDM since day one. Apparently, it
> turned out that Alex could not find anyone to work with from the
> Comedi team for evolving the code, hence Analogy.
Yes, that comedi got into the kernel staging area really made realtime stuff hard. If I 
understand it correctly, RTDM was also not possible for vanilla kernels at that time?

I think it might be worth a new try.

/Anders
- -- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTEK7eAAoJENZYyvaDG8Nc/UsH/3DeOqtv2eI0wigdirbU2jTV
2jbSiPZHymKZ6oMTPxJWZiSHmDPxNir+F0AFhg37yjgP5f+nJu9IVpXnawOBKsM2
GfjnULt1nSBTkIsZsBDI6Y7izFQIZLd8fxwHXJDC0Yfb0JMOxwG1/SuO4c7gIuDe
ZJP7Cuep2PbfhCinLbltCN5oZ8XiSsDbCrypE8PjUfJhKLh1yTUuNhVwtlCpg2Kw
w5xRbx9ZRy9GqOjNXfJyBJbDEh21SDYHmz8YeWz4D/OIVI4Wqx/59n/UArg7b4H/
7xkjEP4HXfUx3fhrmIp+K6qAiNrVE4E9CfZw4DR1aQyuxKf+lZS5qK9FEmh18Zs=
=xW94
-----END PGP SIGNATURE-----

