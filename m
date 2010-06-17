MIME-Version: 1.0
In-Reply-To: <AANLkTikh-hjeotppDa6m2HB2EqUCMs8eL7iTjROzIeNE@mail.gmail.com>
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>
	<4C1353D8.2060507@domain.hid>
	<AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
	<AANLkTikvdlckp3H_yQyYOpjG9-mLx-3Qm5Z2mjLpKQIz@domain.hid>
	<AANLkTimlCliOasZWWbfgL1GzVby9RpFcIxWDCWSOYZbo@domain.hid>
	<AANLkTikh-hjeotppDa6m2HB2EqUCMs8eL7iTjROzIeNE@mail.gmail.com>
Date: Thu, 17 Jun 2010 15:49:01 +0800
Message-ID: <AANLkTinnpZFoTs5pxP5vkfdasG26cOGOvDAF4GKGHSW0@domain.hid>
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

Hi Jan and Luc,

Thanks for the helping suggestions. After reading from the manual, I
still have difficult
finding how to clear RX queue and overflow error. Nor how to purge the
read buffer. What are
the functions for these tasks?

Thanks,

Everett



On Tue, Jun 15, 2010 at 5:27 PM, Luc ANTOLINOS <luciogistr@domain.hid> wrote:
> On 15 June 2010 02:45, Everett Wang <everteq@domain.hid> wrote:
>> Hi,
>>
>> That is exactly correct. I can run my small program as long as I want, when I
>> first started my computer and load the module. But after I exit it by
>> press control-C,
>> I can't run it successfully. So it could be something my program does when it
>> exiting that sets the port in a strange state.
> Hi,
> - Just after opening the serial port, can you get the status with
> RTSER_RTIOC_GET_STATUS to be sure the uart driver reset the flags (it
> should).
> - If you purge the read buffer and try again to read (instead of
> exiting the program), is the error still here ? Is the error at the
> first read or at each read. In the line status bits, you have only
> RTSER_LSR_TRANSM_EMPTY , RTSER_LSR_THR_EMTPY,
> RTSER_LSR_OVERRUN_ER ? never Software overrun (just to confirm).
> - Have to tried to open,read,close 2 times in the same program instead
> of killing and running again the program ? You can then determine if
> it comes from the opening/closing routines ?
> - Can you also test by sending data from another computer for example
> (if possible) instead of directly from you GPS. Trying to determine if
> the problem is really the uart hardware or just sofware (your code or
> driver code).
>
> --
> Luc
>

