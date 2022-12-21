Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DB7E
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1671632976; bh=w40yyT614XNg4IZNkojQka30sy5gDAJa1PRojRdqVAQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=orWnkSQ27mraoIX5Zz3TLxqSQJl+e24JokEc/cec92UfP31CSu35qoJ5RJ6VClmpC
	 RxOpLTfdJAAWXc2MttK4mMTTjd259Nqbg2Ef6DllR0bqUpFdhWlmnlshfLcb0ycnbv
	 yG9btlcLItKZBiid9FQFm/sibRBUEy2OP/YE0ofeuPu01ZDAlFsLmtRavEHjV57+FL
	 xbqBn69WUKmKqnMwONVVQfH8ZdoHFhNAFaiOTLlvNEtuOsX9HRk+mIVqZZSuPF1CN5
	 iqX9RP5nK5S5OWuH6ugCwHJR2TeLqhx8mvPyBVzfXZN97H+ojSJOKkawwM1I3yhgUI
	 vlZXGUcjHPtTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([88.73.153.142]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgJM-1p34Qf3z1O-00EEoi; Wed, 21
 Dec 2022 15:29:36 +0100
Message-ID: <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
Date: Wed, 21 Dec 2022 15:29:35 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: "failed to allocate main tcb" error
Content-Language: en-US
To: "Mauro S." <mau.salvi@tin.it>, xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MhLEXGPL+vyzBLqTi4pdg/79c5g/YH6XPoRcbwhzGi/Kfudyfn4
 oCIzhJ7MC2fky1KE+YtJHCSF8dEWQIsfQCjRHjp/8OmOs/HTymeytsqCq3NLtlxgvagTK1p
 qp+grEVTQQVnlvNhUnTP+9oE5Rf8T4NEchGfjYq82X31tlBYe5abGPWl1iFkNDyRh13/xrJ
 Vkbg9fs4XojObagqgCiDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZEtyYyPOPlM=;mDRUoXmvGeG/r+wW+3RWRAEp69t
 +b/75p31PwdhBF4MbnvP+4PD0camiDOe4RHFClqfxaucxcwkFzvTi4Cb1j9wwCZ7640ALYF49
 ng1v2YnZYxM+a8idWzFfYkk/UiUBVxrVMy3/Kw8320/iNVDIYeNWY66mO6nwlnHOjeoTRkiFQ
 1Fy5Aodtph2w/pRl1nw2dB1eGoBJR7GP9bxwVbtigyL6XJnOSq1I7G8Zoo3ykypyHDC9MAuob
 r847kcnf0uIiCHp8yVNB3Iom6V5pj0PWDBoTdh0EQZBYrwMfzVr1V1eUNMtKpgfzYM8rvyA9R
 DJrAWXhFR+MyYQ/XU4PB9egS79g0QtjVEFwQl3EhY110PJ2Ef0pM1I6IFDsD1Hgci9K/IxBOW
 W0HO8xoT8ASwMVI4Fh427m7CYN7KiljbupjbU2eciqtNEo35Iqg+Teh93zfCTYTb+mxRCrO1V
 BkiY4/iLYfueaOOd/awv2k+qMzkb6siIcNhmzavrFJnL42gwj6mQXFC8svnYwgfWU4uMzS8Ip
 xoT0VgO2p+eq6+CJMU+yYbwKsJ7To5yMHpbk7C4XuvolatlDp90ci0T94w6beVN1iFDDMyZRU
 C/Nbyu2Ie3JRubBhV6vEFfn4HV8upNd4rcOob1puBvaIX0Ek6Bt+lf+Ho/rJvPToG7jb55eho
 4K9rqXVLLOB1PMaml9gdvRukxo85cGW8XDpq+9my0k6qZAxDhM3NjxIkk77xu9I8x40DFSubl
 MqMhK8TVM3iBIYSL6M9ROwIMvETtKz51qcMZWn3xUfFQQ7k3xIyeH9oQZu909d479KGr3cI6K
 UPdm9DV64SM7n7EJ3XZWimOpWONR0h6/NngVVkhtzSrMjNfXIaI8sf0p7Zi5WTRiO6EJ87xpL
 NoL8nYILipFLuPVI3hmS4vVfxuVK7OrgvJsDKilgREDzB6rXoI30ebnIotnWzaHpZ/b1t4H1p
 Nu3N5TUvxN0lYOmgrSTlOm22qDg=

On 21.12.22 10:05, Mauro S. wrote:
> Hi all,
>
> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with Copperplate and
> pshared enabled. Linux kernel is 5.4.181.
>
> I have a main application, and another service application that connects
> to the main one using shared session.
>
> After some time the main application is running, the service application
> stops to connect to the main one with the error
>
> =C2=A0=C2=A0=C2=A0 0"004.166| BUG in main_overlay(): [main] failed to al=
locate main tcb
>
> Digging a bit in the code, I found that the failing function is the
> xnmalloc() call in lib/copperplate/threadobj.c:__threadobj_alloc().
> If I understood correctly, this function tries to allocate some space
> from the shared heap. But the shared heap is almost free
>
> =C2=A0 # cat /proc/xenomai/heap
> =C2=A0=C2=A0=C2=A0 TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FREE=C2=A0 NAME
> =C2=A0 4194304=C2=A0=C2=A0 3616512=C2=A0 system heap
> =C2=A0 1048576=C2=A0=C2=A0 1041776=C2=A0 shared heap
> =C2=A0 1048576=C2=A0=C2=A0 1048480=C2=A0 private heap[14505]
> =C2=A0=C2=A0=C2=A0 36864=C2=A0=C2=A0=C2=A0=C2=A0 19968=C2=A0 xddp-pool@0
> =C2=A0=C2=A0=C2=A0 24576=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7680=C2=A0 xddp-p=
ool@10
>

This is the code that triggers the message:

        if (pthread_key_create(&threadobj_tskey, finalize_thread))
                early_panic("failed to allocate TSD key");

pthread_key_create has nothing to do with xnmalloc. That's a plain glibc
service, and its documentation says:

       The pthread_key_create() function shall fail if:

       EAGAIN The system lacked the necessary resources to create
another thread-specific data key, or the system-imposed limit on the
total number of keys per process {PTHREAD_KEYS_MAX} has been exceeded.

       ENOMEM Insufficient memory exists to create the key.

Already checked THOSE conditions? Are you possibly creating threads
without cleaning them up completely?

Jan

