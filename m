Message-ID: <5111275D.2030807@icid.cu>
Date: Tue, 05 Feb 2013 10:38:05 -0500
From: raespi <raespi@icid.cu>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu>
	<510FFE7C.1090601@xenomai.org>	<51100A6B.90701@icid.cu>
	<5110122C.2090807@xenomai.org>	<511021FC.7080906@icid.cu>
	<51102316.9090107@xenomai.org>	<511027E6.4080202@icid.cu>
	<51110A7E.4020506@icid.cu> <51111CC2.3040204@xenomai.org>
	<51111DB6.4030809@icid.cu> <51111E46.4070706@xenomai.org>
	<511122D3.8000501@icid.cu> <51112476.2030500@xenomai.org>
	<511125B9.7020403@icid.cu> <5111260A.2000609@xenomai.org>
In-Reply-To: <5111260A.2000609@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] about switchtest ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

So you're saying that I'm correctly passing the CFLAGS and LDFLAGS for=20
all the other packages on my system ( kernel, busybox, dbus, my apps,=20
etc ... ) but not to the Xenomai build ?? I fail to understand your=20
point ...

On Buildroot I have:
1- BR2_GCC_TARGET_ARCH=3D"armv4t"
2- BR2_SOFT_FLOAT=3Dy

Both translated in to good old GCC parameters are "-march=3Darm4vt=20
-msoft-float". So ???

El 02/05/2013 10:32 AM, Gilles Chanteperdrix escribi=C3=B3:
> On 02/05/2013 04:31 PM, raespi wrote:
>
>>   I know, which is why I'm currently between two mailing lists trying =
to
>> solve it.  I have already registered the bug on the Buildroot site.  F=
or
>> followups this is the url:
>> https://bugs.busybox.net/show_bug.cgi?id=3D5900
>
> And again: this probably has nothing to do with buildroot.
>



