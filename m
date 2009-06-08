Message-ID: <4A2D766A.6000606@domain.hid>
Date: Mon, 08 Jun 2009 22:36:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01A4598F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01A4598F@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> sorry for the delayed answer. Yes and no: The restriction of a page
> aligned SHM-size seems to be abolished (I didn=C2=B4t get the error
> message "No such device or address" any more). But my target still
> stalls, when I kill my test applications in the wrong order. For your
> convenience I appended the test again (start "killtest -c &" then
> "killtest &" and then kill the last one before the first).

Do you get this with a 2.4 or a 2.6 kernel?

--=20
					    Gilles.


