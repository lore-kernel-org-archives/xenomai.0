From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] Error on rtdm skin with --enable-dox-doc
Date: Wed, 8 Mar 2006 15:03:18 -0300
References: <200603081421.10284.lbocseg@domain.hid> <440F15C9.1020509@domain.hid>
In-Reply-To: <440F15C9.1020509@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603081503.18409.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Em Quarta 08 Mar=3DE7o 2006 14:35, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Hi Jan,
>>
>> When compiling svn xenomai I noticed the following error with
>> --enable-dox-doc switch:
>>
>> CC [M]  kernel/xenomai/skins/rtdm/drvlib.o
>> kernel/xenomai/skins/rtdm/drvlib.c:1513:1: error: unterminated #ifdef
>
>I just passed this stage with trunk revision 671 without problems
>(doxygen 1.4.4). Moreover, there is no #ifdef or related preprocessor
>stuff in the latest drvlib.c at line 1513.

I think I still didn't learn how to use the svn tool. I downloaded xenomai=
=3D
=3D20
today with (xenomai dir already existed)
   svn co http://svn.gna.org/svn/xenomai/trunk xenomai
And I got 670 revision.
Then I renamed xenomai to xenomai.old and did the same command again. Then =
=3D
I=3D20
got the 671 revision and that is working fine with --enable-dox-doc.

Thanks,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


