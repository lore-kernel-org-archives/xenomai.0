Message-ID: <4D95A1CE.7010009@domain.hid>
Date: Fri, 01 Apr 2011 11:58:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A537C502-9185-43A0-999B-A2DB8583008E@edu.hefr.ch>
	<4D959B95.4060006@domain.hid>
	<1048D583-68E6-4D7C-9A56-FBE68FCFA751@domain.hid>
In-Reply-To: <1048D583-68E6-4D7C-9A56-FBE68FCFA751@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] process on linux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: davide doninelli <Davide.Doninelli@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

davide doninelli wrote:
> ok, two more questions...
> What's main thread and manager thread roles?

The main thread is the one running the "main" function.

The manager thread is something internal to linuxthreads, so, if it is
documented somewhere, it must be in some documentation related to
linuxthreads.

Note that all this is not at all specific to Xenomain, so, this mailing
list is not the best place to ask these questions.

-- 
					    Gilles.

