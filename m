Message-ID: <4E1B15F7.7090003@domain.hid>
Date: Mon, 11 Jul 2011 16:25:43 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4E16296B.4080209@domain.hid>
In-Reply-To: <4E16296B.4080209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails
 with	ENOSYS)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On 07/07/11 22:47, Anders Blomdell wrote:
> When compiling kernel 2.6.37.3 and xenomai 2.5.6 with "gcc version 4.6.0 
> 20110530 (Red Hat 4.6.0-9) (GCC)", programs fail with -ENOSYS in 
> rt_task_shadow. If compiled with "gcc version 4.5.1 20100924 (Red Hat 
> 4.5.1-4) (GCC)" everything works as expected.

I just want to note that I encountered the same problem on Debian
testing. Unfortunately I can not provide more details right now (I'm at
the Amaldi9 conference in Cardiff, any Xenomai dev or user around?)

Cheers,
-- 
Daniele

