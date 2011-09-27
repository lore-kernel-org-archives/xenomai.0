MIME-Version: 1.0
Date: Tue, 27 Sep 2011 15:55:10 -0300
Message-ID: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5215e5d9fbc3904adf0d025
Subject: [Xenomai-help] Command code working with comedi not working with
	analogy
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

--bcaec5215e5d9fbc3904adf0d025
Content-Type: text/plain; charset=UTF-8

Hi all,

This is my first post to the list. I have been playing around with
RTAI+Comedi for a while and wanted to give Xenomai+Analogy a chance. I am
running a linux 2.6.32.20 kernel on an AMD Phenom(tm) II X4 965, with
Xenomai 2.5.5.2. Xenomai appears to be running fine, analogy recognizes my
NI 6143 and NI 6713 cards, and "analogy-config" sets things properly up.

Now I cannot succeed at running any of the "command" functions. The example
programs "insn_read" and "insn_write" work fine, but "cmd_read" and
"cmd_write" don't. They fail at "a4l_snd_command".

I ported an application that is already working with comedi to analogy. My
question is now whether the same values for the command structures that are
working on Comedi should work directly with Analogy, because the
corresponding "a4l_snd_command" is failing with those values, returning a
value of -22.

Thank you very much for your help,
Fernando

--bcaec5215e5d9fbc3904adf0d025
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>This is my first post to the list. I have been playing aroun=
d with RTAI+Comedi for a while and wanted to give Xenomai+Analogy a chance.=
 I am running a linux 2.6.32.20 kernel on an AMD Phenom(tm) II X4 965, with=
 Xenomai 2.5.5.2. Xenomai appears to be running fine, analogy recognizes my=
 NI 6143 and NI 6713 cards, and &quot;analogy-config&quot; sets things prop=
erly up.<br>
<br>Now I cannot succeed at running any of the &quot;command&quot; function=
s. The example programs &quot;insn_read&quot; and &quot;insn_write&quot; wo=
rk fine, but &quot;cmd_read&quot; and &quot;cmd_write&quot; don&#39;t. They=
 fail at &quot;a4l_snd_command&quot;.<br>
<br>I ported an application that is already working with comedi to analogy.=
 My question is now whether the same values for the command structures that=
 are working on Comedi should work directly with Analogy, because the corre=
sponding &quot;a4l_snd_command&quot; is failing with those values, returnin=
g a value of -22.<br>
<br>Thank you very much for your help,<br>Fernando<br>

--bcaec5215e5d9fbc3904adf0d025--

