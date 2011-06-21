Message-ID: <4E007406.3060601@domain.hid>
Date: Tue, 21 Jun 2011 12:35:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=xprfSAwzV6g=GmC7q1sEUz4_t_g@domain.hid>	<4E005580.6010205@domain.hid>
	<BANLkTikdVgqFCXTqD4GarOahQEMLbrGyLg@domain.hid>
In-Reply-To: <BANLkTikdVgqFCXTqD4GarOahQEMLbrGyLg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unsupported arm machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/21/2011 11:14 AM, suresh reddy wrote:
> Dear Giles,
> 
> As far as i seen in the git  it seems that i have to patch all the files in
> xenomai-head  with my xenomai sources.

I do not understand your question. If you clone xenomai git repository, 
first, I would suggest cloning 2.5.x repository, then you have to 
follow the same installation instructions as the one you followed for 
the tarball.

If you prefer to patch xenomai 2.5.6 sources, the patches you need to 
apply are:
http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=3893f285f2dc4a8e877d23920788793a2fa317e4
http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=65cede2c06cd04673c72253e72611a36f6e2be80
http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=b694685509aba3df9f26d62115d90831d71bb859
http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=aeb9fe9169a378c1e586ca326d1f7071f9631880

> 
> Wil this fix all my issues that im facing now and in next steps

It will get the pandaboard running with CONFIG_SMP enabled. If you have
other issues, no, it will not do anything for them.

-- 
                                                                Gilles.

