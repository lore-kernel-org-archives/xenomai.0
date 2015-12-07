Date: Mon, 7 Dec 2015 21:30:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151207203037.GB20044@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70DADE@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A70DADE@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Linking static libraries using wrap-link.sh script
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 07, 2015 at 11:06:29AM +0000, Umair Ali wrote:
> Hello there,
>=20
> I have read that if you want to create a POSIX application by
> compiling it with Xenomai POSIX skin then the script
> "wrap-link.sh" is used. Do i have understand it correctly  or it
> means that if you want to use static library (compiled for POSIX
> skin) with Xenomai POSIX application then in order to link that
> static library with real time application "wrap-link.sh" script
> should be used. I am little confused. Please make it clear.

I will quote the documentation:

"Using static libraries

Due to the use of the =96wrap flag, it is necessary to do the link
edition of an application with static versions of the Xenomai POSIX
skin library two stages. To help in this matter, versions of Xenomai
after 2.5.0 include a script called =93wrap-link.sh=94.

For more information try wrap-link.sh =96help."

This is true for Xenomai 2.6. I guess this is still true for Xenomai
3.x. Anyway, using wrap-link.sh for dynamic libraries should not hurt.

> Moreover I want to use the static libpcap which is compiled for
> the POSIX skin to make an application on Xenomai POSIX skin to
> read pcap files. If i use the the static libpcap file to read to
> pcap files along with mlockall,, can reading of pcap file will
> switch to secondary mode with this library. The slackspot output
> file is attached for reference.

Normally, this case should be handled by wrap-link.sh provided you
put the libraries in the right order on the command line. Anyway,
the slackspot file shows that your program uses "read" to read from
the program, this causes switch to secondary mode, Xenomai can not
provide a deterministic replacement to reading from file. If you
want to avoid that, provided that you use mlockall, you can use
mmap. With mlockall, mmap will load the entire file in memory, and
reading will not need any Linux syscall. This too is explained in
the documentation:

"Reading from file

Of course, reading from files also causes switches to secondary
mode. However, a simple solution is available: the mmap service.
Thanks to the use of mlockall, mmaping a file is equivalent to
loading it entirely in memory. The call to mmap itself causes a
switch to secondary mode, but in most cases, it is possible to call
this service in a non critical part of the code. Note however, that
doing this may consume a lot of memory if the file is large."

You can probably also have a thread reading from the file and
passing packets to a thread running in primary mode, but you will
loose determinism.

>=20
> I am very grateful for the xenomai team and especially Gilles for
> helping me and answering my stupid and redundant questions.

You are welcome. I am not sure I sent you the link, but the guide
for porting POSIX applications to Xenomai is here:
https://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-ker=
nel/

--=20
					    Gilles.
https://click-hack.org

