Message-ID: <75975c320608231300t30cf5e69u7a629887d9163e40@domain.hid>
Date: Wed, 23 Aug 2006 16:00:47 -0400
From: "Paul Ianna" <paulianna2002@domain.hid>
Subject: Re: [Xenomai-help] primary mode versus secondary mode
In-Reply-To: <1156192960.4321.70.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <75975c320608211235l79dfb17ft54df1018e7f597ff@domain.hid>
	<75975c320608211321u5b2d9e45nfb078e9ed4d8b617@domain.hid>
	<1156192960.4321.70.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 8/21/06, Philippe Gerum <rpm@xenomai.org> wrote:
> Also have a look at /proc/xenomai/stats when your application runs, the
> MSW field (i.e. Mode SWitches) counts the number of transitions for each
> Xenomai thread. This value should not increase over time, at least for
> latency critical threads.

Thanks Philippe, very useful.

Could you also explain the CSW, PF, and STAT fields?

Thanks,
Paul

