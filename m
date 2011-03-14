From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D7DF910.5000706@domain.hid>
References: <4D7DF910.5000706@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Mar 2011 14:17:32 +0100
Message-ID: <1300108652.2105.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnshadow_call_mayday no signal_handler call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: johann.obermayr@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2011-03-14 at 12:16 +0100, Johann Obermayr wrote:
> Hello,
> 
> if i call xnshadow_call_mayday for a realtime task with prio=0, the 
> signal_handler
> is not called.

It does not make sense to call it for such thread. Besides,
xnshadow_call_mayday() is an internal interface, with strict calling
context requirements, so you are not supposed to use it at all.

> 
> Xenomai 2.5.6, linux kernel 2.6.32.15. gcc 4.3.3
> 

-- 
Philippe.



