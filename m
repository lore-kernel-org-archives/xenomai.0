Message-ID: <50DDDDEF.7060400@xenomai.org>
Date: Fri, 28 Dec 2012 18:59:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50dd8fe7a2bbd6.25169205@wp.pl>
	<50DDB448.2050307@xenomai.org>	<50DDBBE2.20403@gmail.com>
	<50DDBE66.3040405@xenomai.org>	<50DDCFB4.3070206@nta-inc.net>
	<50DDD0A6.3080305@nta-inc.net> <50DDD713.7080808@nta-inc.net>
In-Reply-To: <50DDD713.7080808@nta-inc.net>
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
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 12/28/2012 06:29 PM, Jeff Webb wrote:

> Here's some more information.  This C++ program fails to compile
> under Xenomai because =E2=80=98size_t=E2=80=99 does not name a type.  I=
t compiles
> fine without Xenomai:
> (...)
> I hope this helps.


A lot, thanks, please try the following commit:
http://git.xenomai.org/?p=3Dxenomai-2.6.git;a=3Dcommit;h=3D943a0801349548=
f85227f7a3032eb6ac0a5258e2

--=20
                                                                Gilles.


