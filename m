Message-ID: <4E305C93.6010000@domain.hid>
Date: Wed, 27 Jul 2011 20:44:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E2527B2.3030305@domain.hid>
In-Reply-To: <4E2527B2.3030305@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Fixes for domain migration races
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/19/2011 08:44 AM, Jan Kiszka wrote:
> Hi,
> 
> I've just uploaded my upstream queue that mostly deals with the various
> races I found in the domain migration code.
> 
> One of my concerns raised earlier turned out to be for no reason: We do
> not allow Linux to wake up a task that has TASK_ATOMICSWITCH set. So the
> deletion race can indeed be fixed by the patch I sent earlier.

So, I still have the same question: is not the solution of synchronizing
with the gatekeeper as soon as we get out from schedule in secondary
mode better than waiting the task_exit callback? It looks more correct,
and it avoids gksched.

-- 
                                                                Gilles.

