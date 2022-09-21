Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2B1FA2
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 08:13:06 +0000 (UTC)
Received: from [192.168.0.114] (mdb35-1_migr-88-125-107-19.fbx.proxad.net [88.125.107.19] (may be forged))
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 28L8D23v027610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 21 Sep 2022 10:13:03 +0200
Date: Wed, 21 Sep 2022 10:12:56 +0200
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Subject: Re: How to debug realtime interrupt latency
To: Adam Vaughan <vaughana@umich.edu>
Cc: xenomai@lists.linux.dev
Message-Id: <K5WJIR.8LRLRK0ZIBXL3@lapp.in2p3.fr>
In-Reply-To: <CC98B933-D223-4B7C-B3A9-7A1209EEDE46@umich.edu>
References:
	<MN2PR11MB4285D42BBAAAC59B3A4A0869F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
	<CC98B933-D223-4B7C-B3A9-7A1209EEDE46@umich.edu>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Le mer., sept. 21 2022 at 00:10:31 -0700, Adam Vaughan=20
<vaughana@umich.edu> a =C3=A9crit :
> Good luck finding the cause Emmanuel!!  These things can be so=20
> difficult and time consuming to debug.
>=20
> It=E2=80=99s a totally different platform (Raspberry Pi, years ago), but=20
> here=E2=80=99s an example real-time latency debug that was ultimately=20
> traced to the DRAM refresh initialization in closed source firmware=20
> drivers:
>=20
> https://github.com/raspberrypi/firmware/issues/497
>=20
> It may help to use an oscilloscope in infinite persistence on your=20
> signals like the above link.  The oscilloscope also helped find bugs=20
> in the USB driver affecting latency back then for me.
>=20
> I hope your root cause is easier to find! =F0=9F=A4=9E

Maintaining our real time stack for 16 years now, I had my share of=20
tedious latency issue debugging :) I hope I will find the root of this=20
one.

Cheers,

    Emmanuel.


