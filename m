Message-ID: <2ff1a98a0712111014l796d280eh583649a3c6a360c@domain.hid>
Date: Tue, 11 Dec 2007 19:14:34 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <632549.83925.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <632549.83925.qm@domain.hid>
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

On Dec 11, 2007 6:19 PM, Michael Trimarchi <trimarchimichael@domain.hid> wrote:
>
> Hi all,
>
> I prepare an adeos patch for the at91sam9260 and linux 2.6.22, and I test it
> with success. I reported only a problem with
> the serial drivers. I have overrun and I can't using it in interrupt mode
> with trasfer rate > 57600 using zmodem
> protocol. Is there any suggest?

Do you get the same behaviour with the "official" I-pipe patch ?

-- 
                                               Gilles Chanteperdrix

