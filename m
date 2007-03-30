Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Adeos-main] Porting to Intel IXP425
Date: Fri, 30 Mar 2007 16:33:08 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC60@domain.hid>
In-Reply-To: <460D1932.5010305@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

> The timer is aperiodic (most of the time) when running Xenomai, so
> __ipipe_mach_set_dec is called for each timer tick and programs the
> timer hardware for the next tick.

Okay, so does that mean that I should implement a "one-shot" timer, or
are we talking about resetting the periodic timer once in a while?

(BTW, in one-shot mode, the IXP425 timer does not do what the Developers
Manual, part 252480-006, says that it does!)

> __ipipe_mach_release_timer is called when Xenomai stops handling the
> timer and let Linux handle it.

But why does Xenomai do this? When unloading the module?


Richard


