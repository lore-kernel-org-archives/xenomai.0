Date: Wed, 08 Jul 2015 16:57:46 -0400
From: Glen Wernersbach <glen@jetsoftdev.com>
Message-ID: <D1C2D578.39B56%glen@jetsoftdev.com>
References: <D1C206F1.39ADA%glen@jetsoftdev.com>
 <20150708101145.GL20176@hermes.click-hack.org>
In-Reply-To: <20150708101145.GL20176@hermes.click-hack.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable
Subject: Re: [Xenomai] Xemomai 3 - posix demo programs don't seem to be
 loading the right socket program.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Giles,

RsConMain was just a copy of  the bufp-readwrite demo program so I could
fool around with the make file to see if I could prove the wrapper was
loading. The code is the standard unmodified demo of the bufp-readwrite
demo example.

As it turns out as you suspected, for the standard demos that are
installed to work, you must go in and change the Xenomai kernel setting
RTIPC Protocol Family from its default value of excluded/Off and change to
an included/On setting.

Once that was done all of the demo programs and my copy worked just fine.

Glen
--=20
Glen Wernersbach View Profile <http://www.linkedin.com/in/GlenWernersbach>
Business, Innovation and Technical Consultant;
President and CEO
Jetsoft Development Co.


629 Old St Rt. 74 =AD Suite 210
Cincinnati, Oh 45244

513-240-9929
glen@jetsoftdev.com




On 7/8/15, 6:11 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

>On Tue, Jul 07, 2015 at 10:45:05PM -0400, Glen Wernersbach wrote:
>> Hi All,
>>=20
>> Fooling around with Xenomai 3 RC4. I can get the TestSuite to work but
>>when
>> I run any of the standard posix demo examples I get the following error:
>> ./bufp-readwrite
>> socket 1: Address family not supported by protocol
>> socket 2: Address family not supported by protocol
>>=20
>> Looking on the web this would indicate that the wrapper instruction is
>>not
>> in the linker flags but it is. I tried building my own copy just to make
>> sure the wrapper was included but got the same error.
>> make
>> gcc -o RsConMain RsConMain.c -I/usr/xenomai/include/cobalt
>> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
>> -Wl,@/usr/xenomai/lib/cobalt.wrappers   -L/usr/xenomai/lib -lcobalt
>> -lpthread -lrt =20
>
>I do not think "RsConMain" is a "standard posix demo example", or I
>do not know what you mean by that. Anyway, providing the source of
>the code you compile would allow us to help you instead of making
>educated guesses. But the obvious question is: do you have the
>support for the socket family you are trying to use enabled in the
>kernel configuration?
>
>--=20
>					    Gilles.
>https://click-hack.org



