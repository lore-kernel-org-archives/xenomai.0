Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF41FA2
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 08:10:29 +0000 (UTC)
Received: from [192.168.0.114] (mdb35-1_migr-88-125-107-19.fbx.proxad.net [88.125.107.19] (may be forged))
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 28L8AEPF027354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 21 Sep 2022 10:10:15 +0200
Date: Wed, 21 Sep 2022 10:10:08 +0200
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Subject: RE: How to debug realtime interrupt latency
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: xenomai@lists.linux.dev
Message-Id: <W0WJIR.40ADQJ6KBOD12@lapp.in2p3.fr>
In-Reply-To:
	<MN2PR11MB4285D42BBAAAC59B3A4A0869F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr>
	<MN2PR11MB42854F88BC212E32EA6D6885F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
	<CLOJIR.XNBWNAXO5BVE@lapp.in2p3.fr>
	<MN2PR11MB4285D42BBAAAC59B3A4A0869F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Le mer., sept. 21 2022 at 06:06:03 +0000, "Chen, Hongzhan"=20
<hongzhan.chen@intel.com> a =E9crit :
> It is not constant time but have little jitter. Xenomai timer=20
> interrupt handler would not cause such 10us+ large
> delay per my understanding. You can try latency test case which=20
> Xenomai project itself=20
> have(/usr/lib/xenomai/testsuite/latency,depending on your installing)
> on your platform to check latency value which includes timer=20
> interrupt handle latency and Xenomai schedule latency.

Thanks for the infos.

Cheers,

    Emmanuel.


