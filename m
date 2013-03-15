Message-ID: <514360E0.2050706@xenomai.org>
Date: Fri, 15 Mar 2013 18:56:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.99.1363213184.1444.xenomai@xenomai.org>
	<374d78ea.a5c8.13d6c77cb72.Coremail.wu_jianfeng@126.com>
In-Reply-To: <374d78ea.a5c8.13d6c77cb72.Coremail.wu_jianfeng@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai UBUNTU memory Leak
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5ZC05YmR6ZSL?= <wu_jianfeng@126.com>
Cc: xenomai@xenomai.org

On 03/15/2013 06:13 AM, =E5=90=B4=E5=89=91=E9=94=8B wrote:

> Hi


Hi,

>=20
> We have got a memory leak problem . The system config is Ubuntu 11.04
> (linux kernel 2.6.38.8) ,Xenoami 2.6.0 and hardware was based on X86
> .


Please upgrade to xenomai 2.6.2.1. 2.6.0 is outdated.

> When we fininshed install the xenomai ,we found a strange  problem
> that is system memory is leaked . However you open any program the
> memory will increased ,but close the program the memory will never be
> free and just a little increased. For exampl(the system memory is 2G
> ,CPU is intel i7) ,open a Qt IDE ,memory will be increased 60Mbytes
> then closed it ,but the memory will not be free maybe just 10MB.
> Ifyou open and closed any software a lot of times ,the valid  system
> memory will be nothing(maybe 50MB only)  .We don't running any user
> application by us . we really have no idea !
>=20
> Our application is high speed Machine vision . We want use a task to
> check the camera pick imaged done signal by evry task cycle(500us),
> another Task  is for handle the image and analysis then sent to a
> signal to hardware . When we running our applicaton program the
> probelm is same ,system memor will be down again until the computer
> dead or the our program not working .
>=20
> Please help us ,what is problem ?what is issue? we have try a lot  in
> last weeks ,no idea !


Well, I have no idea what you are talking about. Which memory increases?
Are you sure you are not fooled by the fact that Linux usees as much RAM
as possible as filesystem cache?

Regards.

--=20
                                                                Gilles.


