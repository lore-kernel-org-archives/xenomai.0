From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17617.57681.985907.937876@domain.hid>
Date: Thu, 3 Aug 2006 13:43:13 +0200
Subject: Re: [Xenomai-help] Xenomai POSIX-libraries
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A46D9C5@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A46D9C5@domain.hid>
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
 > Can anybody tell me how the POSIX-Libraries are build. I had a look on=
 various scripts and makefiles but I don=B4t understand the mechanism.

Everything is correct. pthread_attr_setname_np does not exist in
user-space, because we did not want to wrap the pthread_attr* calls, and
there is no room in pthread_attr_t for an additional string pointer.

 > I am asking, as I have the feeling, my POSIX-Library is not correct.
 > Although the xeno_posix.o file in the Linux/kernel/xenomai/skins/posix=
 directory includes all functions from the (xenomai)thread_attr.c file (e=
.g.: pthread_attr_setname_np), the posix-libraries in the Xenomai/install=
/lib directory (created by make install) do not include all functions (ex=
plicitly pthread_attr_setname_np is not included) where did I lose them ?=
 Are the libraries in my install directory the correct ones, where do the=
y come from ???
 >=20
 > Sorry, but the building process is too complex for a normal mortal lik=
e me. Perhaps somebody can give me a helping hand.

The kernel-space module is built from the contents of ksrc/skins/posix,
whereas the user-space librarry is built from the contents of
src/skins/posix. The mapping between user-space and kernel-space calls
is done in ksrc/skins/posix/syscall.c.

--=20


					    Gilles Chanteperdrix.

