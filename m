Message-ID: <50DDBE66.3040405@xenomai.org>
Date: Fri, 28 Dec 2012 16:44:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50dd8fe7a2bbd6.25169205@wp.pl> <50DDB448.2050307@xenomai.org>
	<50DDBBE2.20403@gmail.com>
In-Reply-To: <50DDBBE2.20403@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] posix/stdio.h error: ?size_t? does not name a type
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hauptmech <hauptmech@gmail.com>
Cc: xenomai@xenomai.org

On 12/28/2012 04:33 PM, hauptmech wrote:

> On 12/28/2012 04:01 PM, Gilles Chanteperdrix wrote:
>> On 12/28/2012 01:26 PM, Mariusz Janiak wrote:
>>
>>> Hi
>>>
>>> After successful Xenomai 2.6.2 installation (with Gilles help), I hav=
e started building OROCOS 2.6 with xeno support, and once again I went in=
to trouble. This time I am not sure that it is a Xenomai related bug. The=
 problem is following
>>>
>>> from /worek/install/orocos-toolchain-xeno/rtt/rtt/transports/mqueue/M=
QLib.hpp:42,
>>>                       from /worek/install/orocos-toolchain-xeno/rtt/r=
tt/transports/mqueue/MQLib.cpp:40:
>>>      /usr/xenomai/include/xenomai/posix/stdio.h:30:1: error: ?size_t?=
 does not name a type
>>>      make[2]: *** [rtt/transports/mqueue/CMakeFiles/rtt-transport-mqu=
eue-xenomai_plugin.dir/MQLib.cpp.o] B=C5=82=C4=85d 1
>>>
>>> I have found one thread related to this problem
>>>
>>> http://www.xenomai.org/pipermail/xenomai/2012-September/026143.html
>>>
>>> Adding #include <unistd.h> in /usr/xenomai/include/xenomai/posix/stdi=
o.h have solved my problem, but I don't know if it is a suitable solution=
=2E
>>
>> Hi Mariusz,
>>
>> thanks for the report. Could you tell me which distribution and which
>> version you are using? We are certainly not going to include unistd.h =
in
>> stdio.h, the fact that size_t is not defined indicates that something
>> else is wrong as there are services supposedly defined in stdio.h whic=
h
>> use size_t.
>>
>> Regards.
> http://gcc.gnu.org/gcc-4.7/porting_to.html (search for unistd.h)
>=20
> The correct fix is probably to add unistd.h to MQLib.hpp (and other=20
> include files that are missing it)


This does not look like the same issue: using size_t is valid in stdio.h
without including unistd.h

I will install the same distribution as Mariusz to try and reproduce the
issue.

--=20
                                                                Gilles.


