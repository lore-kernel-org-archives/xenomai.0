MIME-Version: 1.0
In-Reply-To: <AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid> 
	<4C1353D8.2060507@domain.hid>
	<AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
From: Luc ANTOLINOS <luciogistr@domain.hid>
Date: Mon, 14 Jun 2010 16:53:22 +0200
Message-ID: <AANLkTikvdlckp3H_yQyYOpjG9-mLx-3Qm5Z2mjLpKQIz@domain.hid>
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
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

On 12 June 2010 12:13, Everett Wang <everteq@domain.hid> wrote:
> get a " code input/output error". That is better. What can cause
> input/output error? I get my serial port in that state consistently
> when I
> finish running my GPS program. I can reset it to a usable serial port
> again by remove and re-load xeno-16550A module. But setserial -G can't
> see anything unusual. Could it be some unclosed serial port?
Hi,
Does this error appear while running or only after exiting (no error
while running the first time after reloading the module) ?

-- 
Luc

