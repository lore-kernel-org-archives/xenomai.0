From: "Alex" <devnull@domain.hid>
References: <3d3b73870805061301m4a89029eqa69c17b212274f38@domain.hid>	<6132061f0805071046h65ce2f7eme4fade4c404223a9@domain.hid>	<2ff1a98a0805071052g1515edbam19ad164ce2e53b5d@domain.hid>	<6132061f0805071406p72fde054i68e0d942bcff7748@domain.hid>	<18466.7374.342618.854340@domain.hid>	<6132061f0805071427o494b28d3jf0289ef9a195ef90@domain.hid>	<18466.8349.380119.79195@domain.hid>
	<6132061f0805111302n769b3787oe2f3d14e2123fa59@domain.hid>
In-Reply-To: <6132061f0805111302n769b3787oe2f3d14e2123fa59@domain.hid>
Date: Sun, 11 May 2008 23:38:07 +0200
Message-ID: <019201c8b3af$4e7ca760$eb75f620$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: de
Subject: Re: [Xenomai-help] Does Xenomai 2.4.x support Xenomm ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Breno Carneiro Pinheiro' <brenodee@domain.hid>
Cc: xenomai@xenomai.org

>Hi, I think I got solved the last error ( ./task_test : error while =
loading
shared libraries : libnative.so.0 : cannot
=A0> open shared object file : Not such file or directory) when I tried =
to
execute my application below:
=A0
>void task_body (void *cookie)
=A0{
=A0=A0=A0=A0 for (;;) {
=A0=A0=A0=A0 printf("%s\n",'a');
=A0=A0=A0=A0 }
=A0}
=A0
>I used the Makefile attached!!!
>But now, when I execute ./task_test on my environment I got:
>segmentation fault
>
>Does it any relation with my application?

Check printf() in your task_body: 'a' is not a null-terminated string.
Instead of=20
printf("%s\n",'a') it should be
printf("%s\n","a") or=20
printf("%c\n",'a')

Alexander



