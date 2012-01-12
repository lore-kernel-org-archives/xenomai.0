Message-ID: <4F0F3913.8080205@domain.hid>
Date: Thu, 12 Jan 2012 20:48:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W26DCAEABA1B068354C2E0AC49F0@domain.hid>
In-Reply-To: <BLU166-W26DCAEABA1B068354C2E0AC49F0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Question on preempting a linux task
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan-Erik Lange <jan0385@domain.hid>
Cc: xenomai@xenomai.org

On 01/12/2012 04:58 PM, Jan-Erik Lange wrote:
> 
> Hello,
> 
> Does the Xenomai scheduler has to interact with the Linux sheduler in
> order to preempt the tasks which are managed by it? Or is the Xenomai
> scheduler repealing the whole linux scheduler when it wants to run a
> task and and linux is running a task?
> 
> Best regards Jan

No, xenomai may preempt linux in the middle of almost anything, that is
the whole point of being based on the adeos patch. However, when a task
needs to change scheduler, the two schedulers have to cooperate. If you
are interested in the details, see xnshadow_relax and xnshadow_harden in
ksrc/nucleus/shadow.c in xenomai sources.

-- 
					    Gilles.

