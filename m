From: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Date: Wed, 19 Jun 2013 12:50:18 +0000
Message-ID: <49E736B33FAAA645BCAB9FFEC26712E6FD16CB@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
	<fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
In-Reply-To: <fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
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

Hi Gilles,

I'm using a middleware that arms T_WARNSW by default, I cannot change that.=
 Plus, I would like to use only RTNet to send this packet, as I need real-t=
ime performances.
I may be mistaken, but I thought the message stating the reason was one of =
the first lines of the files I joined.

The socket being used by the program is 896 (which equals 1024-128), so the=
 issue should be somewhere else if I understood you correctly?

RTNet should be correctly configured and started but I'm not 100% positive.=
 Here are the outputs of rtconfig and lsmod. (I have two Ethernet cards in =
my computer, one uses the e1000e module and the other one the e100 module. =
The latter one is the one I use with rtnet)

You mentioned other reasons for failure that I can't really investigate wit=
hout further precisions, such as wrong kernel-space options, any more detai=
ls?

Thank you

Flavian

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] =

Envoy=E9=A0: mercredi 19 juin 2013 14:01
=C0=A0: HAUTBOIS Flavian
Cc=A0: Gilles Chanteperdrix; xenomai@xenomai.org
Objet=A0: RE: [Xenomai] CPU time limit exceeded


HAUTBOIS Flavian wrote:
> Thanks a lot for this complete and short answer.
>
> - I didn't find any mention of PTHREAD_WARNSWS throughout the entire =

> code via a grep command. However, I found a T_WARNSW mention in the =

> Orocos files, which according to sigdebug.c apparently does the same thin=
g.

Hi Flavian,

Yes, that is the same thing.

> - This __wrap_send problem might be a key to solving this issue. I =

> enclosed the "ldd" and "nm" traces of the some_core library (you can =

> find mentions of __wrap_send in the nm.txt file, as well as the =

> core_dump.txt file which contains a backtrace of the core dump when =

> the program crashes).

send is replaced with __wrap_send when passing --wrap send to the linker, w=
hich happens when you are using the compiler flags given by:
xeno-config --skin posix --ldflags
__wrap_send is implemented in libpthread_rt.so, part of xenomai user-space =
support and emits a system call relying on xenomai kernel-space support, us=
ing rtnet or other rtdm based drivers, depending on the socket family the s=
ocket you pass to __wrap_send is using. If that fails, because, the correct=
 options were not enabled in xenomai kernel-space, because the RTnet driver=
 is not started, or for other reasons, __wrap_send falls back to the glibc =
send service, which will cause a SIGXCPU to be sent if you enabled T_WARNSW.

So, either your application is using glibc to send the packet because this =
is what you want, in which case you should not arm the T_WARNSW bit for thi=
s thread, or you would like to use RTnet to send the particular packet whic=
h causes the SIGXCPU signal to be sent, in which case something is not conf=
igured correctly and you should find what.

> - I included the handler of sigdebug.c in my own file. I'm also =

> enclosing what it returned in sigcpu.txt. I didn't find anything new =

> or unexpected in it, but I have to admit that I don't know how to read 95=
% of the file.

The part of the sigdebug.c I was interested in was not the part which print=
s the backtrace, since you already had the backtrace, but the part that pri=
nts a message depending on the reason.

>
> Do you have any ideas why RTNet does not seem to be used? How to fix it?

I do not really know what your application does, this may be normal or not.
A first step to see if the socket you pass to __wrap_send is an RTnet socke=
t is to check its value. RTDM normally uses socket numbers between 1024 -
128 and 1023 inclusive.

Regards.


-- =

                    Gilles.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: rtifconfig.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130619/98bd65d=
f/attachment.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: lsmod.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130619/98bd65d=
f/attachment-0001.txt>
