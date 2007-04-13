Message-ID: <461F5389.60309@domain.hid>
Date: Fri, 13 Apr 2007 11:55:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <461F4B89.5090407@domain.hid> <461F501B.2040903@domain.hid>
	<461F51AA.5040608@domain.hid>
In-Reply-To: <461F51AA.5040608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Adeos-main] ADEOS for ARM
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: K-pa <kpa_info@domain.hid>
Cc: adeos-main@gna.org

K-pa wrote:
> Gilles Chanteperdrix a =E9crit :
>=20
>>K-pa wrote:
>> =20
>>
>>>Hy,
>>>I search a version of ADEOS patch for 2.6.17 kernel version for a PXA
>>>processor (ARM arch).
>>>I try to find them on the ADEOS site but I dont found them. So if you
>>>have this patch thanks to send me.
>>>
>>>Thanks a lot.
>>>   =20
>>>
>>
>>Adeos patch for ARM only exists for linux 2.6.14, linux 2.6.15 and linu=
x
>>2.6.19.
>
> Yes, but it is possible to change patch 2.6.19 for 2.6.17 ?!?!
> So I search if someone already this modification carried out.

Adapting 2.6.15 patch to 2.6.17 is easier than adapting 2.6.19. The only
 real reject is the syscall interception in entry-armv.S.

--=20
                                                 Gilles Chanteperdrix

