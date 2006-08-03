Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 Aug 2006 11:50:02 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A46D9C5@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] Xenomai POSIX-libraries
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

Can anybody tell me how the POSIX-Libraries are build. I had a look on =
various scripts and makefiles but I don=B4t understand the mechanism.
I am asking, as I have the feeling, my POSIX-Library is not correct.
Although the xeno_posix.o file in the Linux/kernel/xenomai/skins/posix =
directory includes all functions from the (xenomai)thread_attr.c file =
(e.g.: pthread_attr_setname_np), the posix-libraries in the =
Xenomai/install/lib directory (created by make install) do not include =
all functions (explicitly pthread_attr_setname_np is not included) where =
did I lose them ? Are the libraries in my install directory the correct =
ones, where do they come from ???

Sorry, but the building process is too complex for a normal mortal like =
me. Perhaps somebody can give me a helping hand.

Thank you in advance
Roderik=20

