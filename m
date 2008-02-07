Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 7 Feb 2008 15:16:53 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB02AF4DB5@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3769E1@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3769D5@domain.hid><2ff1a98a0802070043n7c78e397i9345f3de1229f6bf@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769DF@slcmail.slc.mew.int>
	<DD39B5C3F4963040ADC9768BE7E430CB02AF4D89@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769E1@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] SIGTRAP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Okay,

We had the same problem, different target (ppc). You have to be careful
to give the remote gdb the correct paths to the target binaries
including the shared libraries. We are using ssh and have a script to
start the gdbserver on the target with a command line that looks
basically like this:

ssh -f root@domain.hid "cd $workingdir;killall gdbserver;export
LD_LIBRARY_PATH=3D'/lib:/usr/lib:/usr/xenomai/lib:/opt/marel/runtime
/ppc/lib' && echo $LD_LIBRARY_PATH && gdb
server $hostip:45678 $filename"

Then the remote gdb is started by a feature enhanced kdbg with another
script where the important pieces are:

if [ "$cpu" =3D "ppc" ]; then
        echo set solib-absolute-prefix /opt/rootfs > tmp.gdb
        echo set solib-search-path
/opt/marel/runtime/ppc/lib:/opt/rootfs/usr/xenomai/lib >> tmp.gdb
        echo break main >> tmp.gdb
        echo Starting session for ppc
        kdbg -r $targetip:45678 -d 'powerpc-603e-linux-gnu-gdb
--fullname --nx --command=3Dtmp.gdb' $workingdir/$filename

        # Cleanup file and kill gdbserver
        rm tmp.gdb
        ssh -f root@domain.hid "killall gdbserver
fi

/opt/rootfs is our target root filesystem. The solib-xxxx are important,
otherwise gdb will take the standard host libraries.


Best regards,

Daniel.


Steven Seeger wrote:
> Kernel 2.6.23.12 remote debugger (x86). Gdb 6.7.1. glibc is 2.6.1.
>=20
> Steven
>=20
>> -----Original Message-----
>> From: Daniel Schnell [mailto:daniel.schnell@domain.hid]
>> Sent: Thursday, February 07, 2008 7:41 AM
>> To: Steven Seeger; Gilles Chanteperdrix
>> Cc: xenomai@xenomai.org
>> Subject: RE: [Xenomai-help] SIGTRAP
>>=20
>> How do you debug ? Are you using remote debugger or native debugger
>> on target ? Which debugger version and glibc version are you using ?
>> And which kernel ?=20
>>=20
>> Ciao,
>>=20
>> Daniel.



--=20
                                 |
                                 | www.marel.com
Tel: +354 563 8000 Fax: +354 563 8001
Iceland

