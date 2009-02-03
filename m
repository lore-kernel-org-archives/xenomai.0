MIME-Version: 1.0
In-Reply-To: <BAY101-W54D5E94646F7B999F81AF8EAC50@domain.hid>
References: <BAY101-W54D5E94646F7B999F81AF8EAC50@domain.hid>
Date: Tue, 3 Feb 2009 11:57:50 +0200
Message-ID: <b131c9f0902030157k70eb9635v19e0b5ff1b9ead8c@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5a81c436c6a046200b4fb
Subject: Re: [Xenomai-help] Compiler Options
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Davies <steve_davies61@domain.hid>
Cc: xenomai@xenomai.org

--001636c5a81c436c6a046200b4fb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Steve

On Mon, Feb 2, 2009 at 6:17 PM, Stephen Davies
<steve_davies61@domain.hid>wrote:

>  Hi all,
>
> I start by apologising for asking what I imagine is a very basic question
> but it's been driving me nuts all day!  I am currently trying to build and
> compile one of the sample programs - msg_queue.c.  I'm using the
> Code::Blocks IDE with GCC underneath it to compile the program.  I have
> linked in the include directory /usr/xenomai/include but when I compile and
> link my code I get a load of 'undefined reference' errors relating to all of
> the xenomai functions.  On my old RTAI setup I have never had to
> link explicitly to any libs only include header files - what am I doing
> wrong with xenomai?
>
> My setup is 2.6.27 kernel, Xenomai latest stable, Ubuntu 8.10
>
> Apologies again for what I imagine is a very simple question, but it's
> driving me nuts!
>
> Thanks for your help,
>
> Steve
>

I haven't compiled the msg_queue.c example, but i do use the native skin
with rtdm under Code::Blocks with
Ubuntu 8.04.

To use the Xenomai realtime framework in  Code::Blocks IDE,

1. Add these commands to "Project build options", "Compiler settings",
"Other options"

`/usr/xenomai/bin/xeno-config --xeno-cflags`
`/usr/xenomai/bin/xeno-config --xeno-ldflags`

 [you can type the commands on the command line without the apostrophes to
get an idea of the output]

2. Under "Project build options", "linker settings" add libraries as
required

eg native, rtdm ...

[See /usr/xenomai/lib for available libraries]

3. Under "Project build options", "Search Directories", "Linker" add

/usr/xenomai/lib


Hope this helps to get you going

Keep well
Vicki


>
> ------------------------------
> Share your photos with Windows Live Photos - Free Try it Now!<http://www.microsoft.com/uk/windows/windowslive/products/messenger.aspx>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

--001636c5a81c436c6a046200b4fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Steve<br><br><div class=3D"gmail_quote">On Mon, Feb 2, 2009 at 6:17 PM, =
Stephen Davies <span dir=3D"ltr">&lt;<a href=3D"mailto:steve_davies61@domain.hid=
il.com">steve_davies61@domain.hid</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">




<div>
Hi all,<br>
&nbsp;<br>
I start by apologising for asking what I imagine is a very basic question b=
ut it&#39;s been driving me nuts all day!&nbsp; I am currently trying to bu=
ild and compile one of the sample programs - msg_queue.c.&nbsp; I&#39;m usi=
ng the Code::Blocks IDE with GCC underneath it to compile the program.&nbsp=
; I have linked in the include directory /usr/xenomai/include but when I co=
mpile and link my code I get a load of &#39;undefined reference&#39; errors=
 relating to all of the xenomai functions.&nbsp; On my old RTAI setup I hav=
e never had to link&nbsp;explicitly to any libs only include header files -=
 what am I doing wrong with xenomai?&nbsp;<br>

&nbsp;<br>
My setup is 2.6.27 kernel, Xenomai latest stable, Ubuntu 8.10<br>
&nbsp;<br>
Apologies again for what I imagine is a very simple question, but it&#39;s =
driving&nbsp;me nuts!<br>
&nbsp;<br>
Thanks for your help,<br>
&nbsp;<br>
Steve</div></blockquote><div>&nbsp;<br>I haven&#39;t compiled the msg_queue=
.c example, but i do use the native skin with rtdm under Code::Blocks with =
<br>Ubuntu 8.04. <br><br></div><div>To use the Xenomai realtime framework i=
n&nbsp; Code::Blocks IDE, <br>
<br>1. Add these commands to &quot;Project build options&quot;, &quot;Compi=
ler settings&quot;, &quot;Other options&quot;<br><br>`/usr/xenomai/bin/xeno=
-config --xeno-cflags`<br>`/usr/xenomai/bin/xeno-config --xeno-ldflags`<br>
<br>&nbsp;[you can type the commands on the command line without the apostr=
ophes to get an idea of the output]<br><br>2. Under &quot;Project build opt=
ions&quot;, &quot;linker settings&quot; add libraries as required<br><br>eg=
 native, rtdm ...<br>
<br>[See /usr/xenomai/lib for available libraries]<br><br>3. Under &quot;Pr=
oject build options&quot;, &quot;Search Directories&quot;, &quot;Linker&quo=
t; add<br><br>/usr/xenomai/lib<br><br><br> Hope this helps to get you going=
<br>
<br>Keep well<br>Vicki<br><br></div><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;"><div><br><br><hr>Share your photos with Windows Live Pho=
tos - Free <a href=3D"http://www.microsoft.com/uk/windows/windowslive/produ=
cts/messenger.aspx" target=3D"_blank">Try it Now!</a></div>

<br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br>

--001636c5a81c436c6a046200b4fb--

