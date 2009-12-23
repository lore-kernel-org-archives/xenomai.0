Message-ID: <4B31EB70.3090108@domain.hid>
Date: Wed, 23 Dec 2009 11:05:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1261560352-9120-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1261560352-9120-3-git-send-email-wolfgang.mauerer@domain.hid>
	<4B31E503.8030208@domain.hid> <4B31EADB.8040305@domain.hid>
In-Reply-To: <4B31EADB.8040305@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] Testcase for the xnvdso mechanism
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Mauerer wrote:
>>> This testcase checks if the value in xnvdso->features matches the
>>> value of XNVDSO_FEATURES, that is, if the information is correctly
>>> transferred from kernel to userland.
>>>
>>> Notice that the approach will fail once configurations are supported
>>> that know of multiple features and implement only some of them.
>>> In this case, the testcase needs to be extended accordingly
>>> to check that only the expected features are present.
>> Please allow to pass the value we want to check on the test command line.
> 
> here you go. I suppose keeping XNVDSO_FEATURES as default value
> unless something different is specified is okay?

Yes, ok. I am fine with the two patches.

-- 
					    Gilles.

