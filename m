Message-ID: <48F7A1A2.3050201@domain.hid>
Date: Thu, 16 Oct 2008 22:18:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>
	<20081016154621.802426487@domain.hid>
In-Reply-To: <20081016154621.802426487@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 09/12] Optionally replace
 pthread_getspecific with TLS variables
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

The real downside here is a lot of #ifdef clutter. What about the idea
of defining an API to abstract the differences between
pthread_get/setspecific and __thread and have #ifdef only in one header ?

-- 
					    Gilles.

