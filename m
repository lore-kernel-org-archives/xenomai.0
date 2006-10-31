Subject: Re: [Xenomai-help] Xenoami Kernel Configuration Description
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D625@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D625@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 16:33:38 +0100
Message-Id: <1162308819.4996.109.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 12:02 +0000, Daniel Schnell wrote:

> Some of these are self explanatory but most of them not. Especially I
> am interested about the magic number tuning options like heap size,
> number of registry slots, number of pipe devices etc. and how they
> correlate to the behaviour or limitations of the other parts.
>  
> Is there any documentation already available ?
>  

Those options are documented in the 2.6.x Kconfig help strings for
Xenomai. See ksrc/nucleus/Kconfig.

-- 
Philippe.



