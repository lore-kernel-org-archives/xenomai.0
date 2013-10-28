Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
From: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>
In-Reply-To: <526E3407.9050400@xenomai.org>
Date: Mon, 28 Oct 2013 14:36:16 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <072A853B-9DEA-4272-B2CA-88CA5FFCD8B1@gmail.com>
References: <C0EBEDB7-2439-4083-AF21-4896462E5B7E@gmail.com>
 <526E3407.9050400@xenomai.org>
Subject: Re: [Xenomai] Static linking fails for global mutex variable(c++
	class) on embedded system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

How exactly is the xenomai library initialised?
Is this a kind of system function call performed by the application?

Can you check whether or not the xenomai library is initialised at a =
certain point in the application?

As for the wrap-link.sh, we use that in our static linking.

Regards,
Jan Jaap

Op 28 okt. 2013, om 10:53 heeft Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> het volgende geschreven:

> On 10/28/2013 10:44 AM, Jan Jaap Kempenaar wrote:
>> Hello,
>>=20
>> For our projects we developed a multiplatform library which is used
>> to create our applications. We are now porting this to Xenomai.=20
>> Because we compile for embedded targets, in this case an ARM board,
>> we use static linking as it might occur that dynamic libraries are
>> not available.
>>=20
>> In one of our test cases we compile a global class containing a
>> mutex. This class gets initiated before the main function.
>=20
> Whether this works depends on initialization order: the Xenomai =
library
> has to be initialized before you call pthread_mutex_init, and this is
> probably not true when you link the library statically. The only
> solution is to defer the call to pthread_mutex_init somehow.
>=20
> Also note that in order to static link the Xenomai library, you have =
to
> use the "wrap-link.sh" script.
> --=20
>                                                                Gilles.


