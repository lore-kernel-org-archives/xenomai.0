Message-ID: <2ff1a98a0712060848j4822e7eal5f8d3b8ba8dc6772@domain.hid>
Date: Thu, 6 Dec 2007 17:48:31 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375FC2@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D375FC2@domain.hid>
Subject: Re: [Xenomai-help] more watchdog stuff
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

On Dec 6, 2007 5:41 PM, Steven Seeger
<sseeger@domain.hid> wrote:
>
>
>
>
> Can a Xenomai thread running in the secondary domain cause the watchdog
> timer to kill it?

No, this one will be caught by Linux soft-lockup detector.

> Also, how hard would it be to modify the watchdog system to give timing
> requirements in resolutions better of 1 second?

I guess the resolution of 1 second was chosen because it allows the
watchdog to have a very low overhead, but this can be changed easily.

-- 
                                               Gilles Chanteperdrix

