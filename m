MIME-Version: 1.0
In-Reply-To: <4BE10B3F.20708@domain.hid>
References: <n2k633455b31005041938k29ad6c0br4e8092c19232ed68@domain.hid>
	<4BE10B3F.20708@domain.hid>
Date: Wed, 5 May 2010 20:36:28 +0800
Message-ID: <j2w633455b31005050536k23b55461g843efe866779d8d3@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] install xenomai for beagleboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Thanks for your reply. It is very helpful for me and probably for many
who are just getting started in
beagleboard.

Best regards,

Everett

On Wed, May 5, 2010 at 2:07 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> (...)
>> It runs fine. But I have some random questions.
>>
>> where is the bzImage it made and modules I just made?
>
> bzImage is an x86 thing. Your questions is not really specific to
> Xenomai, it is about compiling a Linux kernel for ARM. There are a lot
> of resources on internet which will answer this question. For instance,
> this is answered by Linux arm kernel FAQ #1:
> http://www.arm.linux.org.uk/mailinglists/faq.php#f1
> Or, Beagle specific instructions on Beagle wiki:
> http://elinux.org/BeagleBoard#Linux_kernel
>
>> Should I use a
>> newer version of Code Sourcery's cross compiler? I am using
>> arm-2009q1-203-arm-none-linux-gnueabi and there is an
>> arm-2010q1-202-arm-none-linux-gnueabi. I have difficult to follow
>> in compiling xenomai.
>
> Any version should be almost Ok. Except one of the 2008 version if you
> want to enable stack unwinding.
>
>
>> The instruction reads:
>>
>> "cd $build_root
>> $ $xenomai_root/configure --build=3Di686-pc-linux-gnu --host=3Darm-linux
>> --enable-arm-mach=3Dat91rm9200 --enable-arm-tsc"
>>
>> I have not defined a $build_root directory and what is the right name
>> to replace at91rm9200 and tsc?
>
> the instructions also read:
> --enable-arm-mach =A0 Select ARM machine for the =A0 =A0 =A0 none
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0current build tree, check
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0configure --help for a list
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of valid values.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Passing this option is
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mandatory when compiling
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Xenomai for ARM
>
> and:
> # $linux_tree =3D path to the target kernel sources
> # $xenomai_root =3D path to the Xenomai sources
> # $build_root =3D path to a clean build directory
> # $staging_dir =3D path to a directory that will hold the installed file
>
> Again, the issue here is about compiling a package using the autotools,
> there is nothing specific about Xenomai. There is a lot of resources
> about this on the web. For instance:
> http://sources.redhat.com/autobook/autobook/autobook_13.html#SEC13
> I even wrote a tutorial for the autotools some time ago:
> http://sisyphus.hd.free.fr/~gilles/pub/autotools/
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

