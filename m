Message-ID: <4BCF22F1.6020504@domain.hid>
Date: Wed, 21 Apr 2010 18:08:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <k2xbfcfb7e81004210425l88dbbb99gb8b1ec4dd254300d@domain.hid>	
	<4BCEE8AC.4080101@domain.hid>
	<w2kbfcfb7e81004210905v507fbcf4oe20e1f695ddfd1aa@domain.hid>
In-Reply-To: <w2kbfcfb7e81004210905v507fbcf4oe20e1f695ddfd1aa@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [xeno_switchtest] missing linux-dev registration?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nero Fernandez <grimlynch@domain.hid>
Cc: xenomai@xenomai.org

Nero Fernandez wrote:
> Thanks, Jan, Gilles, for very prompt responses.

You are welcome. But please read them. Here are the two relevants two
exerpts from my original answer:

>> You are using Xenomai 2.5.2 right? switchtest is not working in
>> Xenomai 2.5.2 because RTDM syscalls were switchted do
>> __xn_exec_conforming. This gave birth to a long discussion, and
>> finally a commit to fix the issue. Xenomai 2.5 current head
>> contains this change.

And later:

>> It works here, are you sure you enabled the switchtest driver?

-- 
					    Gilles.

