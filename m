Message-ID: <4C2F8589.1080006@domain.hid>
Date: Sat, 03 Jul 2010 20:46:33 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2DEF35.3000605@domain.hid> <4C2DFEDF.3030606@domain.hid>
	<4C2E0096.1020708@domain.hid>
In-Reply-To: <4C2E0096.1020708@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 0/7] Host realtime clock support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> Gilles Chanteperdrix wrote:
>>> Wolfgang Mauerer wrote:

>>> This update_vsyscall code would call ipipe_dispatch_event to pass the
>>> data to Xenomai.
>>>
>> okay. That seems to have dropped from my radar, as I don't recall having
>> any issues with this requirement.
> 
> I am sure that I always thought that it should be done this way. But
> maybe I did not say it... Sorry if that is the case.

you did say it, in fact. I looked at the interface, but seemingly
forgot to make this change. Will follow in the next submission.

Regards, Wolfgang

