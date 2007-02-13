Message-ID: <45D17E4B.6080502@domain.hid>
Date: Tue, 13 Feb 2007 10:00:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>	<45D029B8.1030805@domain.hid>	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>	<45D0666C.8070409@domain.hid>
	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
In-Reply-To: <e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Preetam Joshi <j.preetam@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Preetam Joshi wrote:
> Hi the libnative error is solved but know when i make it gives me error
> stating:
> 
> Makefile:312: .deps/mytask-mytask.Po: No such file or directory
> make: *** No rule to make target `.deps/mytask-mytask.Po'.  Stop.

This should only happen if you have played with the autotools. Go to the
top of the build tree and type :

./config.status depfiles

-- 
                                                 Gilles Chanteperdrix

