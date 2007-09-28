In-Reply-To: <2ff1a98a0709270147r26a25b7bpb06b512bd997b947@domain.hid>
Message-ID: <OFB7848CD1.BB3D6248-ONC1257364.001FE5E6-C1257364.0020C1D2@domain.hid>
From: juergen.lanner@domain.hid
Date: Fri, 28 Sep 2007 07:58:09 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF9F7DF8C63768f9e8a93df938690918c4EBBF9F7DF8C6376"
Content-Disposition: inline
Subject: Re: [Xenomai-help] POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0__=4EBBF9F7DF8C63768f9e8a93df938690918c4EBBF9F7DF8C6376
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Hi Gilles!

Following your hints I saw that the adeos-ipipe-2.6.20-i386-1.8-08.patc=
h
did not fit to the 2.6.20.19 kernel due to recent changes there.
There was one reject which I didn't see first.
Using the prepare-kernel.sh as you suggested instead of patching it usi=
ng
"patch" manually would have highlighted the problem earlier since the
script checks the result of the patch procedure.
Applying some magic on the adeos-ipipe-2.6.20-i386-1.8-08.patch made it=
 run
smoothly again.
Xenomai now runs properly.

Many thanks for your excellent support and patience!

Juergen=

--0__=4EBBF9F7DF8C63768f9e8a93df938690918c4EBBF9F7DF8C6376
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial">Hi Gilles!</font><br>
<br>
<font face=3D"Arial">Following your hints I saw that the adeos-ipipe-2.=
6.20-i386-1.8-08.patch did not fit to the 2.6.20.19 kernel due to recen=
t changes there.</font><br>
<font face=3D"Arial">There was one reject which I didn't see first.</fo=
nt><br>
<font face=3D"Arial">Using the </font><font face=3D"Arial">prepare-kern=
el.sh as you suggested instead of patching it using &quot;patch&quot; m=
anually would have highlighted the problem earlier since the script che=
cks the result of the patch procedure.</font><br>
<font face=3D"Arial">Applying some magic on the adeos-ipipe-2.6.20-i386=
-1.8-08.patch made it run smoothly again.</font><br>
<font face=3D"Arial">Xenomai now runs properly.</font><br>
<br>
<font face=3D"Arial">Many thanks for your excellent support and patienc=
e!</font><br>
<br>
<font face=3D"Arial">Juergen</font><br>
</body></html>=

--0__=4EBBF9F7DF8C63768f9e8a93df938690918c4EBBF9F7DF8C6376--


