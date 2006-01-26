Message-ID: <43D8AF10.4030106@domain.hid>
Date: Thu, 26 Jan 2006 12:14:24 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] Missing DESTDIR?
References: <43D8A891.2030700@domain.hid>
In-Reply-To: <43D8A891.2030700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Anders Blomdell wrote:
> in a lot of the Makefile.in files in 2.1-rc2 there are lines like:
> 
>   test -z "$(somedir)" || $(mkdir_p) "$(DESTDIR)$(somedir)"
> 
> shouldn't they read:
> 
>   test -z "$(DESTDIR)$(somedir)" || $(mkdir_p) "$(DESTDIR)$(somedir)"
Forget that, confused -z with -d (tired I suppose...)

Best regards

/Anders

