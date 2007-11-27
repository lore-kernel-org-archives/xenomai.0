Message-ID: <474C5592.3030203@domain.hid>
Date: Tue, 27 Nov 2007 18:36:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D3285C8@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3285C9@domain.hid>
	<47373710.1030400@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3285CB@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3285CB@slcmail.slc.mew.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] more geode issues
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> 
> On 2.6.22.2, if I load native it fixes the fast interrupt problem. On
> 2.6.23, the interrupts slow down by a factor of 10. Unloading
> xeno_native on both systems yields correct interrupt behavior even with
> the nucleus loaded.

>From your description, I understand that:

...boot...
# modprobe xeno_nucleus => fast timer
# modprobe xeno_native => slow timer
# rmmod xeno_native => timer ticks normally

Is that correct?

-- 
Philippe.

