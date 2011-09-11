Message-ID: <4E6CC49C.1020403@domain.hid>
Date: Sun, 11 Sep 2011 16:24:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E6C927F.3070901@domain.hid>
In-Reply-To: <4E6C927F.3070901@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Policy switching and XNOTHER maintenance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 09/11/2011 12:50 PM, Jan Kiszka wrote:
> Hi all,
> 
> just looked into the hrescnt issue again, specifically the corner case
> of a shadow thread switching from real-time policy to SCHED_OTHER.

Doing this while holding a mutex looks invalid. If we do not do it, the
current code is valid.

-- 
                                                                Gilles.

