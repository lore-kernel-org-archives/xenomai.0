Message-ID: <49BF679B.9060102@domain.hid>
Date: Tue, 17 Mar 2009 10:04:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E0083B93-4ADC-4AA1-9FA2-67E6481AFEA5@domain.hid>
In-Reply-To: <E0083B93-4ADC-4AA1-9FA2-67E6481AFEA5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Disabling/Limiting Kernel panic messages
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Alphan Ulusoy wrote:
> Hi!
> 
> Is there a way to disable or limit the messages printed on the screen in
> case of kernel panic? I'm working with an old monitor and the messages
> scroll off the screen and I'm left with irrelevant info. I would prefer
> to use my prink()'s.
> 
> 
> P.S. I've already posted this question to several forums and did not
> receive any replies. Hopefully someone can help me.
> 

Use a serial console or netconsole to push kernel messages from your
target to a logging host. That way you can even debug headless boxes.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

