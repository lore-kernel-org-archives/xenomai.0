Message-ID: <4E3111A7.1040207@domain.hid>
Date: Thu, 28 Jul 2011 09:37:11 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4E16296B.4080209@domain.hid> <4E1B4438.6030600@domain.hid>
	<4E2EAE69.7030008@domain.hid> <4E305F1C.9010608@domain.hid>
In-Reply-To: <4E305F1C.9010608@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 27/07/11 20:55, Gilles Chanteperdrix wrote:
> The issue has been investigated, as explained in the mail you are
> quoting, it seems to be due to the implementation of pseudo-signals
> which as in xenomai 2.5 code and no longer is in xenomai-head code.
> 
> In order to get confirmation, I am still waiting for someone to test
> xenomai-head with gcc 4.6.

Thank you Gilles.

I was checking if any confirmation of the cause of the bug was given,
just to not waste the limited time I have to test this performing a test
with known results. I'll compile xenomai-head with gcc 4.6 and report my
results.

Cheers,
-- 
Daniele

