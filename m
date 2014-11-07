From: "Registrierungen" <regist@bmwedler.de>
References: <54509406.4000600@bmwedler.de> <54509629.8080107@bmwedler.de>
 <54577374.9010609@bmwedler.de> <5457811D.2030502@xenomai.org>
 <5457818E.80806@xenomai.org> <54579D7A.2010800@bmwedler.de>
 <5457A482.7040900@xenomai.org>
In-Reply-To: <5457A482.7040900@xenomai.org>
Date: Fri, 7 Nov 2014 12:12:22 +0100
Message-ID: <0a3d01cffa7b$b8b9f5f0$2a2de1d0$@bmwedler.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: de
Subject: Re: [Xenomai] Using pipes in 3.0rc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Philippe Gerum' <rpm@xenomai.org>, xenomai@xenomai.org

It works now!=20
Thanks for your support.

Sascha

-----Urspr=FCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org]=20
Gesendet: Montag, 3. November 2014 16:52
An: Registrierungen; xenomai@xenomai.org
Betreff: Re: [Xenomai] Using pipes in 3.0rc

On 11/03/2014 04:21 PM, Registrierungen wrote:
> I tried with rc2, but now it returns with error 3 (not -3) ?

http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Message_pipes

>=20
>=20
> Am 03.11.2014 14:22, schrieb Philippe Gerum:
>> On 11/03/2014 02:20 PM, Philippe Gerum wrote:
>>> On 11/03/2014 01:22 PM, Registrierungen wrote:
>>>> Sorry for the late feedback.
>>>>
>>>> I found the source where it goes wrong:
>>>>
>>>>      if (poolsize > 0) {
>>>>          ret =3D __RT(setsockopt(sock, SOL_XDDP, XDDP_POOLSZ,
>>>>                        &poolsize, sizeof(poolsize)));
>>>>          if (ret)
>>>>              goto fail_sockopt;
>>>>      }
>>>>
>>>> Hope there could be found a solution for me.
>>>>
>>> The solution was given a few days ago:
>>>
>>> http://www.xenomai.org/pipermail/xenomai/2014-October/032054.html
>>>
>> Those patches are present in -rc2, released a couple of days ago. You =

>> should not bother with -rc1 anymore.
>>
>=20
>=20


--
Philippe.


