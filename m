From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4A006AFD.1030409@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
	<49FDFCC7.6000009@domain.hid>
	<20090504072304.A7E2483420E8@domain.hid>
	<49FF08C4.40908@domain.hid>
	<20090504180134.D9D5283420E8@domain.hid>
	<4A006AFD.1030409@domain.hid>
Date: Tue, 05 May 2009 21:03:27 +0200
Message-Id: <20090505190327.3FE4783420E8@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Thomas Lockhart,

In message <4A006AFD.1030409@domain.hid> you wrote:
>
> Hmm. My code does round the length to a multiple of the page size too.=20
> I'm pretty sure I would not have done this if it was not required but m=
y=20
> svn notes are not explicit on this. The man page could be considered=20
> ambiguous: "EINVAL We  don't  like  start,  length, or offset (e.g.,=20
> they are too large, or not aligned on a page boundary)." but only with =
a=20
> liberal reading of the sentence.

If you read the man page carefully, then the meaning is clear: either
length is too large, and/or start and/or offset are too large or not
page aligned.

Please keep in mind that lots of code use mmap() to perform file I/O,
and most of the files in your file system have NOT a size that happens
to be a multiple of pages.

Here is a small example:

------------------------- cut here ------------------------------
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

char	*cmdname;

int main(int argc, char *argv[])
{
	int fd;
	volatile caddr_t addr;
	char c;
	struct stat sbuf;

	cmdname =3D*argv++;

	if (argc !=3D 2) {
		fprintf (stderr, "usage: %s file\n", cmdname);
		return 1;
	}

	if ((fd =3D open(*argv, O_RDWR)) < 0) {
		fprintf (stderr, "%s: can't open %s\n", cmdname, *argv);
		return 1;
	}

	/*
	 * Get the file size and try to map the whole file.
	 */
	if (fstat(fd, &sbuf) < 0) {
		perror ("stat");
		return 1;
	}

	printf ("Mapping %ld bytes\n", sbuf.st_size);

	addr =3D mmap(0, sbuf.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0=
);

	if (addr =3D=3D (caddr_t)-1) {		/* mmap failed */
		perror ("mmap");
		return 1;
	}

	c =3D *addr;

	printf ("C =3D '%c' =3D 0x%02x\n", c, c);

	for ( ; ; ) {
		char new =3D *addr;

		if (c !=3D new) {
			printf ("'%c' =3D 0x%02x  -->  '%c' =3D 0x%02x\n",
				c, c, new, new);
			c =3D new;
		}
		printf ("----------------------------------------\n");
		sleep (1);
	}

	/*
	 * Undo the mapping.
	 */
	munmap(addr, sbuf.st_size);
	return 0;
}
------------------------- cut here ------------------------------

Compile and test as follows:

-> gcc -Wall -pedantic -O -o mmap mmap.c
-> date >foo
-> ls -l foo
-rw-r--r-- 1 wd users 30 May  5 20:58 foo
-> ./mmap foo
Mapping 30 bytes
C =3D 'T' =3D 0x54
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
'T' =3D 0x54  -->  '3' =3D 0x33
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
'3' =3D 0x33  -->  'r' =3D 0x72
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
^C

While the program was running, I ran these commands from another
window:

-> echo 3 >/tmp/foo
-> echo r >/tmp/foo


The mapped lenght here is 30 bytes, which is obviously not a multiple
of the page size.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
When properly administered, vacations do not  diminish  productivity:
for every week you're away and get nothing done, there's another when
your boss is away and you get twice as much done.  -- Daniel B. Luten

