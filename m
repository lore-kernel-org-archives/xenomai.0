From: "Poole Jr, Donald R." <donald.poole@swri.org>
Date: Thu, 28 Aug 2014 15:12:27 +0000
Message-ID: <D024AFFD.53F9%donald.poole@swri.org>
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>
 <53FDFD27.2010207@xenomai.org>
 <CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>
 <53FF33CE.10303@xenomai.org>
In-Reply-To: <53FF33CE.10303@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <19E4BDF3BB92C940A6FF8023EDC8E6DE@sw.pvt>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] ODROID-U3 porting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 8/28/14, 8:51 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

>On 08/28/2014 03:45 PM, GP Orcullo wrote:
>> On Wed, Aug 27, 2014 at 11:45 PM, Gilles Chanteperdrix
>>> So, this is a cortex a9. On Cortex a9, Xenomai tries to use the global
>>> timer for tsc emulation. Are you sure this processor has a global
>>>timer?
>>> Again, running the "tsc" program will help you see if the tsc emulation
>>> is working correctly.
>>=20
>> AFAIK, the exynos soc doesn't use twd - they have a multi-core timer
>> instead. There is one global timer and a local timer for each core.
>>=20
>> BTW, is it necessary that there should be an ipipe timer for each core
>> or a single
>> "global" one will do?
>
>The global timer is not the same thing as the twd, and I was talking
>about using the global timer as a clock source (for tsc emulation), not
>as a timer, the advantage being that you would have a much better
>resolution. Xenomai indeed requires local timer support (for which it
>uses twd on cortex a9), that is one timer per core.
>
>--=20
>                                                                Gilles.
>
>_______________________________________________
>Xenomai mailing list
>Xenomai@xenomai.org
>http://www.xenomai.org/mailman/listinfo/xenomai

Gemi - Is your work on patching the Odroid-U3 kernel available on github
or elsewhere?  I would really like to have my U3 running Xenomai in this
manner as well.  I=B9ve been working to achieve the same thing, but I
appears that you have made far better progress.

-Donald


