Message-ID: <511027E6.4080202@icid.cu>
Date: Mon, 04 Feb 2013 16:28:06 -0500
From: raespi <raespi@icid.cu>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu> <510FFE7C.1090601@xenomai.org>
	<51100A6B.90701@icid.cu> <5110122C.2090807@xenomai.org>
	<511021FC.7080906@icid.cu> <51102316.9090107@xenomai.org>
In-Reply-To: <51102316.9090107@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>

Well we have a very big team working with linux on the smdk2440, from=20
what we've seen, the 3.4 version breaks the audio in a very weird way.  =20
We're also merging other changes like the ones from the AF_DBUS project,=20
but they're using other versions and it's a bit complicated.  Still all=20
our changes will be submitted back to you ... I want to test Xenomai a=20
bit more and see how it improves my system's response times, when I have=20
more info I will send the full changes ...

Thanks again ..

El 02/04/2013 04:07 PM, Gilles Chanteperdrix escribi=C3=B3:
> On 02/04/2013 10:02 PM, raespi wrote:
>
>>   Right, I'm using these tools and options:
>>
>> *- toolchain:*
>> 4.6.3 (Sourcery CodeBench Lite 2012.03-57)
>>
>> *- configure options ( Running under buildroot, no special recipe, it
>> comes with one for the 2.6.0 version ):*
>> $ ./configure --target=3Darm-linux --host=3Darm-linux
>> --build=3Di686-pc-linux-gnu --prefix=3D/usr --exec-prefix=3D/usr
>> --sysconfdir=3D/etc --program-prefix=3D --disable-gtk-doc --enable-ipv=
6
>> --enable-static --enable-shared --includedir=3D/usr/include/xenomai/
>>
>> *- Prepin' the kernel:*
>> $(XENOMAI_DIR)/scripts/prepare-kernel.sh --linux=3D$(LINUX_DIR) --arch=
=3Darm
>> --adeos=3Dadeos-ipipe-3.1.10-arm-001.patch
>>
>> I think I saw the problem.   Buildroot doesn't pass the " -march=3Darm=
v4t
>> -msoft-float"  CFLAGS and LDFLAGS options to the xenomai configure lin=
e
>> for the s3c24xx.  At least the *xeno-test* is running now ...
>
> Good news. It is strange that not passing these options does not cause
> other run-time errors though (like invalid instructions).
>
>> Thanks for your time, are you interested in the complete patch for the
>> 3.1.10 version ?? ...
>
> Yes, that is interesting, but 3.1 is a bit old, I am not sure you have
> all the fixes, any reason for not using 3.2?
>
> Please keep the mailing list in CC.
>



