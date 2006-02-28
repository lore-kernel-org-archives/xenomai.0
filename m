Date: Tue, 28 Feb 2006 07:29:54 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C029AC72.257D%steve@domain.hid>
In-Reply-To: <44046BF9.6090101@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

How is this an unusual design?

I have a sound driver in my system that updates a DAC every 125 us. Should I
not suspend the thread after it's done playing? What should the thread do,
call rt_task_wait_period() every 125us, and contribute to unnecessary
overhead? 

Steven

On 2/28/06 7:27 AM, "Jan Kiszka" <jan.kiszka@domain.hid> wrote:
> Sorry, wildly suspending a periodic thread remains a very unusual design
> in my eyes, and no RTOS should be hold responsible for this.
> 
> And "RTAI" is void argument: it's API has too many special
> characteristics anyway to take this as a reference for anything else
> than itself.


