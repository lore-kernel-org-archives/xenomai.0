From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17369.699.768458.672394@domain.hid>
Date: Thu, 26 Jan 2006 18:11:23 +0100
Subject: Re: [Xenomai-core] Sigevent, sigaction
In-Reply-To: <353F6272FE0A6544AA97D47F761F486B01707E91@domain.hid>
References: <353F6272FE0A6544AA97D47F761F486B01707E91@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Doyle, Alan" <alan.doyle@domain.hid>
Cc: xenomai@xenomai.org

Doyle, Alan wrote:
 > I've downloaded Xenomai-2.0.3 and have been lookingh into signal
 > handling. Structs sigevent & sigaction are used in the code but I can't
 > find where they are declared. Can anyone help ?

They come from linux/signal.h in kernel-space and signal.h in user-space.

-- 


					    Gilles Chanteperdrix.

