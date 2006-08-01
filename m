From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17615.25409.355632.931296@domain.hid>
Date: Tue, 1 Aug 2006 16:20:49 +0200
Subject: Re: [Xenomai-help] Convert Linux PosixThreads to Xenomai PosixThreads
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A46D6A5@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A46D6A5@domain.hid>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > I try to port some software, which runs on native Linux, to Xenomai.
 > As the original SW uses Posix calls, I thought, I just have to compile=
 with Xenomai-header files, link Xenomai-libraries, use the Xenomai flags=
 as deliverd from xeno-config and the application will run on Xenomai.
 >=20
 > So far so good. Compiling and linking works miraculous (see output bel=
ow).=20
 > But when I start my application I still get just Linux threads and no =
Xenomai shadow tasks are created. Can anybody give me a hint how I can co=
ntroll what kind of thread is created ?

Normally, any thread created with pthread_create has a shadow. Whether
they are started in primary mode depends on their scheduling policy.

 >=20
 > By the way : the posix example satch.c works fine (Xenomai tasks are c=
reated) and compiler and linker output are nearly the same as for my appl=
ication (see below). So, I can=B4t see, what I made wrong.
 >=20

Could you try reducing your problem to a program as simple as possible,
and send us the sources of this program ? How do you know that no shadow
threads are created ?

--=20


					    Gilles Chanteperdrix.

