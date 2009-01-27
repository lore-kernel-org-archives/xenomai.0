Message-ID: <497F6524.2080601@domain.hid>
Date: Tue, 27 Jan 2009 20:48:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC] FPU support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>


Hi,

having to work on twice consecutive FPU issues made me think a bit about
the situation of FPU support in Xenomai.

What makes our FPU support code so complex? It is the fact that we
support eager FPU context save/restore for both user-space and
kernel-space real-time threads which ask it while running side by side
with a kernel which supports on-demand FPU for user-space threads.

If we only supported on-demand FPU for user-space thread, we could
probably get rid of most of the FPU switching code, we would just have
to iron Linux FPU trap code (which is already mostly done) and maybe add
some code saving the FPU context during the context switches on SMP
machines, not a big deal.

>From a performance point of view, the difference between on-demand FPU
and eager FPU switching is that on-demand FPU switching requires a trap,
so you have to pay this overhead once every activation of your real-time
task using FPU. Other than that, on-demand FPU actually reduces the
dispatch latency of user-space threads not using FPU.

So, the question is: are there people around who either:
- need FPU support for kernel-space real-time threads;
- do not want to pay the price of a trap when using the FPU in user-space.

If you are in that case, please answer to this mail. Note that if you do
not want everyone to read your answer, you can answer privately.

Please also note that this support will not be removed just right now, I
really plan to solve the pending issues, and to have an FPU support with
no known bugs for the next release.

Regards.

-- 
					    Gilles.

