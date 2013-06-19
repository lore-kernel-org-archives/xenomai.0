From: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Date: Wed, 19 Jun 2013 07:58:56 +0000
Message-ID: <49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
In-Reply-To: <b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks a lot for this complete and short answer.

- I didn't find any mention of PTHREAD_WARNSWS throughout the entire code v=
ia a grep command. However, I found a T_WARNSW mention in the Orocos files,=
 which according to sigdebug.c apparently does the same thing.
- This __wrap_send problem might be a key to solving this issue. I enclosed=
 the "ldd" and "nm" traces of the some_core library (you can find mentions =
of __wrap_send in the nm.txt file, as well as the core_dump.txt file which =
contains a backtrace of the core dump when the program crashes).
- I included the handler of sigdebug.c in my own file. I'm also enclosing w=
hat it returned in sigcpu.txt. I didn't find anything new or unexpected in =
it, but I have to admit that I don't know how to read 95% of the file.

Do you have any ideas why RTNet does not seem to be used? How to fix it?

Flavian

PS : please note that those text files where generated under a linux system=
 and may not show well under other OS's

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] =

Envoy=E9=A0: mardi 18 juin 2013 18:02
=C0=A0: HAUTBOIS Flavian
Cc=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai] CPU time limit exceeded


HAUTBOIS Flavian wrote:
> Hello,
>
> I'm having a 'CPU time limit exceeded' error. Of course I tried to set =

> ulimit to unlimted, without any success.
>
> According to the soem developpers, everything works fine on Xenomai =

> 2.5.6, but I have to use Xenomai 2.6.2. Do you have any idea what =

> could trigger this error and how to fix it?

Hi,

You should first make sure that you do not get the SIGXCPU signal because y=
ou enabled the PTHREAD_WARNSW bit (see pthread_set_mode_np documentation) a=
nd __wrap_send falls back to Linux "send" service. Which would mean, that y=
ou are not, in fact, using RTNet to send the network packet which causes th=
is signal to be sent. See examples/native/sigdebug.c for an example of SIGX=
CPU handler which prints the reason for receiving this signal.

Regards.

-- =

                    Gilles.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: core_dump.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130619/6ea23e7=
6/attachment.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ldd.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130619/6ea23e7=
6/attachment-0001.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: nm.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130619/6ea23e7=
6/attachment-0002.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sigcpu.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130619/6ea23e7=
6/attachment-0003.txt>
