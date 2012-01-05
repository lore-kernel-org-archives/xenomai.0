MIME-Version: 1.0
Date: Thu, 5 Jan 2012 20:16:48 +0100
Message-ID: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
From: Santiago Focke <focke.85@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8f6472e51ca09704b5ccc607
Subject: [Xenomai-help] Problems with installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--e89a8f6472e51ca09704b5ccc607
Content-Type: text/plain; charset=ISO-8859-1

Hi all

I'm quite new with Linux and Xenomai. I'm using Ubunto kernel
2.6.32-24-generic. I tied to install Xenomai-2.6 following the
README.INSTALL document. First of all I cloned the GIT repository in

/usr/src/xenomai-2.6

After that, I tried to run the prepare-kernel.sh script as follows:

/usr/src/xenomai-2.6/scripts/prepare-kernel.sh
--linux=/usr/src/linux-headers-2.6.32-24-generic/

I select the default target architecture with no problems

Target architecture [default i686]:

But when I select the default I-pipe patch i get the following:

I-pipe patch [default /dev/null]:
prepare-kernel.sh: cannot read I-pipe patch from /dev/null

What should I do?

Thanks in advance,


-- 
Santiago

--e89a8f6472e51ca09704b5ccc607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all<div><br></div><div>I&#39;m quite new with Linux and Xenomai. I&#39;m=
 using Ubunto kernel 2.6.32-24-generic. I tied to install Xenomai-2.6 follo=
wing the README.INSTALL document. First of all I cloned the GIT repository =
in=A0</div>
<div><br></div><div style=3D"margin-left:40px;color:rgb(51,51,255);font-fam=
ily:courier new,monospace">/usr/src/xenomai-2.6</div>
<div><br></div><div>After that, I tried to run the prepare-kernel.sh script=
 as follows:</div><div><br></div><div style=3D"margin-left:40px"><span styl=
e=3D"font-family:courier new,monospace;color:rgb(51,51,255)">/usr/src/xenom=
ai-2.6/scripts/prepare-kernel.sh --linux=3D/usr/src/linux-headers-2.6.32-24=
-generic/</span><br>
</div><div><br>I select the default target architecture with no problems<br=
><br><div style=3D"margin-left:40px"><span style=3D"font-family:courier new=
,monospace;color:rgb(51,51,255)">Target architecture [default i686]:</span>=
<br>
<br></div>But when I select the default I-pipe patch i get the following:<b=
r><br><div style=3D"margin-left:40px"><span style=3D"font-family:courier ne=
w,monospace;color:rgb(51,51,255)">I-pipe patch [default /dev/null]:</span><=
br>
<span style=3D"color:rgb(204,0,0)">prepare-kernel.sh: cannot read I-pipe pa=
tch from /dev/null</span><br><br></div>What should I do?<br><br>Thanks in a=
dvance,<br></div><div><br clear=3D"all"><div><br></div>-- <br>Santiago<br>
</div>

--e89a8f6472e51ca09704b5ccc607--

