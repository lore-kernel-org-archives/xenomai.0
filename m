Message-ID: <44C532B8.3070100@domain.hid>
Date: Mon, 24 Jul 2006 22:51:04 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_intr_create returns ENOSYS ?
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
To: xenomai@xenomai.org

Ciao Philippe!

Philippe Gerum wrote:
[...]
>>>> Any enlightenment very much appreciated!
>>> CONFIG_XENO_OPT_NATIVE_INTR? It's default off now.
>> Yeah, works. Thanks! :-)
>>
>> What's the reason for defaulting to off ?
>> Force users to write RTDM stuff ?
> 
> This gives a strong hint about what would be a good design decision when
> crafting a device driver over Xenomai: i.e. use RTDM.

Absolutely, but if one just wants to capture the parallel
port int, I think it's a little overkill to make a driver
for it.

Anyway, is that documented somewhere, that
CONFIG_XENO_OPT_NATIVE_INTR is default off now and that
folks should preferably make RTDM drivers now ?
I'd suggest to add that somewhere...

Tanti saluti,
Hannes.


