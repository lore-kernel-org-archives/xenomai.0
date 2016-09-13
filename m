Date: Tue, 13 Sep 2016 15:11:07 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160913151107.0b15e1e8@md1em3qc>
In-Reply-To: <1271995210.507800.1473769593022@mail.yahoo.com>
References: <1271995210.507800.1473769593022.ref@mail.yahoo.com>
 <1271995210.507800.1473769593022@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] multiarch on ipipe kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Do you have CONFIG_IA32_EMULATION set in your ipipe kernel?

Henning

Am Tue, 13 Sep 2016 12:26:33 +0000
schrieb Frederik Bayart <frederik_bayart@yahoo.co.uk>:

> Should it be possible to run an 32 bit non-rt binary on a 64 bit
> ipipe kernel ? I'm using debian jessie amd64 and xenomai 2.6.4 on
> kernel 3.18.20
>=20
> I have added i386 as foreing architecture and installed the i386
> toolchain $ dpkg --print-architectureamd64s$ dpkg
> --print-foreign-architecturesi386 I have a small hello world binary
>=20
> #include <stdio.h>
> int main(int argc, char* argv[]){=C2=A0 printf("hello world\n");=C2=A0 re=
turn
> 0;} I compile with=C2=A0
> gcc -m32 -o hello hello.c
> This binary runs on the normal (non-ipipe) kernel
> linux-image-3.16.0-4-amd64.But if I'm booting the ipipe kernel on the
> same system, I get the error : -bash: ./hello: cannot execute binary
> file: Exec format error So the problem seems to be related to the
> kernel. But I didn't find whether a kernel option could be the cause.
> The kernel was prepared with=C2=A0I only found that you can't run 32 bit
> xenomai libraries on a 64 bit kernel, but this binary is not using
> these libraries. Kind regards, Frederik
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


