Message-ID: <2ff1a98a0712170611q7a6174ejbd254d4827ecd673@domain.hid>
Date: Mon, 17 Dec 2007 15:11:44 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <530102.83624.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <530102.83624.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <trimarchimichael@domain.hid>
Cc: adeos-main@gna.org

On Dec 17, 2007 11:23 AM, Michael Trimarchi <trimarchimichael@domain.hid> wrote:
>
>
> Hi,
>
> >Wait a minute. You mean that you want more than 5000 interrupts by
> >second ? Are you sure you do not get overruns with plain, unpatched
> >Linux, if you load it sufficiently ?
> If you do a simple count ( 115200 bps ) considering buffer length = 1 the
> answer is yes.
>
> :)
>
> regards Michael
>
> PS work with linux

Do you observe this behaviour with I-pipe only or with Xenomai running
? If we xenomai, could you try only booting Linux with I-pipe enabled
?

-- 
                                               Gilles Chanteperdrix

