MIME-Version: 1.0
In-Reply-To: <AANLkTikvdlckp3H_yQyYOpjG9-mLx-3Qm5Z2mjLpKQIz@domain.hid>
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>
	<4C1353D8.2060507@domain.hid>
	<AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
	<AANLkTikvdlckp3H_yQyYOpjG9-mLx-3Qm5Z2mjLpKQIz@domain.hid>
Date: Tue, 15 Jun 2010 08:45:02 +0800
Message-ID: <AANLkTimlCliOasZWWbfgL1GzVby9RpFcIxWDCWSOYZbo@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] error on rt_dev_read, code Success,
	what does it 	mean?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luc ANTOLINOS <luciogistr@domain.hid>
Cc: xenomai@xenomai.org

Hi,

That is exactly correct. I can run my small program as long as I want, when I
first started my computer and load the module. But after I exit it by
press control-C,
I can't run it successfully. So it could be something my program does when it
exiting that sets the port in a strange state.

Everett

On Mon, Jun 14, 2010 at 10:53 PM, Luc ANTOLINOS <luciogistr@domain.hid> wrote:
> On 12 June 2010 12:13, Everett Wang <everteq@domain.hid> wrote:
>> get a " code input/output error". That is better. What can cause
>> input/output error? I get my serial port in that state consistently
>> when I
>> finish running my GPS program. I can reset it to a usable serial port
>> again by remove and re-load xeno-16550A module. But setserial -G can't
>> see anything unusual. Could it be some unclosed serial port?
> Hi,
> Does this error appear while running or only after exiting (no error
> while running the first time after reloading the module) ?
>
> --
> Luc
>

