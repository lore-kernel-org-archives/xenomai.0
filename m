Message-ID: <488D97C5.2000200@domain.hid>
Date: Mon, 28 Jul 2008 11:56:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200807230917.m6N9H0tZ028205@domain.hid>	<48876738.2020403@domain.hid>
	<62F740A83B064CF6B1494D0A12EFFBF6@domain.hid>
In-Reply-To: <62F740A83B064CF6B1494D0A12EFFBF6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Errors while static linking of Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christian Volk <linux.kernel@domain.hid>
Cc: xenomai@xenomai.org

Christian Volk wrote:
> During the day we found a "workaround" or maybe a fix.
> I will post details tomorrow from work.
> We used -Wl,"-(" archives -Wl,"-)" so we built a start-group - end-group
> Construct which fixed all issues.
> 
> Thanks for your answer Philippe, this will help me while creating my own
> apps.

It would be interesting if we could apply your fix to Xenomai makefiles.
Could you give us a little bit more details ?

-- 
                                                 Gilles.

