Message-ID: <47884.194.114.62.34.1186673320.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0708090824w640a8256o37fd581fbdcd1d7@domain.hid>
References: <54803.194.114.62.34.1186665301.squirrel@domain.hid>
	<2ff1a98a0708090622n7e9ca37bya6409b4abd1ccb7b@domain.hid>
	<62642.194.114.62.34.1186669072.squirrel@domain.hid>
	<2ff1a98a0708090824w640a8256o37fd581fbdcd1d7@domain.hid>
Date: Thu, 9 Aug 2007 17:28:40 +0200 (CEST)
From: "Nadym Salem" <Kaiman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai kernel panic
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

On Thu, August 9, 2007 17:24, Gilles Chanteperdrix wrote:

>> >> as I wanted to get the new patch for Xenomai (as discussed in rtnet
>> >> mailing list for the rt_dev_close() issue) I had to install Xenomai
>> 2.4.
>> >> Xenomai 2.3.2 with Rtnet 0.9.9 didn't make any trouble.
>> >> Since I installed 2.4 with Kernel 2.6.20 the Kernel doesn't start
>> >> anymore.
>> >> We used the same config and the same kernel but now the kernel
>> doesn't
>> >> find the hard-disc anymore (waiting f=FCr /sys/block/sda/dev: no su=
ch
>> file
>> >> or directory).
>> >> Any idea  ?
>> > The configuration of the SATA discs changed in recent kernel, be sur=
e
>> > to enable your sata controller in the new menu (Serial ATA (prod) an=
d
>> > Parallel AT (experimental) drivers)
>> They are in....but as I just saw, while booting it says "error inserti=
ng
>> module xy: -1 Invalid module format. Repeating with several modules
>> including the ata stuff.
> You forgot make modules_install.

That would be too easy. For the moment I use a workaround due to lack of
time. Thanks for the moment, I will look after that in September ;)

Greets, Nadym


