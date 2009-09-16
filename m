MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <9c789a000909160114h4a3b5ebbj46e1abfeed07f61c@domain.hid>
References: <9c789a000909130535j4dc046a1h3af2976ab504a000@domain.hid>
	<72cf3fb0909151542h163e7c03h1a393a969caf0c58@domain.hid>
	<9c789a000909160114h4a3b5ebbj46e1abfeed07f61c@domain.hid>
Date: Thu, 17 Sep 2009 00:26:02 +0200
Message-ID: <72cf3fb0909161526i5eb3178cnc2e9c7e154f624ef@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Comedi port over Xenomai fault question !
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Hi,

>
> I've applied the debug patches and I think that the problem is in the
> ni_release_ai_mite_channel function because it seems that
> mite_release_channel is never called.
> It is possible that comedi_lock_irqsave to cause the problem or
> devpriv->ai_mite_chan is NULL ?
>

You can remove comedi_lock_irqsave/restore, they are not critical. And
you can proceed on adding some debug traces so as to check
ai_mite_chan.

I will double check, the mite "init" function.

Alexis.

