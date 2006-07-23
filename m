Message-ID: <44C3E0A0.4060604@domain.hid>
Date: Sun, 23 Jul 2006 22:48:32 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_intr_create returns ENOSYS ?
References: <44C3CF5C.3010806@domain.hid> <44C3D581.1010101@domain.hid>
In-Reply-To: <44C3D581.1010101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Hannes Mayer wrote:
>> Hi all!
>>
>> Subject basically says it.
>>
>> I'm trying to do this:
>> err = rt_intr_create(&intr_desc, "parint", PARPORTINT, I_PROPAGATE);
>> in main() before spawning an RT tasks, but it fails with ENOSYS.
>> Xeno2.2, 2.4.32
>>
>> Any enlightenment very much appreciated!
> 
> CONFIG_XENO_OPT_NATIVE_INTR? It's default off now.

Yeah, works. Thanks! :-)

What's the reason for defaulting to off ?
Force users to write RTDM stuff ?

Tanti saluti,
Hannes.

