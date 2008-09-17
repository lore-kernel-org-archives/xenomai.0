Date: Wed, 17 Sep 2008 16:26:03 +0200
Message-Id: <997471575@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xilinx and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi Phillipe

I have another Question about something, I asked a while ago.

>Joachim Meyer wrote:
>> Hi Phillipe
>>
>> Once you gave me a patch to add adeos support to the 2.6.23 Kernel from=
 Xilinx (see old Mail below).
>> I managed to install Xenomai correctly that time. I didn't made any fur=
ther tests than those from the testsuite, but they worked fine.
>> Here's my Question:
>>
>> What should I do if I want to use a newer Kernel Version at any time=3F I=
t would be nice to get rid of my dependency to Kernel 2.6.23, because of t=
he special patch.
>> Can you give me any information what I can do=3F Is it hard to fix a norm=
al adeos patch so it works for the Xilinx tree=3F
>>
>
>Adeos/powerpc patches are based on the DENX kernel tree, and looking at t=
he
>Xilinx tree, more conflicts are raised over time. I won't say that it's h=
ard to
>adapt the patch to the Xilinx tree, but the merge issues are not trivial
>anymore, like they were in 2.6.23.
>
>What would help is that more Xilinx bits are sent/merged to mainline or D=
ENX trees.

I realizes that there is a support for Xilinx Boards such as the ml300 at =
the mainline tree. I compiled the mainline tree successfully for my XUPV2P=
 and tried to use the xenomai-patch then. I used the newest (I believe 2.6=
.26) Kernel and the newest xenomai (2.4.5) version, so I tried the adeos-i=
pipe-2.6.26-powerpc-DENX-2.2-04.patch patch. Unluckily that failed. What w=
ould I have to do to get the patch working for my mainline tree=3F Will it w=
ork for my XUPV2P (Virtex 2 Pro) Board then=3F


Greetings & Thx
Joachim
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220


