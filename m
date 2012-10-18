Message-ID: <507F8579.6040604@xenomai.org>
Date: Thu, 18 Oct 2012 06:28:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507D7A0C.7090209@gmail.com> <507E05B4.2040704@xenomai.org>
	<507F501A.4000500@gmail.com>
In-Reply-To: <507F501A.4000500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Installing Xenomai Newbie
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U2ViYXN0acOhbiBQYXZleg==?= <sebastian.pavez.t@gmail.com>
Cc: xenomai@xenomai.org

On 10/18/2012 02:40 AM, Sebasti=C3=A1n Pavez wrote:

> El 16-10-2012 22:11, Gilles Chanteperdrix escribi=C3=B3:
>> On 10/16/2012 05:15 PM, Sebasti=C3=A1n Pavez wrote:
>>
>>> Hi,
>>>
>>> My name is Sebastian and I'm a chilean student from PUCV. Currently I=

>>> have to develop a RT proyect, but the problem is that I dont have
>>> experience with Linux and a lot less with Xenomai. Nevertheless i
>>> arrived to install xenomai  2.6.0 on Ubuntu 12.04, but when I try to
>>> execute ubuntu with the xenomai kernel the screen goes black
>>
>> Please remove "quiet" from Linux command line, and make sure that you
>> have all the drivers necessary for the your system to boot, including:=

>> - video display driver
>> - root file system device driver
>> - root file system driver
>>
> Hi,
>=20
> I tried to everything from scratch, but i get the same problem. I tried=
=20
> remove the quiet splash and I could see the line
> "Fallback graphics default" well, this is when I execute the kernel wit=
h=20
> xenomai in recovery mode. Because when I tried it in
> a normal way I get the blacl screen with a twinkle, in this case I'm=20
> able to put my password and I heard the entry sound (with some=20
> distorsion), so like you said it maybe some driver's problem.
> In the recovery mode I checked the application drivers and nothing.=20
> Maybe it's something simple but I'm quite stuck, I've never used linux =

> before and I really need to get this operative, so if you or someone=20
> else could help me ... in plain language would be awesome ...
> Thanks in advance
>=20
> PS: In the recovery mode I tried the xenomai tests, I attached the=20
> captures ...


Your problem is configuring the kernel. So, please start with the Ubuntu
kernel configuration, and simply disable the problematic options
described here:
http://www.xenomai.org/index.php/Configuring_x86_kernels

If you do not know how to configure and compile a kernel, I suggest you
read some documentation on the web, such as:
http://kernelnewbies.org/KernelBuild

--=20
                                                                Gilles.


