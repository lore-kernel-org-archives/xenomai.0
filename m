Message-ID: <4DC04DF4.1050807@domain.hid>
Date: Tue, 03 May 2011 20:48:20 +0200
From: Uwe Fechner <u.fechner@domain.hid>
MIME-Version: 1.0
References: <4DBD4DA6.2070101@domain.hid> <201105031436.37688.kisda@domain.hid>
In-Reply-To: <201105031436.37688.kisda@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Building Xenomai for Ubuntu 10.10 32 bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

 Hello Stefan,

thank you for your support.

I managed to compile Xenomai for Ubuntu 10.10, but it did require many
more steps,
than you have documented so far.

I documented my approach here:
http://www.kieltech.de/uweswiki/Xenomai

The two main problems, that remain are:

1. The clocktest program sometimes shows a time offset of +- 500 =B5s, bu=
t
this problem disappears by itself after some minutes.

2. The minimal and average time, that is measured by the latency test is
sometimes negative (-1 to -2.2 micro seconds).

Any suggestions, how to tackle these problems?

Best regards:

Uwe Fechner

On 03.05.2011 14:36, Stefan Kisdaroczi wrote:
> Hi,
>
> Am Sonntag 01 Mai 2011, 14.10:14 schrieb Uwe Fechner:
>>  Hello,
>>
>> I am trying to compile Xenomai for Ubuntu 10.10 32 bit for
>> a Dell Latitude E6400 Laptop.
>>
>> First I tried to follow the following explanations:
>> http://www.xenomai.org/index.php/Building_Debian_packages
> ok
> =20
>> I had the following problems:
>> - the Xenomai version, that comes with Ubuntu 10.10 is
>>   very old, so I tried to compile my own packages
> ok
>
>> - using git didn't work, because I needed a user name and
>>   password, that I don't have (the following command failed:)
>>   git clone git://xenomai.org/xenomai-2.5.git
> There is no password to access the git repository. Are you behind a pro=
xy?
>
>> - then I tried to compile packages from a tar.bz2 archive
>>   I was able to compile the packages, but they did not work
> What did not work?
>
>>  I suppose, that I have some wrong .config options.
>>
>> I then tried to compile a Linux kernel in the way, that is
>> suggested for Ubuntu, using this tutorial:
>> [...]
>> Now my questions:
>> I would like to use kernel 2.6.38 or 2.6.39-RC5 with
>> xenomai 2.5.6.
>>
>> 1) Is this a good choice, or is an older kernel or an older
>>    version of Xenomai more likely to work?
> There is no adeos-ipipe-patch for 2.6.38 or .39-RC5.
>
>> 2) Do I need to run scripts/prepare-kernel.sh, or not?
>>    This is mentioned at:
>>    http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL
>>    but not mentioned at:
>>    http://www.xenomai.org/index.php/Building_Debian_packages
> If you follow "Building_Debian_packages" you dont need it.
>
> If you are able to copy&paste the commands from "Building_Debian_packag=
es"=20
> into your local console, it should work. If not, please tell which step=
 failed=20
> and why (exact error message).
>
> Stefan


--=20
----------------------------------------
Uwe Fechner, M.Sc.
Delft University of Technology
Faculty of Aerospace Engineering/ASSET
Kluyverweg 1,
2629 HS Delft, The Netherlands
Phone: +31-15-27-88902


