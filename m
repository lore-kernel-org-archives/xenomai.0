Message-ID: <4CAB000D.40809@domain.hid>
Date: Tue, 05 Oct 2010 12:38:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CAAF0CA.7060603@domain.hid> <4CAAF648.8000001@domain.hid>
	<4CAAFD2D.4050004@domain.hid> <4CAAFEC6.5010607@domain.hid>
In-Reply-To: <4CAAFEC6.5010607@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Overcoming the "foreign" stack
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Am 05.10.2010 12:32, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>>  - consistent view on the system (if current is always valid, there are
>>    no more confusions between current Linux vs. Xenomai task)
> 
> That is inherently incompatible with the co-kernel approach. Xenomai
> will always be able to preempt Linux at a place where the state is not
> consistent.

Depends on what state the trace examines and what it derives from it.
The current task or the current preemption counter are definitely not
critical and can easily be provided in a way that make tracer output
consistent. In the end, shadow tasks are Linux tasks in a special mode.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

