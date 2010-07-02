From: Fredrik Asplund <fasplund@domain.hid>
Date: Fri, 2 Jul 2010 12:29:17 +0000
Message-ID: <22150A2C94CC924695BE248F94CD11F2D375@domain.hid>
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>
	<4C2A518F.8030302@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>
	<4C2B0043.1070108@domain.hid>
	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D063@domain.hid>
	<AANLkTinqA_l4Jersd-1EfCMecqal2ZkSepe5DhtQAEJ3@domain.hid>
	<22150A2C94CC924695BE248F94CD11F2D27F@EXDB4.ug.kth.se>
In-Reply-To: <22150A2C94CC924695BE248F94CD11F2D27F@EXDB4.ug.kth.se>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>>I've edited the bitbake files for the kernel, but what I usually do is to
>>run the unpack script, replace the flush.c file, and keep the process goi=
ng.
>>The defconfig is pretty much standard, except that I've enabled several
>>debugging options and got rid of a few troublesome pieces of code (power
>>management, CPU Freq. scaling, etc...). As for the edits, they seem very
>>similar to yours, but I didn't look at them very carefully.
>>Fredrik, did you managed to get a kernel compiled at all?
>
>Yes, no problems in compiling, but I have not yet had the time to actually=
 run the resulting image. I will >check where my setup crashes (no doubt it=
 will... :/) and compare our files to see if I can figure something >out.

Now I had time to test the resulting image. It boots up without obvious pro=
blems and does not seem to be unstable over time either.

However, I am unsure of how to test if Xenomai *actually* works (I found xe=
no-test in /usr/bin/, but I am unsure of how to judge the output... there d=
oes not seem to be any ERROR messages in it though). Anyone who can tell me=
 how to do this?

(BTW - I will add a description on what I did + the files to my project wik=
i. I will send you a link when it is done, sometime this weekend I guess...=
)

/ Fredrik

