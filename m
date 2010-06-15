MIME-Version: 1.0
In-Reply-To: <AANLkTimlCliOasZWWbfgL1GzVby9RpFcIxWDCWSOYZbo@domain.hid>
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid> 
	<4C1353D8.2060507@domain.hid>
	<AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid> 
	<AANLkTikvdlckp3H_yQyYOpjG9-mLx-3Qm5Z2mjLpKQIz@domain.hid> 
	<AANLkTimlCliOasZWWbfgL1GzVby9RpFcIxWDCWSOYZbo@domain.hid>
From: Luc ANTOLINOS <luciogistr@domain.hid>
Date: Tue, 15 Jun 2010 11:27:51 +0200
Message-ID: <AANLkTikh-hjeotppDa6m2HB2EqUCMs8eL7iTjROzIeNE@mail.gmail.com>
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

On 15 June 2010 02:45, Everett Wang <everteq@domain.hid> wrote:
> Hi,
>
> That is exactly correct. I can run my small program as long as I want, when I
> first started my computer and load the module. But after I exit it by
> press control-C,
> I can't run it successfully. So it could be something my program does when it
> exiting that sets the port in a strange state.
Hi,
- Just after opening the serial port, can you get the status with
RTSER_RTIOC_GET_STATUS to be sure the uart driver reset the flags (it
should).
- If you purge the read buffer and try again to read (instead of
exiting the program), is the error still here ? Is the error at the
first read or at each read. In the line status bits, you have only
RTSER_LSR_TRANSM_EMPTY , RTSER_LSR_THR_EMTPY,
RTSER_LSR_OVERRUN_ER ? never Software overrun (just to confirm).
- Have to tried to open,read,close 2 times in the same program instead
of killing and running again the program ? You can then determine if
it comes from the opening/closing routines ?
- Can you also test by sending data from another computer for example
(if possible) instead of directly from you GPS. Trying to determine if
the problem is really the uart hardware or just sofware (your code or
driver code).

-- 
Luc

