MIME-Version: 1.0
In-Reply-To: <BAY128-W15F1BB0D7C2FA8AD5E98D8C7B80@domain.hid>
References: <BAY128-W15F1BB0D7C2FA8AD5E98D8C7B80@domain.hid>
Date: Wed, 28 Oct 2009 16:44:11 +0200
Message-ID: <b131c9f0910280744l11a60c12if84cadeeb659cbc6@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=00163600d539f514fa0476ffd365
Subject: Re: [Xenomai-help] Xenomai and CodeBlocks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Peter ." <pcs_007@domain.hid>
Cc: xenomai@xenomai.org

--00163600d539f514fa0476ffd365
Content-Type: text/plain; charset=ISO-8859-1

Hi Peter

------------------------------
> From: pcs_007@domain.hid
> To: xenomai@xenomai.org
> Subject: Xenomai and CodeBlocks
> Date: Wed, 28 Oct 2009 08:42:48 +1100
>
> Hello,
>
> I am trying to get Xenomai Code to compile and run correctly under
> CodeBlocks 8.02.
>
> I have followed the advice in this mailing list by another subscriber. This
> is what I have followed:
>
> To use the Xenomai realtime framework in  Code::Blocks IDE,
>
> 1. Add these commands to "Project build options", "Compiler settings",
> "Other options"
>
> `/usr/xenomai/bin/xeno-config --xeno-cflags`
> `/usr/xenomai/bin/xeno-config --xeno-ldflags`
>
>  [you can type the commands on the command line without the apostrophes to
> get an idea of the output]
>
> 2. Under "Project build options", "linker settings" add libraries as
> required
>
> eg native, rtdm ...
>
> [See /usr/xenomai/lib for available libraries]
>
> 3. Under "Project build options", "Search Directories", "Linker" add
>
> /usr/xenomai/lib
>
> The code compiles, but when it tries to run it comes up with the error:
>
> /home/computer/Desktop/projects/MyProject/bin/Debug/MyProject: error while loading shared libraries: libnative.so.1: cannot open shared object file: No such file or directory
>
> Has anyone used CodeBlocks to compile Xenomai applications correctly?
>
> Thanks.
>
>
>
The error that you're getting is not specific to codeblocks.

Try adding /usr/xenomai/lib to /etc/ld.so.conf
Create the /etc/ld.so.conf  file if it does not exist.

Then run "sudo ldconfig"

This updates the shared library cache

Hope this helps
Vicki

--00163600d539f514fa0476ffd365
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Peter<br><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;"><div><hr>From: <a href=3D"mailto:pcs_007@domain.hid.=
com" target=3D"_blank">pcs_007@domain.hid</a><br>
To: <a href=3D"mailto:xenomai@xenomai.org" target=3D"_blank">xenomai-help@=
gna.org</a><br>Subject: Xenomai and CodeBlocks<br>Date: Wed, 28 Oct 2009 08=
:42:48 +1100<br><br>






Hello,<br><br>I am trying to get Xenomai Code to compile and run correctly =
under CodeBlocks 8.02.<br><br>I have followed the advice in this mailing li=
st by another subscriber. This is what I have followed:<br><pre>To use the =
Xenomai realtime framework in  Code::Blocks IDE,<br>
<br>1. Add these commands to &quot;Project build options&quot;, &quot;Compi=
ler settings&quot;,<br>&quot;Other options&quot;<br><br>`/usr/xenomai/bin/x=
eno-config --xeno-cflags`<br>`/usr/xenomai/bin/xeno-config --xeno-ldflags`<=
br>
<br> [you can type the commands on the command line without the apostrophes=
 to<br>get an idea of the output]<br><br>2. Under &quot;Project build optio=
ns&quot;, &quot;linker settings&quot; add libraries as<br>required<br><br>
eg native, rtdm ...<br><br>[See /usr/xenomai/lib for available libraries]<b=
r><br>3. Under &quot;Project build options&quot;, &quot;Search Directories&=
quot;, &quot;Linker&quot; add<br><br>/usr/xenomai/lib<br><br>The code compi=
les, but when it tries to run it comes up with the error:<br>
<br>/home/computer/Desktop/projects/MyProject/bin/Debug/MyProject: error wh=
ile loading shared libraries: libnative.so.1: cannot open shared object fil=
e: No such file or directory<br><br>Has anyone used CodeBlocks to compile X=
enomai applications correctly?<br>
<br>Thanks.<br></pre><div class=3D"hm"><br></div></div></blockquote></div><=
br>The error that you&#39;re getting is not specific to codeblocks.<br><br>=
Try adding /usr/xenomai/lib to /etc/ld.so.conf <br>Create the /etc/ld.so.co=
nf=A0 file if it does not exist.<br>
<br>Then run &quot;sudo ldconfig&quot; <br><br>This updates the shared libr=
ary cache<br><br>Hope this helps<br>Vicki<br><br><br><br>

--00163600d539f514fa0476ffd365--

