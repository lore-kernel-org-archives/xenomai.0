MIME-Version: 1.0
Date: Wed, 25 Apr 2012 12:28:05 +0200
Message-ID: <CALH4WdZ3zVeXeapCjUc_usPb4AreGjecPXaLjL_SWZzJ_mo0eQ@mail.gmail.com>
From: Frederik Bayart <frederik.bayart@domain.hid>
Content-Type: multipart/alternative; boundary=047d7b15ab85a11b8604be7e5362
Subject: [Xenomai-help] Xenomai: binding failed: Operation not permitted.
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

--047d7b15ab85a11b8604be7e5362
Content-Type: text/plain; charset=ISO-8859-1

Hallo,

We are switching from linux 2.6.30.8 with xenomai 2.4.10  to linux 2.6.38.8
with xenomai 2.6.0 (stable release) on debian lenny.

In our daemon (with real pid root), we are setting effective pid and gid to
1000 and are calling popen to execute a shell command.
The popen succeeds, but when I try to read the output with fgets, I get the
error :

Xenomai: binding failed: Operation not permitted.

I verified that the effective user for both commands is the same.

This was working on xenomai 2.4.10
I added the user with pid 1000 already to the xenomai group but this
doesn't work.

Does anyone know what the problem could be ?


Frederik

--047d7b15ab85a11b8604be7e5362
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hallo,<br><br>We are switching from linux 2.6.30.8 with xenomai 2.4.10=A0 t=
o linux 2.6.38.8 with xenomai 2.6.0 (stable release) on debian lenny.<br><b=
r>In our daemon (with real pid root), we are setting effective pid and gid =
to 1000 and are calling popen to execute a shell command.<br>
The popen succeeds, but when I try to read the output with fgets, I get the=
 error :<br><br>Xenomai: binding failed: Operation not permitted.<br><br>I =
verified that the effective user for both commands is the same.<br><br>
This was working on xenomai 2.4.10<br>I added the user with pid 1000 alread=
y to the xenomai group but this doesn&#39;t work.<br><br>Does anyone know w=
hat the problem could be ?<br><br><br>Frederik<br>

--047d7b15ab85a11b8604be7e5362--

