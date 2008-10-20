Message-ID: <48FCEB70.7030808@domain.hid>
Date: Mon, 20 Oct 2008 22:34:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid> <48FCE40C.1080100@domain.hid>
In-Reply-To: <48FCE40C.1080100@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Warning when compiling trunk.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> I get this warning when compiling trunk:
>>
>> checking for __thread... rm: cannot remove `conftest1.dir': Is a directory
>> yes
>>
> 
> That simple, it's a typo in this line:
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/configure.in?v=SVN-trunk#394
> 
> Also, that rm should be done outside the if block to play safe.

Ok. But once this is fixed, I get a segmentation fault with __thread on
ARM in rt_task_trampoline. I am currently testing the SIGWINCH thing,
and if __thread is disabled, there is no segfault.

-- 
					    Gilles.

