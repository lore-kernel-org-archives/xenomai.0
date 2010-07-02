Message-ID: <4C2DF91B.5050202@domain.hid>
Date: Fri, 02 Jul 2010 16:35:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>	<1278071353-13836-8-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2DF5D6.3030607@domain.hid> <4C2DF732.30906@domain.hid>
	<4C2DF8F4.6040900@domain.hid>
In-Reply-To: <4C2DF8F4.6040900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 7/7] posix: Add some example code
	for	CLOCK_HOST_REALTIME
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
>> Jan Kiszka wrote:
>>> Wolfgang Mauerer wrote:
>>>> ... and for reading the contents of the hostrt data.
>>>>
>>> Just realized: Please also update clocktest. Should already work with
>>> the new clock ID, but requires a cosmetic output patch.
>> Yes, I thought about that. Maybe even if clocktest uses the new
>> clock_id, we could drop the example?
>>
>> I do not think it is a good idea to provide as an example code which
>> uses the internals of the implementation (though it makes sense to use
>> the implementation internals in the clocktest code). And if we remove
>> that, only clock_gettime(CLOCK_HOST_REALTIME) remains, which does not
>> seem to need an example.
>>
> 
> I would not keep it as an example, but as a test case for checking that
> nothing is wrong with the data on the shared page. Which does not fit
> quite well into clocktest. Although I have no problem with just omitting
> the stuff if reading the (internal) content of the data page is deemed
> inappropriate.

Well, I see nothing wrong with checking the internals at the beginning
of clocktest is the clockid passed to clocktest is CLOCK_HOST_REALTIME.
But Jan may have another opinion, since he is the one who wrote this code.


-- 
					    Gilles.

