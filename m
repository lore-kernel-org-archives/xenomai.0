Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <55C495D6.2070706@xenomai.org>
Date: Fri, 7 Aug 2015 08:43:55 -0400
Message-Id: <06B32287-9FE2-42E5-BC2B-E9C807D0BD69@gatech.edu>
References: <55C17C8E.5000909@gatech.edu> <55C3AEBE.9080603@xenomai.org>
 <55C3C3F8.1090808@gatech.edu> <55C3C7F4.1030107@xenomai.org>
 <12F45B9B-70C3-4278-BA0E-DFC26E19DBF0@gatech.edu>
 <55C495D6.2070706@xenomai.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>> I did - and it turns out the error was due to this line:
>>=20
>> __debug("Calibrating AI: %s \n", cal_info[i]);
>>=20
>> changing this to:
>>=20
>> __debug("Calibrating AI: %s \n", cal_info[i].message);
>=20
> I already sent you a patch for this

This patch needs to be applied to 3.0-rc6.

> can you send the calibration file please?

attached.



I spent some more time digging at the code. The insn_read process hangs =
at a4l_read_calibration_file because when the for loop (line 214) runs =
the second time, it does not find the string =E2=80=9Celements=E2=80=9D, =
and thus sets nb_elements to 65535 - causing it to run forever.

This is because it is looking for the elements string under =
=E2=80=9Canalog_output=E2=80=9D in the calibration file, however there =
is no such section in the calibration file.=20

The calibration file also doesn=E2=80=99t include all the analog inputs =
(it only shows 7, whereas the board has 16 AIs. So does the PCI 6220). =
What am I missing/not understanding?

>>=20
>> Yogi
>>=20
>>=20
>=20
> --=20
> jro

Yogi

