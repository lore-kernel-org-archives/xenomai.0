References: <1358804184.96123.YahooMailNeo@web172102.mail.ir2.yahoo.com>
	<50FDCD39.2000603@xenomai.org>
Message-ID: <1358813358.92635.YahooMailNeo@web172106.mail.ir2.yahoo.com>
Date: Tue, 22 Jan 2013 00:09:18 +0000 (GMT)
From: bifferos <bifferos@yahoo.co.uk>
In-Reply-To: <50FDCD39.2000603@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Building xenomai with latest buildroot snapshot.
Reply-To: bifferos <bifferos@yahoo.co.uk>
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

=0A=0A----- Original Message -----=0A=0A> From: Gilles Chanteperdrix <gille=
s.chanteperdrix@xenomai.org>=0A> =0A> On 01/21/2013 10:36 PM, bifferos wrot=
e:=0A>> =0A>>  I was able to compile Xenomai under buildroot 2011.11 withou=
t too much =0A> trouble, however I'm now trying =0A>> =0A>>  to do the same=
 with the latest buildroot snapshot.=A0 Unfortunately it seems =0A> buildro=
ot no longer has an=0A>>  easy option to select a kernel compatible with Xe=
nomai.=A0 I looked in =0A> xenomai-2.6.1/ksrc/arch/x86/patches=0A>> =0A>>  =
and there are three of them=0A>> =0A>>  adeos-ipipe-2.6.37.6-x86-2.9-02.pat=
ch=0A>>  adeos-ipipe-2.6.38.8-x86-2.11-01.patch=0A>>  ipipe-core-3.2.21-x86=
-1.patch=0A>> =0A>> =0A>>  Can someone please explain what this ipipe-core =
thing is?=0A> =0A> =0A> I am desperately looking for a mail from Philippe w=
here he explained it,=0A> but can not find it back. Maybe he can give some =
explanations.=0A> =0A>>  Are these interchangeable (they are similar=0A> =
=0A>>  sizes)? =0A> =0A> Yes.=0A=0AOK, thanks, I will give 3.2.21 a go then=
.=0A=0A> =0A>>  Do I have to stick to 2.6.37.6 kernel to stand any chance o=
f getting this =0A> working?=0A> =0A> =0A> The newer versions should work, =
though I would recommend to wait for the=0A> next release which should happ=
en in the next few days.=0A> =0A> Also note that I guess you are using Xeno=
mai on the bifferboard, since I=0A> also guess the processor on this board =
does not have a tsc, it will be=0A> emulated using the PIT, which is slow, =
so, unless you can provide=0A> another hardware timer with a lower latency,=
 which will work starting=0A> with the I-pipe core for Linux 3.4, you shoul=
d turn off=0A> CONFIG_XENO_OPT_STATS to improve latencies.=0A=0AThanks for =
the tip, actually I am trying to simply compile an ISO image to run under V=
irtualBox=0Aat the moment, so latencies are way down on my list.=A0 My note=
s are here:=0Ahttps://sites.google.com/site/bifferboard/Home/boards-with-1m=
b-flash/buildroot/xenomai=0A=0AIt all seems like a bit of a hack, so my nex=
t task is to try to create a buildroot package to =0Aallow choosing the tri=
vial-periodic demo and installing it from the Buildroot config menu.=0A=0Ak=
ind regards,=0ABiff.

