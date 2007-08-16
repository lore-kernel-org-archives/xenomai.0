Message-ID: <4760.194.114.62.68.1187274071.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0708160701w17dcf324jb9cb31843d69ca60@domain.hid>
References: <61839.194.114.62.68.1187258167.squirrel@domain.hid>
	<2ff1a98a0708160300r79a717ebt7541c1d6e3da6687@domain.hid>
	<11886.194.114.62.68.1187258877.squirrel@domain.hid>
	<18116.9932.592597.831501@domain.hid>
	<56493.194.114.62.68.1187265227.squirrel@domain.hid>
	<2ff1a98a0708160639k555fbb48p98a13892e30e5b02@domain.hid>
	<21067.194.114.62.68.1187272557.squirrel@domain.hid>
	<2ff1a98a0708160701w17dcf324jb9cb31843d69ca60@domain.hid>
Date: Thu, 16 Aug 2007 16:21:11 +0200 (CEST)
From: "Nadym Salem" <Kaiman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20070816162111_78849"
Subject: Re: [Xenomai-help] latency problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_20070816162111_78849
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thu, August 16, 2007 16:01, Gilles Chanteperdrix wrote:
>> >> >  > >> trying to use RTnet and having massive synchronisation
>> problems,
>> >> a
>> >> >  > >> problem
>> >> >  > >> with xenomai latencies came up.
>> >> >  > >> Our xenomai latency test gives weird values. Attached a
>> >> xeno-test
>> >> > log.
>> >> >  > >> Does anyone have an idea ?
>> >> >  > > Yes, read the FAQ and try the proposed workarounds.
>> >> >  > Sorry not to mention it. Of course we used all the settings in
>> the
>> >> FAQ
>> >> > and
>> >> > What does your kernel logs say about SMI workaround, is it workin=
g
>> ?
>> >> It does not say anything about SMI, reading the Torubleshoothing
>> file,
>> >> it
>> >> sound like there should be a warning if it is not working.
>> > But you should get a message "SMI enabled" in the kernel logs. Do yo=
u
>> get
>> > it ?
>> Nope...there isn't an entry with SMI at all in all /var/log/*
> Aha, this probably means that your chipset is not supporte, could you
> run lspci and send us the output ?

it is attached.

>> >> >  > Or am I just too blind to find other workarounds there ?
>> >> > There is also the X-server workaround, and the Legacy USB
>> workaround.
>> >> No HW Acceleration on.
>> >> Legacy USB Option in Bios is missing (like a lot more... :-/ )
>> >> > What version of Xenomai are you using ?
>> >> Xenomai 2.3.2 with Linux Kernel 2.6.20
>> > In case there is a bug in the newly introduced direct access to tsc
>> > from posix clock functions, could you re-compile with access to hw t=
sc
>> > disabled and re-run cyclictest ?
>> I could, just being not able to find the option ;)
> It is the option --disable-x86-tsc of the configure script.

That's why I didn't find it :-) Did it, but it did not change anything.

Greets, Nadym
------=_20070816162111_78849
Content-Type: application/octet-stream; name="lspci.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lspci.log"

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gODJROTYzL1E5NjUgTWVtb3J5
IENvbnRyb2xsZXIgSHViIChyZXYgMDIpCjAwOjAyLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxl
cjogSW50ZWwgQ29ycG9yYXRpb24gODJROTYzL1E5NjUgSW50ZWdyYXRlZCBHcmFwaGljcyBDb250
cm9sbGVyIChyZXYgMDIpCjAwOjFhLjAgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9u
IDgyODAxSCAoSUNIOCBGYW1pbHkpIFVTQiBVSENJICM0IChyZXYgMDIpCjAwOjFhLjEgVVNCIENv
bnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSCAoSUNIOCBGYW1pbHkpIFVTQiBVSENJ
ICM1IChyZXYgMDIpCjAwOjFhLjcgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgy
ODAxSCAoSUNIOCBGYW1pbHkpIFVTQjIgRUhDSSAjMiAocmV2IDAyKQowMDoxYy4wIFBDSSBicmlk
Z2U6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSCAoSUNIOCBGYW1pbHkpIFBDSSBFeHByZXNzIFBv
cnQgMSAocmV2IDAyKQowMDoxYy4xIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIDgyODAx
SCAoSUNIOCBGYW1pbHkpIFBDSSBFeHByZXNzIFBvcnQgMiAocmV2IDAyKQowMDoxZC4wIFVTQiBD
b250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUggKElDSDggRmFtaWx5KSBVU0IgVUhD
SSAjMSAocmV2IDAyKQowMDoxZC4xIFVTQiBDb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4
MjgwMUggKElDSDggRmFtaWx5KSBVU0IgVUhDSSAjMiAocmV2IDAyKQowMDoxZC4yIFVTQiBDb250
cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUggKElDSDggRmFtaWx5KSBVU0IgVUhDSSAj
MyAocmV2IDAyKQowMDoxZC43IFVTQiBDb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiA4Mjgw
MUggKElDSDggRmFtaWx5KSBVU0IyIEVIQ0kgIzEgKHJldiAwMikKMDA6MWUuMCBQQ0kgYnJpZGdl
OiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMSBQQ0kgQnJpZGdlIChyZXYgZjIpCjAwOjFmLjAgSVNB
IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDFIQi9IUiAoSUNIOC9SKSBMUEMgSW50ZXJm
YWNlIENvbnRyb2xsZXIgKHJldiAwMikKMDA6MWYuMiBJREUgaW50ZXJmYWNlOiBJbnRlbCBDb3Jw
b3JhdGlvbiA4MjgwMUggKElDSDggRmFtaWx5KSA0IHBvcnQgU0FUQSBJREUgQ29udHJvbGxlciAo
cmV2IDAyKQowMDoxZi41IElERSBpbnRlcmZhY2U6IEludGVsIENvcnBvcmF0aW9uIDgyODAxSCAo
SUNIOCBGYW1pbHkpIDIgcG9ydCBTQVRBIElERSBDb250cm9sbGVyIChyZXYgMDIpCjA3OjA5LjAg
RXRoZXJuZXQgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gODI1NDFQSSBHaWdhYml0IEV0
aGVybmV0IENvbnRyb2xsZXIgKHJldiAwNSkKM2Y6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyOiBC
cm9hZGNvbSBDb3Jwb3JhdGlvbiBOZXRYdHJlbWUgQkNNNTc1NSBHaWdhYml0IEV0aGVybmV0IFBD
SSBFeHByZXNzIChyZXYgMDIpCg==
------=_20070816162111_78849--



