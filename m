Message-ID: <4E5DDDF6.6030700@domain.hid>
Date: Wed, 31 Aug 2011 09:08:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E5DDA3F.9090904@domain.hid>
In-Reply-To: <4E5DDA3F.9090904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task handle status after delete
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 08/31/2011 08:52 AM, Roberto Bielli wrote:
> Hi,
> 
> it's ok to call rt_task_inquire after the task is deleted or the rt_task 
> handle is invalid after a rt_task_delete ?

The rt_task handle is invalid after rt_task_delete, the only thing which
will work is rt_task_join if the task was created joinable.


-- 
					    Gilles.

